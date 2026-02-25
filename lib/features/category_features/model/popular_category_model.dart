class PopularCategoryModel {
  PopularCategoryModel({
    this.mongoId,
    this.id,
    this.name,
    this.image,
    this.productsCount,
    this.description,
    this.productIds,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.products,
  });

  String? mongoId; // _id
  int? id;
  String? name;
  String? image;
  int? productsCount;
  String? description;
  List<int>? productIds;
  String? createdAt;
  String? updatedAt;
  int? v;
  List<Product>? products;

  factory PopularCategoryModel.fromJson(Map<String, dynamic> json) {
    return PopularCategoryModel(
      mongoId: json['_id'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      productsCount: json['productsCount'] as int?,
      description: json['description'] as String?,
      productIds: (json['productIds'] as List?)?.map((e) => e as int).toList() ?? [],
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as int?,
      products: (json['products'] as List?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': mongoId,
    'id': id,
    'name': name,
    'image': image,
    'productsCount': productsCount,
    'description': description,
    'productIds': productIds ?? [],
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'products': products?.map((e) => e.toJson()).toList() ?? [],
  };
}

class Product {
  Product({this.id, this.name, this.brand, this.price, this.image});

  int? id;
  String? name;
  String? brand;
  int? price;
  String? image;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      name: json['name'] as String?,
      brand: json['brand'] as String?,
      price: json['price'] as int?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'brand': brand,
    'price': price,
    'image': image,
  };
}