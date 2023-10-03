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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Ganti Password'),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
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
              SizedBox(height: 25),
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
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Kembali'),
              ),
              SizedBox(
                height: 200,
              ),
              Row(
                // crossAxisCount: 2,
                // shrinkWrap: true,
                children:[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Warna border
                        width: 2.0, // Lebar border
                      ),
                    ),
                    child: Image(
                      width: 120,
                      image: AssetImage(
                          'images/obito.jpeg'), // Ganti dengan path gambar Anda
                    ),
                  ),
                  SizedBox(width: 4,),
                  Column(
                    children: [
                      Text(
                        'About this App..',
                        style:
                            TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Aplikasi ini dibuat oleh :',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Nama: Irham Izza Syany',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'NIM: 1941720129',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
