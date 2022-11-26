// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['id'],
      json['title'],
      json['message'],
      json['tailor_id'],
      json['order_id'],
      json['customer_id'],
      json['status'],
      json['is_seen'],
      json['created_at'],
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'tailor_id': instance.tailor_id,
      'order_id': instance.order_id,
      'customer_id': instance.customer_id,
      'status': instance.status,
      'is_seen': instance.is_seen,
      'created_at': instance.created_at,
    };
