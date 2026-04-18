import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../monitoring/network_page.dart';
import '../monitoring/history_page.dart';
import 'package:limit_kuota/src/screen/grafik_batang_page.dart';
import 'package:limit_kuota/src/features/monitoring/pages/quota_page.dart';
import 'package:limit_kuota/src/core/theme/theme_provider.dart';
import 'package:limit_kuota/src/core/services/notif_service.dart';
import 'package:limit_kuota/src/core/services/quota_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final quota = await QuotaService().getQuota();
      if (quota != null && quota.remaining < 2) {
        NotifService.showWarning(context, "Kuota kamu hampir habis!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // 🔵 HEADER
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [Colors.grey.shade900, Colors.black]
                      : [Color(0xFF4A90E2), Color(0xFF007AFF)],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Dashboard",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // tombol dark mode
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        context.watch<ThemeProvider>().isDark
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        context.read<ThemeProvider>().toggleTheme();
                      },
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Pantau penggunaan kuota kamu",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 📌 MENU TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Menu Utama",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // 📱 GRID MENU
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    menuCard(
                      context: context,
                      title: "Network",
                      icon: Icons.network_check,
                      page: const Network(),
                      color: Colors.blue,
                    ),
                    menuCard(
                      context: context,
                      title: "History",
                      icon: Icons.history,
                      page: const HistoryPage(),
                      color: Colors.orange,
                    ),
                    menuCard(
                      context: context,
                      title: "Grafik",
                      icon: Icons.bar_chart,
                      page: GrafikBatangPage(),
                      color: Colors.purple,
                    ),
                    menuCard(
                      context: context,
                      title: "Kuota",
                      icon: Icons.data_usage,
                      page: const QuotaPage(),
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget menuCard({
  required BuildContext context,
  required String title,
  required IconData icon,
  required Widget page,
  required Color color,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: isDark
              ? [color.withOpacity(0.6), color.withOpacity(0.9)]
              : [color.withOpacity(0.8), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.4)
                : color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget infoCard(BuildContext context, String title, String value) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Theme.of(context).shadowColor.withOpacity(0.2),
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    ),
  );
}
