class EditProductModel {
  final int productId;
  final String code;
  final int userId;
  final String description;
  final String age;
  final dynamic weight;
  final String carat;
  final int subcategoryId;
  final dynamic currentGoldPrice;
  final dynamic profit;
  final dynamic addition;
  final String details;
  final String manufacturer;
  final String manufacturerType;
  final bool toggle;
  final dynamic deliveryType;
  final String? offerDescription;
  final dynamic discountValue;
  final dynamic views;
  final dynamic productStatus;
  final dynamic price;
  final dynamic priceAfterDiscount;
  final dynamic horror;
  final List<dynamic> images;
  final String sellerFirstName;
  final String sellerLastName;
  final String sellerPhoneNumber;
  final String buyerFirstName;
  final String buyerLastName;
  final String buyerPhoneNumber;

  EditProductModel({
    required this.productId,
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
    required this.details,
    required this.manufacturer,
    required this.manufacturerType,
    required this.toggle,
    required this.deliveryType,
     this.offerDescription,
    this.discountValue,
    this.views,
    this.productStatus,
    required this.price,
    this.priceAfterDiscount,
    required this.horror,
    required this.images,
    required this.sellerFirstName,
    required this.sellerLastName,
    required this.sellerPhoneNumber,
    required this.buyerFirstName,
    required this.buyerLastName,
    required this.buyerPhoneNumber,
  });

  factory EditProductModel.fromJson({required Map<String, dynamic> json}) {
    List<dynamic> tmp = [];
  if(json['product']['images'].isNotEmpty) {
    json['product']['images'].forEach((e) {
      tmp.add(e);
    });
  }
    return EditProductModel(
      productId: json['product']['id'],
      code: json['product']['code'],
      userId: json['product']['user_id'],
      description: json['product']['description'],
      age: json['product']['age'],
      weight: json['product']['wight'],
      carat: json['product']['carat'],
      subcategoryId: json['product']['subcategory_id'],
      currentGoldPrice: json['product']['current_gold_price'],
      profit: json['product']['profit'],
      addition: json['product']['addition'],
      details: json['product']['detail'],
      manufacturer: json['product']['manufacture'],
      manufacturerType: json['product']['manufacture_type'],
      toggle: json['product']['toggle'],
      deliveryType: json['product']['delivery_type'],
      offerDescription: json['product']['offer_description']??'',
      discountValue: json['product']['discount_value'],
      views: json['product']['views'],
      productStatus:json['product']['product_status'],
      price: json['product']['price'],
      priceAfterDiscount:json['product']['price_after_discount'] ,
      horror: json['product']['horror'],
      images: tmp,
      sellerFirstName: json['seller']['first_name'],
      sellerLastName: json['seller']['last_name'],
      sellerPhoneNumber: json['seller']['phone_number'],
      buyerFirstName: json['buyer']['user']['first_name'],
      buyerLastName: json['buyer']['user']['last_name'],
      buyerPhoneNumber: json['buyer']['user']['phone_number'],
    );
  }
}

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
