class UserModel {
  final String uid;
  final String username;
  final String email;
  final DateTime registrationDate;
  final String? profilePictureUrl;
  final int? sleepGoal;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.registrationDate,
    this.profilePictureUrl,
    this.sleepGoal,
  });
}
