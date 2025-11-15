class EkvipediaContentEntries {
  final Sys? sys;
  final int? total;
  final int? skip;
  final int? limit;
  List<EntryItem>? items;
  final Includes? includes;

  EkvipediaContentEntries({
    this.sys,
    this.total,
    this.skip,
    this.limit,
    this.items,
    this.includes,
  });

  factory EkvipediaContentEntries.fromJson(Map<String, dynamic> json) {
    return EkvipediaContentEntries(
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
      total: json['total'] as int?,
      skip: json['skip'] as int?,
      limit: json['limit'] as int?,
      items: (json['items'] as List<dynamic>?)?.map((e) => EntryItem.fromJson(e as Map<String, dynamic>)).toList(),
      includes: json['includes'] != null ? Includes.fromJson(json['includes'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sys': sys?.toJson(),
      'total': total,
      'skip': skip,
      'limit': limit,
      'items': items?.map((e) => e.toJson()).toList(),
      'includes': includes?.toJson(),
    };
  }

  static String? getFaturedImageURL(EntryItem? item, Includes? includes, {bool? isTopic = false}) {
    if (item == null || includes == null) return null;
    String? imageId;
    if (isTopic != null && isTopic) {
      imageId = (item.fields['image']?['sys']?['id']) as String?;
    } else {
      imageId = (item.fields['featuredImage']?['sys']?['id']) as String?;
    }

    Asset? imageAsset = includes.assets.firstWhere(
      (asset) => asset.sys.properties['id'] == imageId,
      orElse: () => Asset(
        metadata: Metadata(properties: {}),
        sys: Sys(properties: {}),
        fields: {},
      ),
    );

    return imageAsset.fields['file']?['url'] != null ? "https:${imageAsset.fields['file']?['url']}" : null;
  }

  static Map<String, SubtopicGroup> groupArticlesBySubtopic(EkvipediaContentEntries entries) {
    Map<String, SubtopicGroup> grouped = {};

    for (var article in entries.items ?? []) {
      final String? subtopicId = article.fields["subTopic"]?["sys"]?["id"];
      final String? subtopicName = _getSubtopicNameById(subtopicId, entries);

      if (subtopicName != null) {
        if (!grouped.containsKey(subtopicName)) {
          grouped[subtopicName] = SubtopicGroup(
            articles: [],
            includes: entries.includes!,
          );
        }

        grouped[subtopicName]!.articles.add(article);
      }
    }

    grouped.forEach((key, subtopicGroup) {
      subtopicGroup.articles.sort((a, b) {
        String? dateStringA = a.fields['date'] as String?;
        String? dateStringB = b.fields['date'] as String?;

        // Handle null cases
        if (dateStringA == null && dateStringB == null) return 0;
        if (dateStringA == null) return 1; // Place articles with null dates at the end
        if (dateStringB == null) return -1; // Place articles with null dates at the end

        // Parse the date strings into DateTime objects
        DateTime dateA = DateTime.parse(dateStringA);
        DateTime dateB = DateTime.parse(dateStringB);

        // Compare the dates in descending order
        return dateB.compareTo(dateA);
      });
    });
    return grouped;
  }

  static String? _getSubtopicNameById(String? subtopicId, EkvipediaContentEntries entries) {
    if (subtopicId == null) return null;
    return entries.includes?.entries
        .firstWhere(
          (entry) => entry.sys.properties["id"] == subtopicId,
          orElse: () => EntryItem(
            sys: Sys(properties: {}),
            fields: {},
            metadata: Metadata(properties: {}),
          ),
        )
        .fields["name"] as String?;
  }

  static EntryItem? getIncludesEntryById(String entryId, Includes? includes) {
    // log(entryId);
    if (entryId.isEmpty || includes == null) return null;

    // Find the entry with the matching ID
    EntryItem? entry = includes.entries.firstWhere(
      (entry) => entry.sys.properties['id'] == entryId,
      orElse: () => EntryItem(
        sys: Sys(properties: {}),
        fields: {},
        metadata: Metadata(properties: {}),
      ),
    );

    // Return null if the entry is empty
    // log(entry.sys.properties.toString());
    return entry.sys.properties.isNotEmpty ? entry : null;
  }

  static String? getEntryCategory(EntryItem? entry) {
    return entry?.sys.properties["contentType"]["sys"]["id"];
  }

  /// Function to fetch an asset by ID from the includes section
  static Asset? getAssetById(String assetId, Includes? includes) {
    if (assetId.isEmpty || includes == null) return null;

    // Find the asset with the matching ID
    Asset? asset = includes.assets.firstWhere(
      (asset) => asset.sys.properties['id'] == assetId,
      orElse: () => Asset(
        sys: Sys(properties: {}),
        fields: {},
        metadata: Metadata(properties: {}),
      ),
    );

    // Return null if the asset is empty
    return asset.sys.properties.isNotEmpty ? asset : null;
  }

  static List<String> getTags(EntryItem? item, Includes? includes) {
    if (item == null || includes == null) return [];
    List<dynamic>? tagLinks = item.fields['tags'] as List<dynamic>?;

    if (tagLinks == null) return [];

    List<String> tags = [];

    for (var tagLink in tagLinks) {
      String? tagId = (tagLink['sys']?['id']) as String?;

      if (tagId == null) continue;

      EntryItem? tagEntry = includes.entries.firstWhere(
        (entry) => entry.sys.properties['id'] == tagId,
        orElse: () => EntryItem(
          sys: Sys(properties: {}),
          fields: {},
          metadata: Metadata(properties: {}),
        ),
      );

      String? tagName = tagEntry.fields['name'] as String?;

      if (tagName != null) {
        tags.add(tagName);
      }
    }

    return tags;
  }
}

class Sys {
  final Map<String, dynamic> properties;

  Sys({required this.properties});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(properties: json);
  }

  Map<String, dynamic> toJson() {
    return properties;
  }
}

class EntryItem {
  final Metadata metadata;
  final Sys sys;
  final Map<String, dynamic> fields; // Dynamic fields map

  EntryItem({
    required this.metadata,
    required this.sys,
    required this.fields,
  });

  factory EntryItem.fromJson(Map<String, dynamic> json) {
    return EntryItem(
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      sys: Sys.fromJson(json['sys'] as Map<String, dynamic>),
      fields: json['fields'] != null ? json['fields'] as Map<String, dynamic> : {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metadata': metadata.toJson(),
      'sys': sys.toJson(),
      'fields': fields,
    };
  }
}

class Metadata {
  final Map<String, dynamic> properties;

  Metadata({required this.properties});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(properties: json);
  }

  Map<String, dynamic> toJson() {
    return properties;
  }
}

class Includes {
  final List<Asset> assets;
  final List<EntryItem> entries;

  Includes({
    required this.assets,
    required this.entries,
  });

  factory Includes.fromJson(Map<String, dynamic> json) {
    return Includes(
      assets: (json['Asset'] as List<dynamic>?)?.map((e) => Asset.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      entries: (json['Entry'] as List<dynamic>?)?.map((e) => EntryItem.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Asset': assets.map((e) => e.toJson()).toList(),
      'Entry': entries.map((e) => e.toJson()).toList(),
    };
  }
}

class Asset {
  final Metadata metadata;
  final Sys sys;
  final Map<String, dynamic> fields;

  Asset({
    required this.metadata,
    required this.sys,
    required this.fields,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      sys: Sys.fromJson(json['sys'] as Map<String, dynamic>),
      fields: json['fields'] != null ? json['fields'] as Map<String, dynamic> : {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metadata': metadata.toJson(),
      'sys': sys.toJson(),
      'fields': fields,
    };
  }
}

class ArticleContent {
  final EntryItem? article;
  final Includes? articleAssets;
  final List<Map<String, dynamic>>? articleReferences;

  ArticleContent({this.article, required this.articleAssets, this.articleReferences});
}

class SubtopicGroup {
  final List<EntryItem> articles;
  final Includes includes;

  SubtopicGroup({required this.articles, required this.includes});
}
