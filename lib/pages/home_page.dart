import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ppm_uts_julhan/pages/home_profile.dart';
import 'package:ppm_uts_julhan/pages/home_student.dart';

class HomePage extends StatelessWidget {
  // static const routeName = "/home-page";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, right: 15, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello, Julhan!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              'Selamat datang di Dashboard',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 13,
                mainAxisSpacing: 13,
                children: [
                  _buildDashboardCard(
                    icon: Icons.person_rounded,
                    color: Colors.greenAccent,
                    title: 'Profile',
                    onTap: () {
                      Navigator.pushNamed(context, HomeProfile.routeName);
                    },
                  ),
                  _buildDashboardCard(
                    icon: Icons.people,
                    color: Colors.orangeAccent,
                    title: 'Mahasiswa',
                    onTap: () {
                      Navigator.pushNamed(context, HomeStudent.routeName);
                    },
                  ),
                  _buildDashboardCard(
                    icon: Icons.account_balance_wallet,
                    color: Colors.blueAccent,
                    title: 'Pembayaran',
                    onTap: () {},
                  ),
                  _buildDashboardCard(
                    icon: Icons.library_books,
                    color: Colors.redAccent,
                    title: 'Perpustakaan',
                    onTap: () {},
                  ),
                  _buildDashboardCard(
                    icon: Icons.event,
                    color: Colors.purpleAccent,
                    title: 'Event Kampus',
                    onTap: () {},
                  ),
                  _buildDashboardCard(
                    icon: Icons.schedule,
                    color: Colors.tealAccent,
                    title: 'Jadwal Kuliah',
                    onTap: () {},
                  ),
                  _buildDashboardCard(
                    icon: Icons.help_center,
                    color: Colors.amber,
                    title: 'Pusat Bantuan',
                    onTap: () {},
                  ),
                  _buildDashboardCard(
                    icon: Icons.forum,
                    color: Colors.indigoAccent,
                    title: 'Forum Mahasiswa',
                    onTap: () {},
                  ),
                  const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.textIn,
        backgroundColor: Colors.white,
        color: Colors.blue,
        activeColor: Colors.blue,
        curveSize: 70,
        items: const [
          TabItem(icon: Icons.playlist_add_rounded, title: 'Mahasiswa'),
          TabItem(
              icon: Icon(Icons.home_rounded, size: 35, color: Colors.blue),
              title: 'Home'),
          TabItem(icon: Icons.person_rounded, title: 'Profile'),
        ],
        initialActiveIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, HomeStudent.routeName);
              break;
            case 1:
              Navigator.pushNamed(context, '/home-page');
              break;
            case 2:
              Navigator.pushNamed(context, HomeProfile.routeName);
              break;
          }
        },
      ),
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
