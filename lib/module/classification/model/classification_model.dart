class ClassificationCategoriesModel {
  final int id;
  final String name;
  final String image;
  final int categoryId;
  final String createdAt;
  final String updatedAt;

  ClassificationCategoriesModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.categoryId,
      required this.createdAt,
      required this.updatedAt});

  factory ClassificationCategoriesModel.fromJson(
      {required Map<String, dynamic> json}) {
    return ClassificationCategoriesModel(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        categoryId: json['category_id'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}

class CategoryADVSModel {
  final int id;

  final int categoryId;

  final int? subcategoryId;

  final String paragraph;

  final String image;

  final String createdAt;

  final String updatedAt;

  CategoryADVSModel(
      {required this.id,
      required this.categoryId,
        this.subcategoryId,
      required this.paragraph,
      required this.image,
      required this.createdAt,
      required this.updatedAt});

  factory CategoryADVSModel.fromJson({required Map<String, dynamic> json}) {
    return CategoryADVSModel(
        id: json['id'],
        categoryId: json['category_id'],
        subcategoryId: json['subcategory_id'],
        paragraph: json['paragraph'],
        image: json['image'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}


