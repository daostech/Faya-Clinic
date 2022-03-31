class CreateUserProfileRequest {
  CreateUserProfileRequest({
    this.userId,
    this.userName,
    this.phoneNumber,
    this.birthDate,
    this.email,
    this.isActive = true,
    this.gender = 0,
  });

  String userId;
  String userName;
  String phoneNumber;
  String birthDate;
  String email;
  bool isActive;
  int gender;

  Map<String, dynamic> toJson() => {
        "id": userId,
        "fullName": userName,
        "phone": phoneNumber,
        "dateBirth": birthDate,
        "email": email,
        "isActive": isActive,
        "gender": gender,
      };
}
