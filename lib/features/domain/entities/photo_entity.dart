import 'package:equatable/equatable.dart';

class PhotoEntity extends Equatable {
  final String photographer;
  final String photographerUrl;
  final String photoUrl;
  final String alt;

  const PhotoEntity({
    required this.photographer,
    required this.photographerUrl,
    required this.photoUrl,
    required this.alt,
  });

  @override
  List<Object?> get props => [
        photographer,
        photographerUrl,
        photoUrl,
        alt,
      ];
}
