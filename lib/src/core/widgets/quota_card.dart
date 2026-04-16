import 'package:flutter/material.dart';

class QuotaCard extends StatelessWidget {
  final int used;
  final int max;

  const QuotaCard({
    super.key,
    required this.used,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    double percent = max == 0 ? 0 : used / max;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Kuota: $used / $max MB"),
            const SizedBox(height: 10),
            LinearProgressIndicator(value: percent),
          ],
        ),
      ),
    );
  }
}