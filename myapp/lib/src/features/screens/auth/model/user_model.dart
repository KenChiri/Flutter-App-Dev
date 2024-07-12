/*

=============
Todo: Step - 1 Create a model for the user that will help us update the firestore


 */


class UserModel {
  final String userId; // Enforce non-nullable user ID
  final String email;
  final String name;
  final String phoneNumber;
  final String role;

  UserModel({
    required this.userId,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.role,
  });

  toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'role': role,
    };
  }
}
