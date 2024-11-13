import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isNewPasswordValid = true;
  bool _isPasswordMatch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ganti Password'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Password saat ini
            TextField(
              controller: _currentPasswordController,
              decoration: InputDecoration(
                labelText: 'Password saat ini',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            
            // Password baru
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'Password baru',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_isPasswordVisible,
              onChanged: (value) {
                setState(() {
                  _isNewPasswordValid = value.length >= 8;
                });
              },
            ),
            if (!_isNewPasswordValid)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '*minimal 8 karakter',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 20),
            
            // Konfirmasi Password baru
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Konfirmasi Password baru',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_isConfirmPasswordVisible,
              onChanged: (value) {
                setState(() {
                  _isPasswordMatch = value == _newPasswordController.text;
                });
              },
            ),
            if (!_isPasswordMatch)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '*password tidak sesuai',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 20),
            
            // Tombol Ubah
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_isNewPasswordValid && _isPasswordMatch) {
                    // Menampilkan popup sukses
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.green,
                          content: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                'Password berhasil dibuat',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                    
                    // Menghilangkan popup setelah beberapa detik
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.of(context).pop(); // Tutup dialog
                      Navigator.pop(context); // Kembali ke halaman sebelumnya
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Periksa input password Anda')),
                    );
                  }
                },
                child: Text('Ubah'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Cari'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
