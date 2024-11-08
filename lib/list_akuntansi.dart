import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FakultasAkuntansiScreen(),
    );
  }
}

class FakultasAkuntansiScreen extends StatelessWidget {
  const FakultasAkuntansiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1565C0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fakultas Akuntansi',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Politeknik Negeri Semarang',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildProgramTable('D3', [
              'Keuangan dan Perbankan (A)',
              'Akuntansi (A)',
            ]),
            SizedBox(height: 32.0),
            _buildProgramTable('D4', [
              'Keuangan dan Perbankan (B)',
              'Akuntansi Manajerial (B)',
              'Analisis Sistem Informasi',
              'Perbankan Syariah (A)',
              'Komputerisasi Akuntansi (A)',
            ]),
          ],
            ),
          ),
        ),
          ],
        ),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.grey),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.grey),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildProgramTable(String title, List<String> items) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF1565C0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        DataTable(
          columns: [
            DataColumn(
              label: Text(
                'Program',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: items
              .map(
                (program) => DataRow(
                  cells: [
                    DataCell(Text(program)),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
