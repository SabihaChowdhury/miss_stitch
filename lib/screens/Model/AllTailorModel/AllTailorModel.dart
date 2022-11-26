import 'package:json_annotation/json_annotation.dart';

part 'AllTailorModel.g.dart';

@JsonSerializable()
class AllTailorModel {
  List<Data> data;

  AllTailorModel(this.data);

  factory AllTailorModel.fromJson(Map<String, dynamic> json) =>
      _$AllTailorModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllTailorModelToJson(this);
}

@JsonSerializable()
class Data {
  dynamic id;
  dynamic fname;
  dynamic lname;
  dynamic mobile;
  dynamic email;
  dynamic address;
  dynamic type;
  dynamic status;
  List<Cloths> cloths;

  Data(this.id, this.fname, this.lname, this.mobile, this.email, this.address,
      this.cloths, this.status, this.type);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Cloths {
  dynamic id;
  dynamic cloth_name;
  dynamic price;
  dynamic image;
  dynamic image2;
  dynamic category_name;
  dynamic description;
  dynamic status;
  List<Images> images;

  Cloths(this.id, this.cloth_name, this.price, this.image, this.image2,
      this.category_name, this.description, this.status, this.images);

  factory Cloths.fromJson(Map<String, dynamic> json) => _$ClothsFromJson(json);
  Map<String, dynamic> toJson() => _$ClothsToJson(this);
}

@JsonSerializable()
class Images {
  dynamic image_url;

  Images(this.image_url);

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}
