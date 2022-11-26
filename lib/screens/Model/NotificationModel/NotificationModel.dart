import 'package:json_annotation/json_annotation.dart';

part 'NotificationModel.g.dart';

@JsonSerializable()
class NotificationModel {
  List<Data> data;

  NotificationModel(this.data);

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}


@JsonSerializable()
class Data {

  dynamic id;
  dynamic title;
  dynamic message;
  dynamic tailor_id;
  dynamic order_id;
  dynamic customer_id;
  dynamic status;
  dynamic is_seen;
  dynamic created_at;

  Data(this.id, this.title, this.message, this.tailor_id, this.order_id, this.customer_id, this.status, this.is_seen, this.created_at);

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);
}
