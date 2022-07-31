import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ListLinkModel {
  final String id;
  final String type;
  final String name;
  final String link;
  final String image;
  ListLinkModel({
    required this.id,
    required this.type,
    required this.name,
    required this.link,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'name': name,
      'link': link,
      'image': image,
    };
  }

  factory ListLinkModel.fromMap(Map<String, dynamic> map) {
    return ListLinkModel(
      id: (map['id'] ?? '') as String,
      type: (map['type'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      link: (map['link'] ?? '') as String,
      image: (map['image'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListLinkModel.fromJson(String source) =>
      ListLinkModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
