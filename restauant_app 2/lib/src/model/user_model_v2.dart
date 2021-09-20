class UserModelV2 {
  UserModelV2({
    this.id,
    this.username,
    this.email,
    this.password,
    this.name,
    this.birthday,
    this.phoneNumber,
    this.address,
    this.status,
    this.roles,
  });

  int id;
  String username;
  String email;
  String password;
  String name;
  String birthday;
  String phoneNumber;
  String address;
  bool status;
  List<Role> roles;

  factory UserModelV2.fromJson(Map<String, dynamic> json) => UserModelV2(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    name: json["name"],
    birthday: json["birthday"],
    phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
    address: json["address"],
    status: json["status"],
    roles: json["roles"] == null ? null : List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "password": password,
    "name": name,
    "birthday": birthday,
    "phoneNumber": phoneNumber == null ? null : phoneNumber,
    "address": address,
    "status": status,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
  };
}

class Role {
  Role({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
