import 'package:faya_clinic/models/user.dart';

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
    this.imgUrl,
  });

  String? userId;
  String? userName;
  String? phoneNumber;
  String? birthDate;
  String? email;
  bool? isActive;
  int? gender;
  String? token;
  String? imgUrl;

  CreateUserProfileRequest copyWith({
    userId,
    userName,
    phoneNumber,
    birthDate,
    email,
    isActive,
    gender,
    token,
    imgUrl,
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
      imgUrl: imgUrl ?? this.imgUrl,
    );
  }

  CreateUserProfileRequest copyFromUser({required MyUser user}) {
    return CreateUserProfileRequest(
      userId: user.userId ?? this.userId,
      userName: user.userName ?? this.userName,
      phoneNumber: user.phoneNumber ?? this.phoneNumber,
      birthDate: user.dateBirth ?? this.birthDate,
      email: user.email ?? this.email,
      isActive: user.isActive ?? this.isActive,
      gender: user.gender ?? this.gender,
      token: user.token ?? this.token,
      imgUrl: user.imgUrl ?? this.imgUrl,
    );
  }

  factory CreateUserProfileRequest.copyAllFromUser({required MyUser user}) {
    return CreateUserProfileRequest(
      userId: user.userId,
      userName: user.userName,
      phoneNumber: user.phoneNumber,
      birthDate: user.dateBirth,
      email: user.email,
      isActive: user.isActive,
      gender: user.gender,
      token: user.token,
      imgUrl: user.imgUrl,
    );
  }

  factory CreateUserProfileRequest.copyFromUser({required MyUser user}) {
    return CreateUserProfileRequest(
      userId: user.userId,
      userName: user.userName,
      phoneNumber: user.phoneNumber,
      birthDate: user.dateBirth,
      email: user.email,
      isActive: user.isActive,
      gender: user.gender,
      token: user.token,
      imgUrl: user.imgUrl,
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
        "imgUrl": imgUrl,
      };
}
