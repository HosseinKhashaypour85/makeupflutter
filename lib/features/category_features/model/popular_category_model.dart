class PopularCategoryModel {
  PopularCategoryModel({
      this.id, 
      this.id, 
      this.name, 
      this.image, 
      this.productsCount, 
      this.description, 
      this.productIds, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      this.products,});

  PopularCategoryModel.fromJson(dynamic json) {
    id = json['_id'];
    id = json['id'];
    name = json['name'];
    image = json['image'];
    productsCount = json['productsCount'];
    description = json['description'];
    productIds = json['productIds'] != null ? json['productIds'].cast<int>() : [];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
  }
  String? id;
  int? id;
  String? name;
  String? image;
  int? productsCount;
  String? description;
  List<int>? productIds;
  String? createdAt;
  String? updatedAt;
  int? v;
  List<Products>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['productsCount'] = productsCount;
    map['description'] = description;
    map['productIds'] = productIds;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
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