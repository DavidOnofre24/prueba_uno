class Coupon {
  Coupon({
    this.id,
    this.code,
    this.description,
    this.type,
    this.payload,
  });

  int? id;
  String? code;
  String? description;
  String? type;
  Map<String, dynamic>? payload;

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json["id"],
      code: json["code"],
      description: json["description"],
      type: json["type"],
      payload: json["payload"],
    );
  }
}
