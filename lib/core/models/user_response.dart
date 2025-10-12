class UserResponse {
  UserResponse({
    required this.uid,
    required this.email,
    required this.role,
  });

  final String uid;
  final String email;
  final String role;

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      uid: json['uid'] as String? ?? '',
      email: json['email'] as String? ?? '',
      role: json['role'] as String? ?? '',
    );
  }
}


