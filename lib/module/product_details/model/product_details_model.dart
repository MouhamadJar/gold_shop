class ProductDetailsModel {
  final int id;
  final String code;
  final int userId;
  final String description;
  final String age;
  final int weight;
  final String carat;
  final int subcategoryId;
  final int currentGoldPrice;
  final int profit;
  final dynamic? addition;
  final dynamic? details;
  final String manufacturer;
  final String manufacturerType;
  final bool toggle;
  final String deliveryType;
  final String? phoneNumber;
  final int views;
  final String productStatus;
  final String createdAt;
  final String updatedAt;
  final double price;
  final int? priceAfterDiscount;
  final int horror;
  List<dynamic> images;

  ProductDetailsModel({
    required this.id,
    required this.code,
    required this.userId,
    required this.description,
    required this.age,
    required this.weight,
    required this.carat,
    required this.subcategoryId,
    required this.currentGoldPrice,
    required this.profit,
    this.addition,
    this.details,
    required this.manufacturer,
    required this.manufacturerType,
    required this.toggle,
    required this.deliveryType,
     this.phoneNumber,
    required this.views,
    required this.productStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.price,
    this.priceAfterDiscount,
    required this.horror,
    required this.images,
  });

  factory ProductDetailsModel.fromJson({required Map<String, dynamic> json}) {
    List<Map<String, dynamic>> tmp = [];
    if(json['images'].isNotEmpty) {
      json['images'].forEach((element) {
        tmp.add(element);
      });
    }
    return ProductDetailsModel(
      id: json['id'],
      code: json['code'],
      userId: json['user_id'],
      description: json['description'],
      age: json['age'],
      weight: json['wight'],
      carat: json['carat'],
      subcategoryId: json['subcategory_id'],
      currentGoldPrice: json['current_gold_price'],
      profit: json['profit'],
      addition: json['addition'],
      details: json[''],
      manufacturer: json['manufacture'],
      manufacturerType: json['manufacture_type'],
      toggle: json['toggle'],
      deliveryType: json['delivery_type'],
      phoneNumber: json['phone_number'],
      views: json['views'],
      productStatus: json['product_status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      price: json['price'],
      priceAfterDiscount: json['price_after_discount'],
      horror: json['horror'],
      images: tmp,
    );
  }
}
