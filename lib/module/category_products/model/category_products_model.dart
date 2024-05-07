class SubCategoryADVSModel {
  final int id;

  final int? categoryId;

  final int subcategoryId;

  final String paragraph;

  final String image;

  final String background;

  SubCategoryADVSModel({
    required this.id,
    this.categoryId,
    required this.subcategoryId,
    required this.paragraph,
    required this.image,
    required this.background,
  });

  factory SubCategoryADVSModel.fromJson({required Map<String, dynamic> json}) {
    return SubCategoryADVSModel(
      id: json['id'],
      subcategoryId: json['subcategory_id'],
      paragraph: json['paragraph'],
      image: json['image'],
      background: json['background']
    );
  }
}

class ProductsModel {
  final int id;
  final String description;
  final dynamic weight;
  final String carat;
  final int? views;
  final String productStatus;
  final dynamic currentGoldPrice;
  final dynamic profit;
  final dynamic? addition;
  final bool toggle;
  final int userId;
  final int subcategoryId;
  final dynamic price;
  final dynamic? priceAfterDiscount;
  final dynamic horror;
  final List<Map<String, dynamic>> images;
  final Map<String, dynamic>? discount;

  ProductsModel(
      {required this.id,
      required this.description,
      required this.weight,
      required this.carat,
      this.views,
      required this.productStatus,
      required this.currentGoldPrice,
      required this.profit,
      this.addition,
      required this.toggle,
      required this.price,
      required this.userId,
      required this.subcategoryId,
      this.priceAfterDiscount,
      required this.horror,
      required this.images,
      this.discount});

  factory ProductsModel.fromJson({required Map<String, dynamic> json}) {
    List<Map<String, dynamic>> tmp = [];
    if (json['images'].isNotEmpty) {
      json['images'].forEach((e) {
        tmp.add(e);
      });
    }
    return ProductsModel(
      id: json['id'],
      description: json['description'],
      weight: json['wight'],
      carat: json['carat'],
      views: json['views'],
      productStatus: json['product_status'].toString(),
      currentGoldPrice: json['current_gold_price'],
      profit: json['profit'],
      addition: json['addition'],
      toggle: json['toggle'],
      price: json['price'],
      horror: json['horror'],
      images: tmp,
      discount: json['discount'],
      userId: json['user_id'],
      subcategoryId: json['subcategory_id'],
    );
  }
}
