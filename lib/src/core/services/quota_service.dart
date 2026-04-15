import '../data/database_helper.dart';
import '../models/quota_model.dart';

class QuotaService {
  Future<QuotaModel?> getQuota() async {
    final data = await DatabaseHelper.instance.getQuota();
    return data.isNotEmpty ? data.first : null;
  }

  Future<void> saveQuota(int maxQuota) async {
    final existing = await getQuota();

    if (existing == null) {
      await DatabaseHelper.instance.insertQuota(
        QuotaModel(maxQuota: maxQuota, usedQuota: 0),
      );
    } else {
      await DatabaseHelper.instance.updateQuota(
        QuotaModel(
          id: existing.id,
          maxQuota: maxQuota,
          usedQuota: existing.usedQuota,
        ),
      );
    }
  }

  Future<void> addUsage(int usage) async {
    final existing = await getQuota();

    if (existing != null) {
      int newUsed = existing.usedQuota + usage;

      await DatabaseHelper.instance.updateQuota(
        QuotaModel(
          id: existing.id,
          maxQuota: existing.maxQuota,
          usedQuota: newUsed,
        ),
      );
    }
  }
}