class QuotaModel {
  final int? id;
  final int maxQuota;
  final int usedQuota;

  QuotaModel({
    this.id,
    required this.maxQuota,
    required this.usedQuota,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'maxQuota': maxQuota,
      'usedQuota': usedQuota,
    };
  }

  factory QuotaModel.fromMap(Map<String, dynamic> map) {
    return QuotaModel(
      id: map['id'],
      maxQuota: map['maxQuota'],
      usedQuota: map['usedQuota'],
    );
  }
}