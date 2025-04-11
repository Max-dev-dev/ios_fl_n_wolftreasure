import 'package:equatable/equatable.dart';

class WolfPlace extends Equatable {
  final String id;
  final String title;
  final String image;
  final String description;
  final double latitude;
  final double longitude;

  const WolfPlace({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  factory WolfPlace.fromJson(Map<String, dynamic> json) {
    return WolfPlace(
      id: json['id'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image': image,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
      };

  @override
  List<Object?> get props => [id];
}
