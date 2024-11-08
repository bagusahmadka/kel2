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
      home: FakultasTeknikMesinScreen(),
    );
  }
}

class FakultasTeknikMesinScreen extends StatelessWidget {
  const FakultasTeknikMesinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Fakultas Teknik Mesin\nPoliteknik Negeri Semarang',
          textAlign: TextAlign.center,
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
              'Teknik Mesin',
              'Teknik Konversi Energi',
            ]),
            SizedBox(height: 32.0),
            _buildProgramTable('D4', [
              'Teknik Mesin Produksi dan Perawatan',
              'Teknik Rekayasa Pembangkit Energi',
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
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildProgramTable(String title, List<String> programs) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.blue,
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
          rows: programs
              .map(
                (program) => DataRow(
                  cells: [
                    DataCell(
                      Text(program),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
