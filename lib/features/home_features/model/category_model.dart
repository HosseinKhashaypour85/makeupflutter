class CategoryModel {
  CategoryModel({
      this.count, 
      this.categories,});

  CategoryModel.fromJson(dynamic json) {
    count = json['count'];
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
  }
  int? count;
  List<Categories>? categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Categories {
  Categories({
      this.categoryId, 
      this.categoryName, 
      this.productsCount,});

  Categories.fromJson(dynamic json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    productsCount = json['products_count'];
  }
  String? categoryId;
  String? categoryName;
  int? productsCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_id'] = categoryId;
    map['category_name'] = categoryName;
    map['products_count'] = productsCount;
    return map;
  }

}