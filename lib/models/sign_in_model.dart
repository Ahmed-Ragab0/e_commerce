class SignInModel {
  bool status;
  String? message;
  UserModel? data;

  SignInModel({required this.status, this.message, this.data});

  factory SignInModel.fromJson(json) {
    return SignInModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? UserModel.fromJson(json['data']) : null,
    );
  }
}

class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final int? points;
  final int? credit;
  final String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  factory UserModel.fromJson(json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      points: json['points'],
      credit: json['credit'],
      token: json['token'],
    );
  }
}
