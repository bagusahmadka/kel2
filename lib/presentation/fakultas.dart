import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FakultasScreen(),
    );
  }
}

class FakultasScreen extends StatelessWidget {
  final List<String> fakultasList = [
    "Fakultas Teknik Elektro",
    "Fakultas Teknik Sipil",
    "Fakultas Teknik Mesin",
    "Fakultas Akuntansi",
    "Fakultas Administrasi Bisnis",
  ];

  FakultasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fakultas"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: fakultasList.length,
        itemBuilder: (context, index) {
          return FakultasCard(title: fakultasList[index]);
        },
      ),
    );
  }
}

class FakultasCard extends StatelessWidget {
  final String title;

  const FakultasCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 2,
        child: ListTile(
          title: Text(title, style: TextStyle(fontSize: 16.0)),
          trailing: ElevatedButton(
            onPressed: () {
              // Aksi ketika tombol "See More" ditekan
            switch (title) {
              case "Fakultas Teknik Elektro":
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FakultasTeknikElektroScreen()),
                );
                break;
              case "Fakultas Teknik Sipil":
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FakultasTeknikSipilScreen()),
                );
                break;
              case "Fakultas Teknik Mesin":
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FakultasTeknikMesinScreen()),
                );
                break;
              case "Fakultas Akuntansi":
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FakultasAkuntansiScreen()),
                );
                break;
              case "Fakultas Administrasi Bisnis":
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FakultasAdministrasiBisnisScreen()),
                );
                break;
              default:
                break;
            }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: Colors.black),
              ),
            ),
            child: Text(
              "See More",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProgramSection(title: "D3", programs: d3Programs),
              SizedBox(height: 16.0),
              ProgramSection(title: "D4", programs: d4Programs),
              SizedBox(height: 16.0),
              ProgramSection(title: "Magister Terapan", programs: magisterPrograms),
            ],
          ),
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
}

class ProgramSection extends StatelessWidget {
  final String title;
  final List<String> programs;

  const ProgramSection({super.key, required this.title, required this.programs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8.0),
        ...programs.map((program) => ProgramCard(program: program)),
      ],
    );
  }
}

class ProgramCard extends StatelessWidget {
  final String program;

  const ProgramCard({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50],
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          program,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}

class FakultasTeknikSipilScreen extends StatelessWidget {
  const FakultasTeknikSipilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fakultas Teknik Sipil\nPoliteknik Negeri Semarang'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: 'D3'),
            ProgramTile(title: 'Konstruksi Gedung (B)'),
            ProgramTile(title: 'Kontruksi Sipil (A)'),
            SizedBox(height: 16.0),
            SectionTitle(title: 'D4'),
            ProgramTile(title: 'Teknik Perawatan dan Perbaikan Gedung (B)'),
            ProgramTile(title: 'Perancangan Jalan dan Jembatan (B)'),
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
}

class SectionTitle extends StatelessWidget {
  final String title;
  
  const SectionTitle({super.key, required this.title});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.all(8.0),
      width: double.infinity,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ProgramTile extends StatelessWidget {
  final String title;

  const ProgramTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(vertical: 16.0),
      margin: EdgeInsets.symmetric(vertical: 2.0),
      width: double.infinity,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class FakultasTeknikMesinScreen extends StatelessWidget {
  const FakultasTeknikMesinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fakultas Teknik Mesin\nPoliteknik Negeri Semarang'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section D3
            SectionTitle(title: 'D3'),
            ProgramTile(title: 'Teknik Mesin'),
            ProgramTile(title: 'Teknik Konversi Energi'),
            SizedBox(height: 16.0),
            // Section D4
            SectionTitle(title: 'D4'),
            ProgramTile(title: 'Teknik Mesin Produksi dan Perawatan'),
            ProgramTile(title: 'Teknik Rekayasa Pembangkit Energi'),
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
}


class FakultasAkuntansiScreen extends StatelessWidget {
  final List<String> d3Programs = [
    "Keuangan dan Perbankan (A)",
    "Akuntansi (A)",
  ];

  final List<String> d4Programs = [
    "Keuangan dan Perbankan (B)",
    "Akuntansi Manajerial (B)",
    "Analisis Sistem Informasi",
    "Perbankan Syariah (A)",
    "Komputerisasi Akuntansi (A)",
  ];

  FakultasAkuntansiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Fakultas Akuntansi", style: TextStyle(fontSize: 18)),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProgramSection(title: "D3", programs: d3Programs),
              SizedBox(height: 16.0),
              ProgramSection(title: "D4", programs: d4Programs),
            ],
          ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProgramSection(title: "D3", programs: d3Programs),
              SizedBox(height: 16.0),
              ProgramSection(title: "D4", programs: d4Programs),
            ],
          ),
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
}