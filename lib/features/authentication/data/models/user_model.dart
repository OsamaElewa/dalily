class UserModel {
  String? userId;
  String? userName;
  String? userEmail;
  String? userClass;
  String? userDepartment;
  bool? isAdmin;
  String? userPassword;
  UserModel({
    required this.userId,
    required this.userName,
    required this.userPassword,
    required this.userEmail,
    required this.isAdmin,
    required this.userClass,
    required this.userDepartment
  });


  UserModel.fromJson(Map<String, dynamic> json){
    userEmail = json['userEmail'] ?? '';
    userName = json['userName'] ?? '';
    userPassword = json['userPassword'] ?? '';
    userClass = json['userClass'];
    userDepartment = json['userDepartment'];
    isAdmin = json['isAdmin'];
    userId = json['userId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'userName': userName,
      'userPassword': userPassword,
      'userClass': userClass,
      'userDepartment': userDepartment,
      'isAdmin': isAdmin,
      'userId': userId,
    };
  }
}