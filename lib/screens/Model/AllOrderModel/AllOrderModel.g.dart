// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AllOrderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllOrderModel _$AllOrderModelFromJson(Map<String, dynamic> json) =>
    AllOrderModel(
      (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllOrderModelToJson(AllOrderModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['id'],
      json['cloth_id'],
      json['tailor_id'],
      json['customer_id'],
      json['cloth_name'],
      json['type_of_sleeves'],
      json['sleeves'],
      json['type_of_neck'],
      json['neck'],
      json['waist'],
      json['bust'],
      json['length'],
      json['quantity'],
      json['delivered_to_name'],
      json['delivered_to_phone'],
      json['delivered_to_area'],
      json['delivered_to_house'],
      json['delivered_to_city'],
      json['delivered_to_state'],
      json['delivered_to_post_code'],
      json['delivered_to_country'],
      json['order_status'],
      json['order_date'],
      json['created_at'],
      json['updated_at'],
      Customer.fromJson(json['customer'] as Map<String, dynamic>),
      Cloth.fromJson(json['cloth'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'cloth_id': instance.cloth_id,
      'tailor_id': instance.tailor_id,
      'customer_id': instance.customer_id,
      'cloth_name': instance.cloth_name,
      'type_of_sleeves': instance.type_of_sleeves,
      'sleeves': instance.sleeves,
      'type_of_neck': instance.type_of_neck,
      'neck': instance.neck,
      'waist': instance.waist,
      'bust': instance.bust,
      'length': instance.length,
      'quantity': instance.quantity,
      'delivered_to_name': instance.delivered_to_name,
      'delivered_to_phone': instance.delivered_to_phone,
      'delivered_to_area': instance.delivered_to_area,
      'delivered_to_house': instance.delivered_to_house,
      'delivered_to_city': instance.delivered_to_city,
      'delivered_to_state': instance.delivered_to_state,
      'delivered_to_post_code': instance.delivered_to_post_code,
      'delivered_to_country': instance.delivered_to_country,
      'order_status': instance.order_status,
      'order_date': instance.order_date,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'customer': instance.customer,
      'cloth': instance.cloth,
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      json['id'],
      json['fname'],
      json['lname'],
      json['mobile'],
      json['email'],
      json['address'],
      json['type'],
      json['created_at'],
      json['updated_at'],
      json['status'],
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'fname': instance.fname,
      'lname': instance.lname,
      'mobile': instance.mobile,
      'email': instance.email,
      'address': instance.address,
      'type': instance.type,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'status': instance.status,
    };

Cloth _$ClothFromJson(Map<String, dynamic> json) => Cloth(
      json['id'],
      json['cloth_name'],
      json['price'],
      json['rate'],
      json['image'],
      json['image2'],
      json['category_name'],
      json['description'],
      json['status'],
      json['created_at'],
      json['updated_at'],
    );

Map<String, dynamic> _$ClothToJson(Cloth instance) => <String, dynamic>{
      'id': instance.id,
      'cloth_name': instance.cloth_name,
      'price': instance.price,
      'rate': instance.rate,
      'image': instance.image,
      'image2': instance.image2,
      'category_name': instance.category_name,
      'description': instance.description,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
