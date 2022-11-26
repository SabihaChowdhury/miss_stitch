import 'package:json_annotation/json_annotation.dart';

part 'AllClothModel.g.dart';
@JsonSerializable()
class AllClothModel {
  List<Data> data;

  AllClothModel(this.data);

  factory AllClothModel.fromJson(Map<String, dynamic> json) =>
      _$AllClothModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllClothModelToJson(this);
}

@JsonSerializable()
class Data {
  dynamic id;
  dynamic cloth_name;
  dynamic price;
  dynamic image;
  dynamic image2;
  dynamic category_name;
  dynamic description;
  dynamic status;
  List<Images> images;

  Data(this.id, this.cloth_name, this.price, this.image, this.image2, this.category_name, this.description, this.status, this.images);

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Images {
  dynamic image_url;

  Images(this.image_url);

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}






