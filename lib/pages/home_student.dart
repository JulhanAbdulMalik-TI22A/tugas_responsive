import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:ppm_uts_julhan/models/student_model.dart';
// import 'package:ppm_uts_julhan/pages/home_page.dart';
import 'package:ppm_uts_julhan/pages/home_profile.dart';
import 'package:ppm_uts_julhan/pages/student_form.dart';
import 'package:ppm_uts_julhan/services/student_service.dart';

class HomeStudent extends StatefulWidget {
  static const routeName = "/home-player";

  @override
  State<HomeStudent> createState() => _HomeStudentState();
}

class _HomeStudentState extends State<HomeStudent> {
  //
  final StudentService _studentService = StudentService();
  late Future<List<Student>> _students;

  @override
  void initState() {
    super.initState();
    _students = _studentService.getStudents();
  }

  void _refreshStudents() {
    setState(() {
      _students = _studentService.getStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mahasiswa"),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Student>>(
        future: _students,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data mahasiswa'));
          }

          return Padding(
            padding:
                const EdgeInsets.only(top: 5, right: 10, left: 10, bottom: 50),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final student = snapshot.data![index];
                return Card(
                  color: const Color.fromARGB(255, 246, 251, 255),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(student.avatar),
                    ),
                    title: Text(student.name),
                    subtitle: Text(student.prodi),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'edit') {
                          // Aksi untuk Edit
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StudentForm(student: student),
                            ),
                          );
                          if (result == true) {
                            _refreshStudents();
                          }
                        } else if (value == 'delete') {
                          // Tampilkan dialog konfirmasi sebelum menghapus
                          bool? confirmDelete = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Konfirmasi Hapus'),
                                content: const Text(
                                    'Apakah Anda yakin ingin menghapus data ini?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(false); // Tidak jadi menghapus
                                    },
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(true); // Konfirmasi menghapus
                                    },
                                    child: const Text(
                                      'Hapus',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );

                          // Jika pengguna mengonfirmasi penghapusan
                          if (confirmDelete == true) {
                            await _studentService.deleteStudent(student.id);
                            _refreshStudents();
                          }
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: Colors.blue, size: 20),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red, size: 20),
                              SizedBox(width: 8),
                              Text('Delete'),
                            ],
                          ),
                        ),
                      ],
                      icon: const Icon(
                        Icons.more_vert_rounded,
                        size: 22,
                      ), // Ikon untuk tombol popup
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),

      //
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentForm(),
            ),
          );
          if (result == true) {
            _refreshStudents();
          }
        },
        child: const Icon(Icons.add),
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
        initialActiveIndex: 0,
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
