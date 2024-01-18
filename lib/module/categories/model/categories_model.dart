class CategoriesModel {
  final int id;
  final String name;
  final String image;
  final String createdAt;
  final String updatedAt;

  CategoriesModel(
      {required this.id,
        required this.name,
        required this.image,
        required this.createdAt,
        required this.updatedAt});

  factory CategoriesModel.frmJson({required Map<String, dynamic> json}) {
    return CategoriesModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
