import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PermissionModel {
  final String name;
  final String role;
  PermissionModel({
    required this.name,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'role': role,
    };
  }

  factory PermissionModel.fromMap(Map<String, dynamic> map) {
    return PermissionModel(
      name: (map['name'] ?? '') as String,
      role: (map['role'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PermissionModel.fromJson(String source) =>
      PermissionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
