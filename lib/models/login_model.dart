import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginModel {
  final String success;
  final String auth;
  LoginModel({
    required this.success,
    required this.auth,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'auth': auth,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      success: (map['success'] ?? '') as String,
      auth: (map['auth'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) => LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
