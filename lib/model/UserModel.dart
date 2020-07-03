class UserModel {
  String userId;
  UserModel({this.userId});
}

class UserDataModel {
  final String uid;
  final String username;
  final String email;
  final String phone;
  final String gender;
  final int strength;
  UserDataModel(
      {this.uid,
      this.username,
      this.email,
      this.phone,
      this.gender,
      this.strength});
}
