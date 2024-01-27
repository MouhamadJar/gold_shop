class MyPurchasesModel {
  final int id;
  final int userId;
  final int productId;
  final double amount;
  final double price;
  final int cancel;
  final String code;
  final String createdAt;
  final String updatedAt;
  final double totalAmount;
  final String description;
  final int carat;
  final double weight;

  MyPurchasesModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.amount,
    required this.price,
    required this.cancel,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
    required this.totalAmount,
    required this.description,
    required this.carat,
    required this.weight,
  });

  factory MyPurchasesModel.fromJson({required Map<String, dynamic> json}) {
    return MyPurchasesModel(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      amount: json['amount'],
      price: json['price'],
      cancel: json['cancel'],
      code: json['code'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      totalAmount:json['total_amount'],
      description: json['product']['description'],
      carat: json['product']['carat'],
      weight: json['product']['wight'],
    );
  }
}
