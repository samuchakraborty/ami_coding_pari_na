class User {
  int? id;
  int? mobile;
  String? userName;
  String? password;

  User({this.id, this.mobile, this.password, this.userName});

  Map<String, dynamic> toUser() {
    var map = <String, dynamic>{
      'id': id,
      'mobile': mobile,
      'username': userName,
      'password': password
    };

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    mobile = map['mobile'];
    userName = map['userName'];
    password = map['password'];
  }
}


