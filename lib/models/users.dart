class User {
  final String email;
  final String uid;
  final String username;
  final String name;

  const User(
      {required this.email,
      required this.name,
      required this.uid,
      required this.username});

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
        "fullName": name,
      };
}
