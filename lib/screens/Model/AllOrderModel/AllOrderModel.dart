import 'package:json_annotation/json_annotation.dart';
part 'AllOrderModel.g.dart';

@JsonSerializable()
class AllOrderModel {
  List<Data> data;

  AllOrderModel(this.data);

  factory AllOrderModel.fromJson(Map<String, dynamic> json) =>
      _$AllOrderModelFromJson(json);
}

@JsonSerializable()
class Data {
  dynamic id;
  dynamic cloth_id;
  dynamic tailor_id;
  dynamic customer_id;
  dynamic cloth_name;
  dynamic type_of_sleeves;
  dynamic sleeves;
  dynamic type_of_neck;
  dynamic neck;
  dynamic waist;
  dynamic bust;
  dynamic length;
  dynamic quantity;
  dynamic delivered_to_name;
  dynamic delivered_to_phone;
  dynamic delivered_to_area;
  dynamic delivered_to_house;
  dynamic delivered_to_city;
  dynamic delivered_to_state;
  dynamic delivered_to_post_code;
  dynamic delivered_to_country;
  dynamic order_status;
  dynamic order_date;
  dynamic created_at;
  dynamic updated_at;
  Customer customer;
  Cloth cloth;
  //List<Customer> customer;
  //List <Tailor> tailor;
  //List<Cloth> cloth;

  Data(
    this.id,this.cloth_id,this.tailor_id,this.customer_id,this.cloth_name,
    this.type_of_sleeves,this.sleeves,this.type_of_neck,this.neck,this.waist,
    this.bust,this.length,this.quantity,this.delivered_to_name,this.delivered_to_phone,
    this.delivered_to_area,this.delivered_to_house,this.delivered_to_city,this.delivered_to_state,
    this.delivered_to_post_code,this.delivered_to_country,this.order_status,this.order_date,
    this.created_at,this.updated_at,this.customer,
    //this.tailor,
    this.cloth,
  );

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@JsonSerializable()
class Customer {
  dynamic id;
  dynamic fname;
  dynamic lname;
  dynamic mobile;
  dynamic email;
  dynamic address;
  dynamic type;
  dynamic created_at;
  dynamic updated_at;
  dynamic status;

  Customer(this.id, this.fname, this.lname, this.mobile, this.email,
      this.address, this.type, this.created_at, this.updated_at, this.status);

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}

// @JsonSerializable()
//   class Tailor {

//     dynamic id;
//     dynamic fname;
//     dynamic lname;
//     dynamic mobile;
//     dynamic email;
//     dynamic address;
//     dynamic type;
//     dynamic created_at;
//     dynamic updated_at;
//     dynamic status;

//     Tailor(this.id, this.fname, this.lname, this.mobile, this.email, this.address, this.type, this.created_at, this.updated_at, this.status);

//     factory Tailor.fromJson(Map<String, dynamic> json) => _$TailorFromJson(json);
// }

@JsonSerializable()
class Cloth {
  dynamic id;
  dynamic cloth_name;
  dynamic price;
  dynamic rate;
  dynamic image;
  dynamic image2;
  dynamic category_name;
  dynamic description;
  dynamic status;
  dynamic created_at;
  dynamic updated_at;
  //List <Images> images;

  Cloth(
    this.id,
    this.cloth_name,
    this.price,
    this.rate,
    this.image,
    this.image2,
    this.category_name,
    this.description,
    this.status,
    this.created_at,
    this.updated_at,
    //this.images
  );

  factory Cloth.fromJson(Map<String, dynamic> json) => _$ClothFromJson(json);
}
