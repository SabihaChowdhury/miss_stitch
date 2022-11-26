// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AllClothModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllClothModel _$AllClothModelFromJson(Map<String, dynamic> json) =>
    AllClothModel(
      (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllClothModelToJson(AllClothModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['id'],
      json['cloth_name'],
      json['price'],
      json['image'],
      json['image2'],
      json['category_name'],
      json['description'],
      json['status'],
      (json['images'] as List<dynamic>)
          .map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'cloth_name': instance.cloth_name,
      'price': instance.price,
      'image': instance.image,
      'image2': instance.image2,
      'category_name': instance.category_name,
      'description': instance.description,
      'status': instance.status,
      'images': instance.images,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      json['image_url'],
    );

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'image_url': instance.image_url,
    };
