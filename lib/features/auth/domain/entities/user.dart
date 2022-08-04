class User {
  User({
    required this.username,
    this.password,
    this.avatar,
    this.customData,
    this.email,
    this.externalId,
    this.fullName,
    this.id,
    this.login,
    this.phone,
  });

  String username;
  String? password;
  String? avatar;
  String? customData;
  String? email;
  int? externalId;
  String? fullName;
  int? id;
  String? login;
  String? phone;
}
