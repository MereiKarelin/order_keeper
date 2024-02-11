class OrderResponseModel {
  int? id;
  int? tableId;
  int? quantity;
  String? productName;
  String? productPrice;

  OrderResponseModel(
      {this.id,
      this.tableId,
      this.quantity,
      this.productName,
      this.productPrice});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'table_id': tableId,
      'quantity': quantity,
      'product_name': productName,
      'product_price': productPrice,
    };
  }

  static OrderResponseModel fromMap(Map<String, dynamic> map) {
    return OrderResponseModel(
      id: map['id'],
      tableId: map['table_id'],
      quantity: map['quantity'],
      productName: map['product_name'],
      productPrice: map['product_price'],
    );
  }
}
