class PopularProductsModel {
  PopularProductsModel({
    this.count,
    this.products,
  });

  PopularProductsModel.fromJson(dynamic json) {
    count = json['count'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Product.fromJson(v));
      });
    }
  }

  int? count;
  List<Product>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Product {
  Product({
    this.sId,  // برای _id از JSON
    this.id,   // برای id از JSON
    this.name,
    this.price,
    this.rating,
    this.image,
    this.description,
  });

  Product.fromJson(dynamic json) {
    sId = json['_id'];  // نام متفاوت برای جلوگیری از تداخل
    id = json['id'];
    name = json['name'];
    price = json['price'];
    rating = json['rating']?.toDouble(); // تبدیل به double
    image = json['image'];
    description = json['description'];
  }

  String? sId;    // نام تغییر یافته برای _id
  int? id;        // برای id عددی
  String? name;
  int? price;
  double? rating;
  String? image;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = sId;
    map['id'] = id;
    map['name'] = name;
    map['price'] = price;
    map['rating'] = rating;
    map['image'] = image;
    map['description'] = description;
    return map;
  }
}