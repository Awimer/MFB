import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostModel {
  String id;
  String ownerId;
  String titlePost;
  String imageUrl;
  String shareType;
  PostModel({
    required this.id,
    required this.ownerId,
    required this.titlePost,
    required this.imageUrl,
    required this.shareType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ownerId': ownerId,
      'titlePost': titlePost,
      'imageUrl': imageUrl,
      'shareType': shareType,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as String,
      ownerId: map['ownerId'] as String,
      titlePost: map['titlePost'] as String,
      imageUrl: map['imageUrl'] as String,
      shareType: map['shareType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
