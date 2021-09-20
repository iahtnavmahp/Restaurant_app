class UserModel {
  UserModel({
    this.id,
    this.username,
    this.email,
    this.roles,
    this.accessToken,
    this.tokenType,
    this.name,
  });

  int id;
  String username;
  String email;
  List<String> roles;
  String accessToken;
  String tokenType;
  String name;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    roles: List<String>.from(json["roles"].map((x) => x)),
    accessToken: json["accessToken"],
    tokenType: json["tokenType"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "accessToken": accessToken,
    "tokenType": tokenType,
    "name": name,
  };
}
