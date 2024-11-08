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
      home: FakultasTeknikElektroScreen(),
    );
  }
}

class FakultasTeknikElektroScreen extends StatelessWidget {
  final List<String> d3Programs = [
    "Teknik Listrik (A)",
    "Teknik Elektronika (A)",
    "Teknik Telekomunikasi (B)",
    "Teknik Informatika (A)",
  ];

  final List<String> d4Programs = [
    "Teknik Telekomunikasi (A)",
    "Teknologi Rekayasa Instalasi Listrik (B)",
    "Teknologi Rekayasa Komputer (B)",
    "Teknologi Rekayasa Elektronika (B)",
  ];

  final List<String> magisterPrograms = [
    "Teknik Telekomunikasi (A)",
  ];

  FakultasTeknikElektroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Fakultas Teknik Elektro", style: TextStyle(fontSize: 18)),
            Text(
              "Politeknik Negeri Semarang",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
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
            _buildProgramTable("D3", d3Programs),
            SizedBox(height: 32.0),
            _buildProgramTable("D4", d4Programs),
            SizedBox(height: 32.0),
            _buildProgramTable("Magister Terapan", magisterPrograms),
          ],
            ),
          ),
        ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.grey),
            label: "Cari",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.grey),
            label: "Profil",
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Aksi ketika navigasi ditekan
        },
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
