import 'ekvipedia_entries_model.dart';

class AuthorModel {
  final String? name;
  final String? bio;
  final String? description;
  final String? profilePicture;
  final String? facebook;
  final String? tiktok;
  final String? youtube;
  final String? instagram;
  final String? website;

  AuthorModel({
    this.name,
    this.bio,
    this.description,
    this.profilePicture,
    this.facebook,
    this.tiktok,
    this.youtube,
    this.instagram,
    this.website,
  });

  /// Factory constructor to initialize the model from a JSON object
  factory AuthorModel.fromJson(Map<String, dynamic> json, dynamic assets) {
    // Function to get profile picture URL from the `assets`
    String? getProfilePicture(String? id) {
      if (id == null || id.isEmpty) return null;
      final asset = EkvipediaContentEntries.getAssetById(id, assets);
      return asset?.fields["file"]?["url"];
    }

    return AuthorModel(
      name: json["authorName"] as String?,
      bio: json["authorBio"] as String?,
      description: json["description"] as String?,
      profilePicture: getProfilePicture(json["profilePicture"]?["sys"]?["id"] as String?),
      facebook: json["facebook"] as String?,
      tiktok: json["tiktok"] as String?,
      youtube: json["youtube"] as String?,
      instagram: json["instagram"] as String?,
      website: json["website"] as String?,
    );
  }

  /// Converts the model to a JSON object
  Map<String, dynamic> toJson() {
    return {
      "authorName": name,
      "authorBio": bio,
      "description": description,
      "profilePicture": profilePicture,
      "facebook": facebook,
      "tiktok": tiktok,
      "youtube": youtube,
      "instagram": instagram,
      "website": website,
    };
  }
}
