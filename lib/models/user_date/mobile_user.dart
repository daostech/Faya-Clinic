class MobileUsers {
  MobileUsers({
    this.comments,
    this.dateRegistered,
    this.id,
    this.fullName,
    this.email,
    this.isActive,
    this.gender,
    this.phone,
    this.dateBirth,
    this.creationDate,
    this.userRole,
    this.userName,
    this.token,
  });

  List<dynamic> comments;
  List<dynamic> dateRegistered;
  String id;
  String fullName;
  String email;
  bool isActive;
  int gender;
  String phone;
  DateTime dateBirth;
  DateTime creationDate;
  String userRole;
  String userName;
  String token;

  factory MobileUsers.fromJson(Map<String, dynamic> json) => MobileUsers(
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        dateRegistered: List<dynamic>.from(json["dateRegistered"].map((x) => x)),
        id: json["id"],
        fullName: json["fullName"],
        email: json["email"],
        isActive: json["isActive"],
        gender: json["gender"],
        phone: json["phone"],
        dateBirth: DateTime.parse(json["dateBirth"]),
        creationDate: DateTime.parse(json["creationDate"]),
        userRole: json["userRole"],
        userName: json["userName"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "dateRegistered": List<dynamic>.from(dateRegistered.map((x) => x)),
        "id": id,
        "fullName": fullName,
        "email": email,
        "isActive": isActive,
        "gender": gender,
        "phone": phone,
        "dateBirth": dateBirth.toIso8601String(),
        "creationDate": creationDate.toIso8601String(),
        "userRole": userRole,
        "userName": userName,
        "token": token,
      };
}
