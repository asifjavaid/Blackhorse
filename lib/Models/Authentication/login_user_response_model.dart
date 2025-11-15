class EkviLoginUserResponse {
  String? token;
  bool? isOnboarded;
  User? user;

  EkviLoginUserResponse({this.token, this.user});

  EkviLoginUserResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    isOnboarded = json['isOnboarded'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['isOnboarded'] = isOnboarded;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  bool? active;
  String? userName;
  String? email;
  String? id;
  String? picLink;

  User({
    this.active,
    this.userName,
    this.email,
    this.id,
    this.picLink,
  });

  User.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    userName = json['userName'];
    email = json['email'];
    id = json['id'];
    picLink = json['picLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active'] = active;
    data['userName'] = userName;
    data['email'] = email;
    data['id'] = id;
    data['picLink'] = picLink;
    return data;
  }
}
