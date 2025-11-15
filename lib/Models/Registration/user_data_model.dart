class UserData {
  String? nickName;
  String? userName;
  String? email;
  String? fullName;
  String? gender;
  String? weight;
  bool? active;
  String? password;
  String? pronoun;
  String? height;
  String? id;
  String? picLink;
  String? dob;

  UserData({this.nickName, this.userName, this.email, this.fullName, this.gender, this.weight, this.active, this.password, this.pronoun, this.height, this.id, this.picLink, this.dob});

  UserData.fromJson(Map<String, dynamic> json) {
    nickName = json['nickName'];
    userName = json['userName'];
    email = json['email'];
    fullName = json['fullName'];
    gender = json['gender'];
    weight = json['weight'];
    active = json['active'];
    password = json['password'];
    pronoun = json['pronoun'];
    height = json['height'];
    id = json['id'];
    picLink = json['picLink'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nickName'] = nickName;
    data['userName'] = userName;
    data['email'] = email;
    data['fullName'] = fullName;
    data['gender'] = gender;
    data['weight'] = weight;
    data['active'] = active;
    data['password'] = password;
    data['pronoun'] = pronoun;
    data['height'] = height;
    data['id'] = id;
    data['picLink'] = picLink;
    data['dob'] = dob;
    return data;
  }
}
