class ProductoOferta {
  int id;
  String number;
  String status;
  String currency;
  String dateCreated;
  String total;
  int customerId;
  List<LineItems> lineItems;

  ProductoOferta(
      {this.id,
        this.number,
        this.status,
        this.currency,
        this.dateCreated,
        this.total,
        this.customerId,
        this.lineItems});

  ProductoOferta.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    status = json['status'];
    currency = json['currency'];
    dateCreated = json['date_created'];
    total = json['total'];
    customerId = json['customer_id'];
    if (json['line_items'] != null) {
      lineItems = new List<LineItems>();
      json['line_items'].forEach((v) {
        lineItems.add(new LineItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['status'] = this.status;
    data['currency'] = this.currency;
    data['date_created'] = this.dateCreated;
    data['total'] = this.total;
    data['customer_id'] = this.customerId;
    if (this.lineItems != null) {
      data['line_items'] = this.lineItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LineItems {
  final int id;
  final String name;
  final int productId;
  final String subtotal;
  final String total;

  LineItems({this.id, this.name, this.productId, this.subtotal, this.total});

  LineItems.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    name = json['name'],
    productId = json['product_id'],
    subtotal = json['subtotal'],
    total = json['total'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['product_id'] = this.productId;
    data['subtotal'] = this.subtotal;
    data['total'] = this.total;
    return data;
  }
}