import 'package:flutter/material.dart';
import 'models/database_helper.dart'; // Gantilah impor sesuai dengan aplikasi Anda

class pengaturanPage extends StatefulWidget {
  final String username;

  pengaturanPage({required this.username});

  @override
  pengaturanPageState createState() => pengaturanPageState();
}

class pengaturanPageState extends State<pengaturanPage> {
  final dbHelper = DatabaseHelper();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ganti Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password Saat Ini',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password Baru',
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                final currentPassword = currentPasswordController.text;
                final newPassword = newPasswordController.text;
                final isPasswordCorrect =
                    await dbHelper.login(widget.username, currentPassword);
                if (isPasswordCorrect) {
                  await dbHelper.changePassword(widget.username, newPassword);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Password berhasil diganti.'),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Password saat ini salah.'),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ));
                }
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
