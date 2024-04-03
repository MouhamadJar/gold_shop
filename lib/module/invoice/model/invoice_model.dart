class PaymentInfoModel {
  final String paymentInfo;

  PaymentInfoModel({required this.paymentInfo});

  factory PaymentInfoModel.fromJson({required Map<String, dynamic> json}) {
    return PaymentInfoModel(paymentInfo: json['payment_policy']);
  }
}

class BankInfoModel {
  final String paymentInfo;

  BankInfoModel({required this.paymentInfo});

  factory BankInfoModel.fromJson({required Map<String, dynamic> json}) {
    return BankInfoModel(paymentInfo: json['bank_account']);
  }
}

class InvoiceModel {
  final int id;
  final int productId;
  final String firstName;
  final String lastName;

  final String description;
  final String carat;
  final dynamic price;
  final dynamic currentGoldPrice;
  final List<dynamic> images;

  InvoiceModel({
    required this.id,
    required this.productId,
    required this.firstName,
    required this.lastName,
    required this.description,
    required this.carat,
    required this.price,
    required this.currentGoldPrice,
    required this.images,
  });

  factory InvoiceModel.fromJson({required Map<String, dynamic> json}) {
    return InvoiceModel(
      id: json['buyer']['id'],
      productId: json['product']['id'],
      firstName: json['buyer']['first_name'],
      lastName: json['buyer']['last_name'],
      description: json['product']['description'],
      carat: json['product']['carat'],
      price: json['product']['price'],
      currentGoldPrice: json['product']['current_gold_price'],
      images: json['product']['images'],
    );
  }
}
