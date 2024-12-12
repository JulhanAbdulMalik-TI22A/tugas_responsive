import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
// import 'package:ppm_uts_julhan/pages/home_page.dart';
import 'package:ppm_uts_julhan/pages/home_student.dart';

class HomeProfile extends StatelessWidget {
  static const routeName = "/home-profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://images.theconversation.com/files/560110/original/file-20231117-29-fv986f.jpg?ixlib=rb-4.1.0&rect=0%2C15%2C5048%2C3340&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip'),
                  ),
                ),
                const SizedBox(height: 10),

                const Text(
                  'Julhan A Malik',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Admin - Universitas Nusa Putra',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 20),

                Card(
                  elevation: 2,
                  color: const Color.fromARGB(255, 246, 251, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Icon(Icons.email_rounded),
                          title: Text('Email'),
                          subtitle: Text('julhan_abdul_ti22@nusaputra.ac.id'),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.phone_rounded),
                          title: Text('Contact'),
                          subtitle: Text('+62 831 1103 0309'),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text('Location'),
                          subtitle: Text('Sukabumi, Indonesia'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Settings and logout buttons
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.settings,
                            color: Colors.blueAccent),
                        title: const Text('Settings'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.logout, color: Colors.redAccent),
                        title: const Text('Logout'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      //
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.textIn,
        backgroundColor: Colors.white,
        color: Colors.blue,
        activeColor: Colors.blue,
        curveSize: 70,
        items: const [
          TabItem(icon: Icons.playlist_add_rounded, title: 'Mahasiswa'),
          TabItem(
              icon: Icon(Icons.home_rounded, color: Colors.blue),
              title: 'Home'),
          TabItem(icon: Icons.person_rounded, title: 'Profile'),
        ],
        initialActiveIndex: 2,
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
}
