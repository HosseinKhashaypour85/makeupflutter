class SubCategoryModel {
  SubCategoryModel({
      this.category, 
      this.products,});

  SubCategoryModel.fromJson(dynamic json) {
    category = json['category'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
  }
  String? category;
  List<Products>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category'] = category;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Products {
  Products({
      this.id, 
      this.name, 
      this.brand, 
      this.price, 
      this.image,});

  Products.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    brand = json['brand'];
    price = json['price'];
    image = json['image'];
  }
  int? id;
  String? name;
  String? brand;
  int? price;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['brand'] = brand;
    map['price'] = price;
    map['image'] = image;
    return map;
  }

}