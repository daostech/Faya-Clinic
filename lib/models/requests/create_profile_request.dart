class CreateUserProfileRequest {
  CreateUserProfileRequest({
    this.userId,
    this.userName,
    this.phoneNumber,
    this.birthDate,
    this.email,
    this.isActive = true,
    this.gender = 0,
    this.token,
  });

  String userId;
  String userName;
  String phoneNumber;
  String birthDate;
  String email;
  bool isActive;
  int gender;
  String token;

  CreateUserProfileRequest copyWith({
    userId,
    userName,
    phoneNumber,
    birthDate,
    email,
    isActive,
    gender,
    token,
  }) {
    return CreateUserProfileRequest(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthDate: birthDate ?? this.birthDate,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
      gender: gender ?? this.gender,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": userId,
        "fullName": userName,
        "phone": phoneNumber,
        "dateBirth": birthDate,
        "email": email,
        "isActive": isActive,
        "gender": gender,
        "token": token,
      };
}
