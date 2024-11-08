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
      home: FakultasAdministrasiBisnisScreen(),
    );
  }
}

class FakultasAdministrasiBisnisScreen extends StatelessWidget {
  final List<String> d3Programs = [
    "Administrasi Bisnis (A)",
    "Manajemen Pemasaran (A1)",
  ];

  final List<String> d4Programs = [
    "Manajemen Bisnis International (A)",
    "Administrasi Bisnis Terapan (B)",
  ];

  FakultasAdministrasiBisnisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Fakultas Administrasi Bisnis", style: TextStyle(fontSize: 18)),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProgramSection(title: "D3", programs: d3Programs),
            SizedBox(height: 32.0), // Adjusted spacing between sections
            ProgramSection(title: "D4", programs: d4Programs),
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
          // Handle navigation tap
        },
      ),
    );
  }
}

class ProgramSection extends StatelessWidget {
  final String title;
  final List<String> programs;

  const ProgramSection({super.key, required this.title, required this.programs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        Center(
          child: DataTable(
            columns: [
              DataColumn(label: Text('Program', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: programs
                .map(
                  (program) => DataRow(
                    cells: [
                      DataCell(Text(program)),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
