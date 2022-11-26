// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AllTailorModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllTailorModel _$AllTailorModelFromJson(Map<String, dynamic> json) =>
    AllTailorModel(
      (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllTailorModelToJson(AllTailorModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['id'],
      json['fname'],
      json['lname'],
      json['mobile'],
      json['email'],
      json['address'],
      (json['cloths'] as List<dynamic>)
          .map((e) => Cloths.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['status'],
      json['type'],
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'fname': instance.fname,
      'lname': instance.lname,
      'mobile': instance.mobile,
      'email': instance.email,
      'address': instance.address,
      'type': instance.type,
      'status': instance.status,
      'cloths': instance.cloths,
    };

Cloths _$ClothsFromJson(Map<String, dynamic> json) => Cloths(
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

Map<String, dynamic> _$ClothsToJson(Cloths instance) => <String, dynamic>{
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
