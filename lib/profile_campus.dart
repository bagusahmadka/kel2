import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile/list_ab.dart';
import 'package:profile/list_akuntansi.dart';
import 'package:profile/list_elektro.dart';
import 'package:profile/list_mesin.dart';
import 'package:profile/list_sipil.dart';

import 'list_akuntansi.dart' as list_akuntansi;

const blueTheme = 0xff0059ff;
const greyTheme = 0xff808080;

void main() {
  runApp(ProfileCampus());
}

class ProfileCampus extends StatelessWidget {
  const ProfileCampus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainPage(),
        routes: {
          '/home': (context) => list_akuntansi.MyApp(),
        });
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<String> images = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
  ];

  final List<String> imagesFasilitas = [
    'assets/images/image_fasilitas1.png',
    'assets/images/image_fasilitas2.png',
    'assets/images/image_fasilitas3.png',
    'assets/images/image_fasilitas4.png',
  ];

  final List<String> imagesGaleri = [
    'assets/images/image_galeri1.png',
    'assets/images/image_galeri1.png',
    'assets/images/image_galeri1.png',
    'assets/images/image_galeri1.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Color(blueTheme),
        centerTitle: true,
        title: Text(
          "Profile Kampus",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: const Color(0xffffffff),
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacementNamed(context, '/home')),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Carousel Slider for Image
            CarouselSlider(
              items: images.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 180.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                enlargeCenterPage: true,
                viewportFraction: 1.0,
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 4),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.2), // Warna outline hitam
                  width: 0.5, // Ketebalan outline
                ),
                borderRadius:
                    BorderRadius.circular(5), // Sudut melengkung (opsional)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Bagian kiri: Dua gambar bersebelahan
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        margin: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/rating.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        margin: EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/gmaps.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16), // Spasi antar gambar dan teks

                  // Bagian kanan: Ikon dan teks yang tersusun secara vertikal
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Baris 1: Lokasi
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.blue,
                            size: 16,
                          ),
                          SizedBox(width: 6),
                          Text('Kota Semarang, Jawa Tengah',
                              style: GoogleFonts.poppins(fontSize: 10)),
                        ],
                      ),
                      SizedBox(height: 6), // Jarak antar baris

                      // Baris 2: Akreditasi
                      Row(
                        children: [
                          Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 16,
                          ),
                          SizedBox(width: 6),
                          Text('Akreditasi A',
                              style: GoogleFonts.poppins(fontSize: 10)),
                        ],
                      ),
                      SizedBox(height: 6), // Jarak antar baris

                      // Baris 3: Ranking
                      Row(
                        children: [
                          Icon(Icons.bar_chart, color: Colors.blue, size: 16),
                          SizedBox(width: 6),
                          Text('Ranking 17 di Indonesia',
                              style: GoogleFonts.poppins(fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 4, left: 8, right: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.2),
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12, top: 6),
                    child: Text(
                      'About',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6, left: 12, right: 12),
                    child: Container(
                      // Allows text to take available space
                      child: Text(
                        'Politeknik Negeri Semarang adalah sebuah perguruan tinggi vokasi negeri yang terletak di Jl. Prof. Soedarto, Tembalang, Kota Semarang, Jawa Tengah. Mulanya POLINES bernama Politeknik UNDIP karena berada dalam naungan Universitas Diponegoro.',
                        style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        maxLines: 5, // Control the number of lines
                        overflow:
                            TextOverflow.ellipsis, // Handle overflow gracefully
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'More',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue),
                          ),
                          Icon(Icons.arrow_forward_ios_outlined,
                              color: Colors.blue, size: 16),
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, left: 12, right: 12),
                    child: Divider(
                        color: Colors.black.withOpacity(0.5), thickness: 0.5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6, right: 12, left: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text('Jenis',
                                style: GoogleFonts.poppins(
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)),
                            Text('Politeknik Negeri',
                                style: GoogleFonts.poppins(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15, left: 15),
                          child: Container(
                            width: 0.5,
                            height: 50,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        Column(
                          children: [
                            Text('Mahasiswa',
                                style: GoogleFonts.poppins(
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)),
                            Text('10.000+',
                                style: GoogleFonts.poppins(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            width: 0.5,
                            height: 50,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        Column(
                          children: [
                            Text('Biaya Kuliah',
                                style: GoogleFonts.poppins(
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)),
                            Text('Mulai dari Rp500.000',
                                style: GoogleFonts.poppins(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ],
                    ),

                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6, left: 12, right: 12),
                    child: Divider(
                        color: Colors.black.withOpacity(0.5), thickness: 0.5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 12, right: 12),
                    child: Row(
                      children: [
                        Text(
                          'Fakultas',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue),
                        ),
                        Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(217, 217, 217, 217),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 30,
                        height: 30,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FakultasScreen()),
                            );
                          },
                          child: Icon(Icons.arrow_forward_ios_outlined,
                              color: Colors.blue, size: 16),
                        ),
                      ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 12, right: 12),
                    child: Divider(
                        color: Colors.black.withOpacity(0.5), thickness: 0.5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 12, right: 12),
                    child: Row(
                      children: [
                        Text(
                          'Masa Studi',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue),
                        ),
                        Spacer(),
                        Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(217, 217, 217, 217),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 30,
                            height: 30,
                            child: Icon(Icons.arrow_forward_ios_outlined,
                                color: Colors.blue, size: 16))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 12, right: 12),
                    child: Divider(
                        color: Colors.black.withOpacity(0.5), thickness: 0.5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10, left: 12, right: 12, bottom: 12),
                    child: Row(
                      children: [
                        Text(
                          'Jalur Seleksi',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue),
                        ),
                        Spacer(),
                        Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(217, 217, 217, 217),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 30,
                            height: 30,
                            child: Icon(Icons.arrow_forward_ios_outlined,
                                color: Colors.blue, size: 16))
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 4),
              width: double.infinity,
              // height: 250, // Set a fixed height for the chart
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.2), // Warna outline hitam
                  width: 0.5, // Ketebalan outline
                ),
                borderRadius:
                    BorderRadius.circular(5), // Sudut melengkung (opsional)
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 15,
                    left: 15,
                    right: 15,
                    bottom: 5), // Tambahkan padding atas
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(
                      'Jumlah Mahasiswa 5 Tahun Terakhir',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue),
                    ),
                  ]),
                  SizedBox(
                    height: 15,
                  ),
                  AspectRatio(
                    aspectRatio: 1.5, // Adjust aspect ratio as needed
                    child: BarChart(
                      BarChartData(
                          borderData: FlBorderData(
                            border: const Border(
                              top: BorderSide.none,
                              right: BorderSide.none,
                              left: BorderSide(width: 1),
                              bottom: BorderSide(width: 1),
                            ),
                          ),
                          groupsSpace: 5,
                          barGroups: [
                            BarChartGroupData(x: 20, barRods: [
                              BarChartRodData(
                                fromY: 0,
                                toY: 2120,
                                width: 10,
                                color: Color(0xff0059ff),
                                borderRadius: BorderRadius.zero,
                              )
                            ]),
                            BarChartGroupData(x: 21, barRods: [
                              BarChartRodData(
                                fromY: 0,
                                toY: 1990,
                                width: 10,
                                color: Color(0xff0059ff),
                                borderRadius: BorderRadius.zero,
                              )
                            ]),
                            BarChartGroupData(x: 22, barRods: [
                              BarChartRodData(
                                fromY: 0,
                                toY: 2260,
                                width: 10,
                                color: Color(0xff0059ff),
                                borderRadius: BorderRadius.zero,
                              )
                            ]),
                            BarChartGroupData(x: 23, barRods: [
                              BarChartRodData(
                                fromY: 0,
                                toY: 2320,
                                width: 10,
                                color: Color(0xff0059ff),
                                borderRadius: BorderRadius.zero,
                              )
                            ]),
                            BarChartGroupData(x: 24, barRods: [
                              BarChartRodData(
                                fromY: 0,
                                toY: 2402,
                                width: 10,
                                color: Color(0xff0059ff),
                                borderRadius: BorderRadius.zero,
                              )
                            ]),
                            // Add more BarChartGroupData as needed...
                          ]),
                    ),
                  ),
                ]),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 8, left: 15, right: 15, bottom: 4),
              width: double.infinity, // Set a fixed height for the chart
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.2), // Warna outline hitam
                  width: 0.5, // Ketebalan outline
                ),
                borderRadius:
                    BorderRadius.circular(5), // Sudut melengkung (opsional)
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Fasilitas',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Carousel Slider for Image
                      CarouselSlider(
                        items: imagesFasilitas.map((image) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Image.asset(
                                image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 250.0,
                          autoPlay: false,
                          autoPlayInterval: Duration(seconds: 5),
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                        ),
                      ),
                    ]),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 8, left: 15, right: 15, bottom: 4),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.2), // Warna outline hitam
                  width: 0.5, // Ketebalan outline
                ),
                borderRadius:
                    BorderRadius.circular(5), // Sudut melengkung (opsional)
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Galeri Kampus',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Carousel Slider for Image
                      CarouselSlider(
                        items: imagesGaleri.map((image) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Image.asset(
                                image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 240.0,
                          aspectRatio: 1 / 1,
                          autoPlay: false,
                          autoPlayInterval: Duration(seconds: 5),
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                        ),
                      ),
                    ]),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ),
            ListView.builder(
              shrinkWrap: true, // Adjust size to content
              physics:
                  NeverScrollableScrollPhysics(), // Disable inner scrolling
              itemCount: 3, // Example with 3 news items
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.only(top: 8.0, bottom: 8, right: 12, left: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text Content on the Left
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pendaftar Terus Meningkat, Bukti IISMA menyita Perhatian.',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              '16 September 2024 - 12:50',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      // Image on the Right
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            8), // Optional: Rounded corners
                        child: Image.asset(
                          'assets/images/news_image.jpg', // Replace with your image path
                          width: 80, // Width of 80
                          height: 60, // Height of 60
                          fit: BoxFit.cover, // Ensure image fills the area
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),

    );
  }
}

// Custom InfoBox Widget
class InfoBox extends StatelessWidget {
  final String title;
  final String value;

  const InfoBox({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(value, style: GoogleFonts.poppins()),
      ],
    );
  }
}

// Fakultas Screen
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
