import 'package:flutter/material.dart';
import 'package:limit_kuota/src/core/services/quota_service.dart';
import 'package:limit_kuota/src/core/widgets/quota_card.dart';


class QuotaPage extends StatefulWidget {
  const QuotaPage({super.key});

  @override
  State<QuotaPage> createState() => _QuotaPageState();
}

class _QuotaPageState extends State<QuotaPage> {
  final TextEditingController controller = TextEditingController();
  final QuotaService service = QuotaService();

  int maxQuota = 0;
  int usedQuota = 0;

  @override
  void initState() {
    super.initState();
    loadQuota();
  }

  Future<void> loadQuota() async {
    final data = await service.getQuota();
    if (data != null) {
      setState(() {
        maxQuota = data.maxQuota;
        usedQuota = data.usedQuota;
      });
    }
  }

  Future<void> saveQuota() async {
    int input = int.tryParse(controller.text) ?? 0;

    await service.saveQuota(input);
    await loadQuota();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Kuota berhasil disimpan")),
    );
  }

  Future<void> addUsage(int value) async {
    await service.addUsage(value);
    await loadQuota();

    if (maxQuota > 0 && usedQuota >= maxQuota * 0.9) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ Kuota hampir habis!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pengaturan Kuota")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Masukkan batas kuota (MB)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: saveQuota,
              child: const Text("Simpan"),
            ),

            const SizedBox(height: 20),

            QuotaCard(
              used: usedQuota,
              max: maxQuota,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => addUsage(50),
              child: const Text("Tambah Pemakaian 50MB"),
            ),
          ],
        ),
      ),
    );
  }
}