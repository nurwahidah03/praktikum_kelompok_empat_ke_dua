class QuotaModel {
  final int? id;
  final int maxQuota;
  final int usedQuota;

  QuotaModel({
    this.id,
    required this.maxQuota,
    required this.usedQuota,
  });

  // 🔥 SISA KUOTA
  int get remaining => maxQuota - usedQuota;

  // 🔥 PERSENTASE (untuk progress bar & grafik)
  double get percent =>
      maxQuota == 0 ? 0 : usedQuota / maxQuota;

  // 🔥 STATUS (buat notif / UI)
  String get status {
    if (remaining <= 1) return "Habis";
    if (percent > 0.8) return "Hampir Habis";
    return "Aman";
  }

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