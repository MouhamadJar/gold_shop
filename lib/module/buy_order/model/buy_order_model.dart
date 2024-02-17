class BuyOrderModel {
  final int buyerId;
  final String buyerFirstName;

  final String buyerLastName;

  final String buyerNumber;

  final int sellerId;

  final String sellerFirstName;

  final String sellerLastName;

  final String sellerPhoneNumber;

  final String country;

  final String state;

  final String city;

  final String neighborhood;

  final String street;

  final double longitude;

  final double latitude;

  final int productId;

  final String description;

  final dynamic carat;

  final dynamic productPrice;

  final List<dynamic> images;

  final String? orderCode;

  BuyOrderModel({
    required this.buyerId,
    required this.buyerFirstName,
    required this.buyerLastName,
    required this.buyerNumber,
    required this.sellerId,
    required this.sellerFirstName,
    required this.sellerLastName,
    required this.sellerPhoneNumber,
    required this.country,
    required this.state,
    required this.city,
    required this.neighborhood,
    required this.street,
    required this.longitude,
    required this.latitude,
    required this.productId,
    required this.description,
    this.carat,
    this.productPrice,
    required this.images,
    required this.orderCode,
  });

  factory BuyOrderModel.fromJson({required Map<String, dynamic> json}) {
    return BuyOrderModel(
      buyerId: json['buyer']['id'],
      buyerFirstName: json['buyer']['first_name'],
      buyerLastName: json['buyer']['last_name'],
      buyerNumber: json['buyer']['phone_number'],
      sellerId: json['seller']['id'],
      sellerFirstName: json['seller']['first_name'],
      sellerLastName: json['seller']['last_name'],
      sellerPhoneNumber: json['seller']['phone_number'],
      country: json['seller']['country'],
      state: json['seller']['state'],
      city: json['seller']['city'],
      neighborhood: json['seller']['neighborhood'],
      street: json['seller']['street'],
      longitude: json['seller']['longitude'],
      latitude: json['seller']['latitude'],
      productId: json['product']['id'],
      description: json['product']['description'],
      images: json['product']['images'],
      carat: json['product']['carat'],
      productPrice: json['product_price'],
      orderCode: json['order_code'],
    );
  }
}
