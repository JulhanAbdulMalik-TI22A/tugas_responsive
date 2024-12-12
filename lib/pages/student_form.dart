// lib/student_form.dart
import 'package:flutter/material.dart';
import 'package:ppm_uts_julhan/models/student_model.dart';
import 'package:ppm_uts_julhan/services/student_service.dart';

class StudentForm extends StatefulWidget {
  final Student? student;

  StudentForm({this.student});

  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  final StudentService _studentService = StudentService();

  late TextEditingController _nameController;
  late TextEditingController _prodiController;
  late TextEditingController _emailController;
  late TextEditingController _avatarController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student?.name ?? '');
    _prodiController = TextEditingController(text: widget.student?.prodi ?? '');
    _emailController = TextEditingController(text: widget.student?.email ?? '');
    _avatarController =
        TextEditingController(text: widget.student?.avatar ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _prodiController.dispose();
    _emailController.dispose();
    _avatarController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final student = Student(
        id: widget.student?.id ?? '',
        name: _nameController.text,
        prodi: _prodiController.text,
        email: _emailController.text,
        avatar: _avatarController.text,
        createdAt: widget.student?.createdAt ?? DateTime.now(),
      );

      if (widget.student == null) {
        await _studentService.createStudent(student);
      } else {
        await _studentService.updateStudent(student.id, student);
      }

      Navigator.pop(context, true); // Kembali dan refresh data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.student == null ? 'Tambah Mahasiswa' : 'Edit Mahasiswa'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: Colors.white),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  widget.student == null
                      ? const SizedBox()
                      : Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(_avatarController.text),
                                ),
                              ),
                            ),
                          ),
                        ),

                  //
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _nameController,
                    autocorrect: false,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: "Nama Lengkap",
                      filled: true,
                      fillColor: Color.fromARGB(255, 236, 246, 255),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _prodiController,
                    autocorrect: false,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: "Program Studi",
                      filled: true,
                      fillColor: Color.fromARGB(255, 236, 246, 255),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Prodi tidak boleh kosong';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _emailController,
                    autocorrect: false,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      filled: true,
                      fillColor: Color.fromARGB(255, 236, 246, 255),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _avatarController,
                    autocorrect: false,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: "Image URL",
                      filled: true,
                      fillColor: Color.fromARGB(255, 236, 246, 255),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Avatar tidak boleh kosong';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 50),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _submitForm,
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 236, 246, 255),
                        ),
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.only(right: 25, left: 25),
                        ),
                      ),
                      child: Text(
                        widget.student == null ? 'Tambah' : 'Simpan',
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
