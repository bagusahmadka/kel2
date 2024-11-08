import 'package:flutter/material.dart';
import 'package:profile/services/api.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const ProfilePage(),
    );
  }
}


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = Api().getProfile(); // Mengambil profil pengguna dari API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, dynamic>>(
          future: userProfile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final userData = snapshot.data;

            if (userData == null || userData.containsKey('message')) {
              return Center(
                child: Text(userData?['message'] ?? 'Error fetching user profile'),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey[700],
                          ),
                        ),
                        const Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    userData['name'] ?? '',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userData['email'] ?? '',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 15),
                  profileDetail('Nama Lengkap', userData['name']),
                  const SizedBox(height: 8),
                  profileDetail('Username', userData['username']),
                  const SizedBox(height: 8),
                  profileDetail('Email', userData['email']),
                  const SizedBox(height: 8),
                  profileDetail('Jenjang Studi', userData['level']),
                  const SizedBox(height: 8),
                  profileDetail('Referensi Jurusan', userData['reference_major']),
                  const SizedBox(height: 8),
                  profileDetail('Referensi Kampus', userData['reference_university']),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Tambahkan navigasi ke halaman Edit Profile jika ada
                    },
                    icon: const Icon(Icons.edit, color: Colors.black),
                    label: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget profileDetail(String title, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7FF),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.grey, width: 1.0),
          ),
          child: Text(
            value ?? '-',
            style: const TextStyle(fontSize: 16.0, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
