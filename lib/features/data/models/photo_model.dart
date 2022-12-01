import 'dart:convert';

import 'package:pexels_clean_arch/features/domain/entities/photo_entity.dart';

class PhotoModel extends PhotoEntity {
  const PhotoModel({
    required super.photographer,
    required super.photographerUrl,
    required super.photoUrl,
    required super.alt,
  });

  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      photographer: map['photographer'],
      photographerUrl: map['photographer_url'],
      photoUrl: map['src']['original'],
      alt: map['alt'],
    );
  }

  Map<String, dynamic> toMap() => {
        "photographer": photographer,
        "photographer_url": photographerUrl,
        "original": photoUrl,
        "alt": alt,
      };

  factory PhotoModel.fromJson(String json) {
    return PhotoModel.fromMap(jsonDecode(json));
  }

  String toJson() => jsonEncode(toMap());
}
