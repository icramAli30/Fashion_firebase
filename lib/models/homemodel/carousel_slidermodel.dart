
class CarouselSliderModel {
  String id;
  String image;

  CarouselSliderModel({
    required this.id,
    required this.image,
  });

  CarouselSliderModel copyWith({
    String? id,
    String? name,
    String? image,
  }) =>
      CarouselSliderModel(
        id: id ?? this.id,

        image: image ?? this.image,
      );

  factory CarouselSliderModel.fromJson(Map<String, dynamic> json) => CarouselSliderModel(
    id: json["id"],

    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}
