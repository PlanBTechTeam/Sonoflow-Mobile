class UserModel {
  final String uid;
  final String username;
  final String email;
  final DateTime registrationDate;
  final String? photoUrl;
  final int? sleepGoal;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.registrationDate,
    this.photoUrl,
    this.sleepGoal,
  });
}
