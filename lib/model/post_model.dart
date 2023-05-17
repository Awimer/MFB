import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostModel {
  String id;
  String ownerId;
  String titlePost;
  String mediaUrl;
  String shareType;
  String postTyp;
  PostModel({
    required this.id,
    required this.ownerId,
    required this.titlePost,
    required this.mediaUrl,
    required this.shareType,
    required this.postTyp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ownerId': ownerId,
      'titlePost': titlePost,
      'imageUrl': mediaUrl,
      'shareType': shareType,
      'postTyp': postTyp,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as String,
      ownerId: map['ownerId'] as String,
      titlePost: map['titlePost'] as String,
      mediaUrl: map['imageUrl'] as String,
      shareType: map['shareType'] as String,
      postTyp: map['postTyp'] as String,
    );
  }
}
