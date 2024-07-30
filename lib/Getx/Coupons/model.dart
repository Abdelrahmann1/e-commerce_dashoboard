class CouponModel {
  String? id;
  String? code;
  String? discountType;
  double? discountAmount;
  double? minimumPurchaseAmount;
  DateTime? expiryDate;
  String? status;
  // String? applicableCategoryId;
  // String? applicableSubCategoryId;
  // String? applicableProductId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int usageCount; // Add this field

  CouponModel({
    this.id,
    this.code,
    this.discountType,
    this.discountAmount,
    this.minimumPurchaseAmount,
    this.expiryDate,
    this.status,
    // this.applicableCategoryId,
    // this.applicableSubCategoryId,
    // this.applicableProductId,
    this.createdAt,
    this.updatedAt,
    this.usageCount = 0, // Initialize with a default value
  });

  CouponModel copyWith({
    String? id,
    String? code,
    String? discountType,
    double? discountAmount,
    double? minimumPurchaseAmount,
    DateTime? expiryDate,
    String? status,
    String? applicableCategoryId,
    String? applicableSubCategoryId,
    String? applicableProductId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? usageCount,
  }) {
    return CouponModel(
      id: id ?? this.id,
      code: code ?? this.code,
      discountType: discountType ?? this.discountType,
      discountAmount: discountAmount ?? this.discountAmount,
      minimumPurchaseAmount: minimumPurchaseAmount ?? this.minimumPurchaseAmount,
      expiryDate: expiryDate ?? this.expiryDate,
      status: status ?? this.status,
      // applicableCategoryId: applicableCategoryId ?? this.applicableCategoryId,
      // applicableSubCategoryId: applicableSubCategoryId ?? this.applicableSubCategoryId,
      // applicableProductId: applicableProductId ?? this.applicableProductId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      usageCount: usageCount ?? this.usageCount,
    );
  }

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'],
      code: json['code'],
      discountType: json['discountType'],
      discountAmount: json['discountAmount']?.toDouble(),
      minimumPurchaseAmount: json['minimumPurchaseAmount']?.toDouble(),
      expiryDate: json['expiryDate'] != null ? DateTime.parse(json['expiryDate']) : null,
      status: json['status'],
      // applicableCategoryId: json['applicableCategoryId'],
      // applicableSubCategoryId: json['applicableSubCategoryId'],
      // applicableProductId: json['applicableProductId'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      usageCount: json['usageCount'] ?? 0, // Handle usageCount
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'discountType': discountType,
      'discountAmount': discountAmount,
      'minimumPurchaseAmount': minimumPurchaseAmount,
      'expiryDate': expiryDate?.toIso8601String(),
      'status': status,
      // 'applicableCategoryId': applicableCategoryId,
      // 'applicableSubCategoryId': applicableSubCategoryId,
      // 'applicableProductId': applicableProductId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'usageCount': usageCount, // Add usageCount to JSON
    };
  }
}


