class SubCategoryADVSModel {
  final int id;

  final int? categoryId;

  final int subcategoryId;

  final String paragraph;

  final String image;

  final String createdAt;

  final String updatedAt;

  SubCategoryADVSModel(
      {required this.id,
      this.categoryId,
      required this.subcategoryId,
      required this.paragraph,
      required this.image,
      required this.createdAt,
      required this.updatedAt});

  factory SubCategoryADVSModel.fromJson({required Map<String, dynamic> json}) {
    return SubCategoryADVSModel(
        id: json['id'],
        subcategoryId: json['subcategory_id'],
        paragraph: json['paragraph'],
        image: json['image'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}

class ProductsModel {
  final int id;
  final String description;
  final int weight;
  final String carat;
  final int? views;
  final String productStatus;
  final int currentGoldPrice;
  final int profit;
  final int? addition;
  final bool toggle;
  final int userId;
  final int subcategoryId;
  final double price;
  final double? priceAfterDiscount;
  final int horror;
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
    if(json['images'].isNotEmpty) {
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

