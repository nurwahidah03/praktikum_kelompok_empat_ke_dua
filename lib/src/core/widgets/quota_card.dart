import 'package:flutter/material.dart';

class QuotaCard extends StatelessWidget {
  final int used;
  final int max;

  const QuotaCard({required this.used, required this.max});

  @override
  Widget build(BuildContext context) {
    double percent = max == 0 ? 0 : used / max;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Kuota: $used / $max MB"),
            SizedBox(height: 10),
            LinearProgressIndicator(value: percent),
          ],
        ),
      ),
    );
  }
}