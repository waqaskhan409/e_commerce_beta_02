import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  String owner;
  String owner_number;
  String prduct_category;
  String product;
  String price;
  String province;
  String short_desc;
  String long_desc;
  String is_negotiable;
  String image_1;
  String image_2;
  String product_id;
  String thumbnail;
  String image_3;
  String city;
  Timestamp current_date;
  String expiry_date;
  bool is_feature;
  bool is_expire;
  bool is_like;
  String quantity;
  int buyQuantity;
  int call_count;
  int view_count;
  int likes_count;
  String uid;


  Product(this.owner, this.owner_number, this.prduct_category, this.product,
      this.price, this.province, this.short_desc, this.long_desc,
      this.is_negotiable, this.image_1, this.image_2, this.product_id,
      this.thumbnail, this.image_3, this.city, this.current_date,
      this.expiry_date, this.is_feature, this.quantity, this.call_count, this.view_count, this.uid, this.likes_count);


}