class User {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool isEmailVerified;
  final int recipeCount;
  int followingCount; // Made non-final
  int followersCount; // Made non-final
  final String? photoUrl;
  bool isFollowing; // Made non-final

  User({
    required this.id,
    this.firstName,
    this.lastName,
    required this.email,
    this.isEmailVerified = false,
    this.recipeCount = 0,
    this.followingCount = 0,
    this.followersCount = 0,
    this.photoUrl,
    this.isFollowing = false,
  });

  String get fullName {
    return '$firstName $lastName';
  }

  bool get hasCompletedProfile {
    if (firstName == null || lastName == null) {
      return false;
    }

    return true;
  }

  void followUser() {
    isFollowing = true;
    followingCount++;
    followersCount++;
  }

  void unfollowUser() {
    isFollowing = false;
    if (followingCount > 0) followingCount--;
    if (followersCount > 0) followersCount--;
  }

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    bool? isEmailVerified,
    int? recipeCount,
    int? followingCount,
    int? followersCount,
    String? photoUrl,
    bool? isFollowing,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      recipeCount: recipeCount ?? this.recipeCount,
      followingCount: followingCount ?? this.followingCount,
      followersCount: followersCount ?? this.followersCount,
      photoUrl: photoUrl ?? this.photoUrl,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}
