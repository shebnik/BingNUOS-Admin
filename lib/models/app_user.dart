class AppUser {
  final String name;
  final String email;
  final String uid;

  AppUser({
    required this.name,
    required this.email,
    required this.uid,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] as String,
      email: map['email'] as String,
      uid: map['uid'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'uid': uid,
    };
  }

  @override
  String toString() {
    return 'AppUser(name: $name, email: $email, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.name == name &&
        other.email == email &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ uid.hashCode;
  }
}
