import 'package:travel_app_fix/feature/destination/domain/entities/destination_entity.dart';

class DestinationModel extends DestinationEntity {
  const DestinationModel({required super.id,
    required super.name,
    required super.category,
    required super.cover,
    required super.rate,
    required super.rateCount,
    required super.location,
    required super.description,
    required super.images,
    required super.facilities});

  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      DestinationModel(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        cover: json["cover"],
        rate: double.parse(json["rate"]),
        rateCount: int.parse(json["rate_count"]),
        location: json["location"],
        description: json["description"],
        images: (json["images"] as String).split(', '),
        facilities: (json["facilities"] as String).split(', '),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "category": category,
        "cover": cover,
        "rate": rate.toString(),
        "rate_count": rateCount.toString(),
        "location": location,
        "description": description,
        "images": images.join(', '),
        "facilities": facilities.join(', '),
      };

  DestinationEntity get toEntity =>
      DestinationEntity(id: id,
          name: name,
          category: category,
          cover: cover,
          rate: rate,
          rateCount: rateCount,
          location: location,
          description: description,
          images: images,
          facilities: facilities);
}
