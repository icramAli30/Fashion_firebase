class OrderModel {
  final String id;
  final int subtotal;
  final int deliveryFee;
  final int total;
  final String status;
  final List<Map<String, dynamic>> items;

  OrderModel({
    required this.id,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.status,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"],
      subtotal: json["subtotal"] ?? 0,
      deliveryFee: json["deliveryFee"] ?? 0,
      total: json["total"] ?? 0,
      status: json["status"] ?? "Pending",
      items: List<Map<String, dynamic>>.from(json["items"] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "subtotal": subtotal,
      "deliveryFee": deliveryFee,
      "total": total,
      "status": status,
      "items": items,
    };
  }
}