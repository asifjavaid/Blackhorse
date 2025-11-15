class CourseStructure {
  String? courseId;
  String? imageUrl;
  String? title;
  dynamic description;
  int? totalModules;
  int? totalDuration;
  String? accessType;
  List<String>? tags;
  Host? host;
  List<Modules>? modules;

  CourseStructure({this.courseId, this.imageUrl, this.title, this.description, this.totalModules, this.totalDuration, this.accessType, this.tags, this.host, this.modules});

  CourseStructure.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    imageUrl = json['imageUrl'];
    title = json['title'];
    description = json['description'];
    totalModules = json['totalModules'];
    totalDuration = json['totalDuration'];
    accessType = json['accessType'];
    tags = json['tags'].cast<String>();
    host = json['host'] != null ? Host.fromJson(json['host']) : null;
    if (json['modules'] != null) {
      modules = <Modules>[];
      json['modules'].forEach((v) {
        modules!.add(Modules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['courseId'] = courseId;
    data['imageUrl'] = imageUrl;
    data['title'] = title;
    data['description'] = description;
    data['totalModules'] = totalModules;
    data['totalDuration'] = totalDuration;
    data['accessType'] = accessType;
    data['tags'] = tags;
    if (host != null) {
      data['host'] = host!.toJson();
    }
    if (modules != null) {
      data['modules'] = modules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Host {
  String? authorId;
  String? name;
  String? bio;
  String? description;
  String? profilePicture;
  Socials? socials;

  Host({this.authorId, this.name, this.bio, this.description, this.profilePicture, this.socials});

  Host.fromJson(Map<String, dynamic> json) {
    authorId = json['authorId'];
    name = json['name'];
    bio = json['bio'];
    description = json['description'];
    profilePicture = json['profilePicture'];
    socials = json['socials'] != null ? Socials.fromJson(json['socials']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authorId'] = authorId;
    data['name'] = name;
    data['bio'] = bio;
    data['description'] = description;
    data['profilePicture'] = profilePicture;
    if (socials != null) {
      data['socials'] = socials!.toJson();
    }
    return data;
  }
}

class Socials {
  String? facebook;
  String? instagram;
  String? youtube;
  String? tiktok;
  String? website;

  Socials({this.facebook, this.instagram, this.youtube, this.tiktok, this.website});

  Socials.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    tiktok = json['tiktok'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['youtube'] = youtube;
    data['tiktok'] = tiktok;
    data['website'] = website;
    return data;
  }
}

class Modules {
  String? moduleId;
  String? title;
  String? preview;
  String? featuredImage;
  int? moduleOrder;
  int? completionPct;

  Modules({this.moduleId, this.title, this.preview, this.featuredImage, this.moduleOrder, this.completionPct});

  Modules.fromJson(Map<String, dynamic> json) {
    moduleId = json['moduleId'];
    title = json['title'];
    preview = json['preview'];
    featuredImage = json['featuredImageUrl'];
    moduleOrder = json['moduleOrder'];
    completionPct = json['completionPct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['moduleId'] = moduleId;
    data['title'] = title;
    data['preview'] = preview;
    data['featuredImageUrl'] = featuredImage;
    data['moduleOrder'] = moduleOrder;
    data['completionPct'] = completionPct;
    return data;
  }
}
