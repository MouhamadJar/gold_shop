class ProductDetailsModel {
  final int id;
  final dynamic code;
  final int userId;
  final int addressId;
  final String description;
  final String productType;
  final dynamic weight;
  final String carat;
  final int subcategoryId;
  final dynamic currentGoldPrice;
  final dynamic profit;
  final dynamic addition;
  final dynamic details;
  final bool toggle;
  final String deliveryType;
  final int views;
  final String productStatus;
  final dynamic price;
  final dynamic horror;
  final dynamic marketValue;
  final List<dynamic> images;
  final String phoneNumber;
  final String country;
  final String city;

  ProductDetailsModel({
    required this.id,
    required this.code,
    required this.userId,
    required this.addressId,
    required this.description,
    required this.productType,
    required this.weight,
    required this.carat,
    required this.subcategoryId,
    required this.currentGoldPrice,
    required this.profit,
    this.addition,
    this.details,
    required this.toggle,
    required this.deliveryType,
    required this.phoneNumber,
    required this.views,
    required this.productStatus,
    required this.price,
    required this.marketValue,
    required this.horror,
    required this.images,
    required this.country,
    required this.city,
  });

  factory ProductDetailsModel.fromJson({required Map<String, dynamic> json}) {
    List<Map<String, dynamic>> tmp = [];
    if (json['images'].isNotEmpty) {
      json['images'].forEach((element) {
        tmp.add(element);
      });
    }
    return ProductDetailsModel(
      id: json['id'],
      code: json['code'],
      userId: json['user_id'],
      addressId: json['address_id'],
      description: json['description'],
      productType: json['product_type'],
      weight: json['wight'],
      carat: json['carat'],
      subcategoryId: json['subcategory_id'],
      currentGoldPrice: json['current_gold_price'],
      profit: json['profit'],
      addition: json['addition'],
      details: json['detail'],
      toggle: json['toggle'],
      deliveryType: json['delivery_type'],
      phoneNumber: json['phone_numbers'][0]['phone_number'],
      views: json['views'],
      productStatus: json['product_status'],
      price: json['price'],
      marketValue: json['market_value'],
      horror: json['horror'],
      images: tmp,
      country: json['address']['country'],
      city: json['address']['city'],
    );
  }
}

class PutAsideModel {
  final dynamic price;
  final int orderId;
  final dynamic gramPrice;

  final dynamic? totalAmount;

  PutAsideModel({
    required this.price,
    required this.orderId,
    required this.gramPrice,
    this.totalAmount,
  });

  factory PutAsideModel.fromJson({required Map<String, dynamic> json}) {
    return PutAsideModel(
      price: json['price'],
      gramPrice: json['gram_price'], orderId: json['id'],
    );
  }
}
