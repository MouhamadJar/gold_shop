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


class HomeADVSModel {
  final int id;
  final int categoryId;
  final String paragraph;
  final String image;
  final String background;

  HomeADVSModel(
      {required this.id,
        required this.categoryId,
        required this.paragraph,
        required this.image,
        required this.background,
      });

  factory HomeADVSModel.fromJson({required Map<String, dynamic> json}) {
    return HomeADVSModel(
        id: json['id'],
        categoryId: json['category_id'],
        paragraph: json['paragraph'],
        image: json['image'],
      background: json['background']
    );
  }
}


