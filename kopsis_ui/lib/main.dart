import 'package:flutter/material.dart';
import 'barang_card.dart';

void main() {
  runApp(const MyApp());
}

// Fungsi memilih icon berdasarkan kategori
IconData pilihIcon(String kategori) {
  if (kategori == 'ATK') {
    return Icons.edit;
  } else if (kategori == 'Makanan') {
    return Icons.fastfood;
  } else if (kategori == 'Minuman') {
    return Icons.local_drink;
  } else {
    return Icons.inventory_2;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Mengatur apakah daftar barang ditampilkan
  bool tampilkanBarang = true;

  // TAMBAHAN: Controller untuk mengontrol isi kotak pencarian
  late TextEditingController _controller;

  // TAMBAHAN: Menyimpan kata yang sedang dimasukkan pada kotak pencarian
  String kataCari = '';

  // TAMBAHAN: Menjalankan controller satu kali ketika halaman dibuat
  @override
  void initState() {
    super.initState();

    // Membuat TextEditingController untuk kotak pencarian
    _controller = TextEditingController();
  }

  // TAMBAHAN: Membersihkan controller ketika halaman ditutup
  @override
  void dispose() {
    // Menghapus controller agar tidak menyebabkan kebocoran resource
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Data barang
    final List<Map<String, dynamic>> daftarBarang = [
      {
        'nama': 'Buku Tulis',
        'anggota': 3000,
        'umum': 3500,
        'stok': 40,
        'kategori': 'ATK',
      },
      {
        'nama': 'Pulpen',
        'anggota': 2500,
        'umum': 3000,
        'stok': 25,
        'kategori': 'ATK',
      },
      {
        'nama': 'Roti',
        'anggota': 5000,
        'umum': 5500,
        'stok': 0,
        'kategori': 'Makanan',
      },
      {
        'nama': 'Pensil',
        'anggota': 2000,
        'umum': 2500,
        'stok': 30,
        'kategori': 'ATK',
      },
      {
        'nama': 'Penghapus',
        'anggota': 1500,
        'umum': 2000,
        'stok': 20,
        'kategori': 'ATK',
      },
      {
        'nama': 'Teh Botol',
        'anggota': 3000,
        'umum': 3500,
        'stok': 18,
        'kategori': 'Minuman',
      },
      {
        'nama': 'Air Mineral',
        'anggota': 2000,
        'umum': 2500,
        'stok': 35,
        'kategori': 'Minuman',
      },
      {
        'nama': 'Keripik',
        'anggota': 2500,
        'umum': 3000,
        'stok': 22,
        'kategori': 'Makanan',
      },
      {
        'nama': 'Mie Instan',
        'anggota': 4000,
        'umum': 4500,
        'stok': 12,
        'kategori': 'Makanan',
      },
      {
        'nama': 'Spidol',
        'anggota': 3500,
        'umum': 4000,
        'stok': 10,
        'kategori': 'ATK',
      },
    ];

    // Hanya menampilkan barang yang stoknya lebih dari 0
    final barangTersedia =
        daftarBarang.where((barang) => barang['stok'] > 0).toList();

    // TAMBAHAN: Menyaring daftar barang berdasarkan kata yang diketik
    final hasilCari = barangTersedia
        .where(
          (barang) => barang['nama']
              .toString()
              .toLowerCase()
              .contains(kataCari),
        )
        .toList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(
          title: const Text('Koperasi Sekolah'),
        ),

        body: tampilkanBarang
            ? Center(
                // PERBAIKAN/TAMBAHAN TUGAS:
                // LayoutBuilder digunakan untuk mengetahui
                // lebar area yang tersedia.
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // PERBAIKAN/TAMBAHAN TUGAS:
                    // Lebar tampilan dibuat 1000 px untuk pengujian
                    // kondisi antara 900 sampai 1999 px.
                    final double lebarTampilan =
                        constraints.maxWidth < 1000
                            ? constraints.maxWidth
                            : 1000;
                    // PERBAIKAN/TAMBAHAN TUGAS:
                    // Menentukan jumlah kolom berdasarkan lebar
                    int kolom;

                    if (lebarTampilan < 600) {
                      // Kurang dari 600 px = 1 kolom
                      kolom = 1;
                    } else if (lebarTampilan < 900) {
                      // 600 sampai 899 px = 2 kolom
                      kolom = 2;
                    } else {
                      // 900 px atau lebih = 3 kolom
                      kolom = 3;
                    }

                    return SizedBox(
                      width: lebarTampilan,

                      child: Column(
                        children: [
                          // TAMBAHAN: Kotak pencarian barang
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextField(
                              // Menghubungkan TextField dengan controller
                              controller: _controller,

                              // Mengatur tampilan kotak pencarian
                              decoration: const InputDecoration(
                                hintText: 'Cari barang...',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(),
                              ),

                              // TAMBAHAN:
                              // Menjalankan pencarian setiap kali teks berubah
                              onChanged: (nilai) {
                                setState(() {
                                  // Mengubah kata pencarian menjadi huruf kecil
                                  // agar pencarian tidak membedakan huruf besar/kecil
                                  kataCari = nilai.toLowerCase();
                                });
                              },
                            ),
                          ),

                          // PERBAIKAN/TAMBAHAN TUGAS:
                          // Menampilkan lebar tampilan yang benar-benar
                          // digunakan dalam pengujian.
                          Text(
                            'Lebar layar: '
                            '${lebarTampilan.toStringAsFixed(0)} px',
                          ),

                          // PERBAIKAN/TAMBAHAN TUGAS:
                          // GridView digunakan untuk menampilkan barang
                          // dalam jumlah kolom yang berbeda sesuai lebar.
                          Expanded(
                            child: GridView.builder(
                              // PERBAIKAN/TAMBAHAN TUGAS:
                              // Menentukan jumlah kolom berdasarkan
                              // lebar tampilan.
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: kolom,

                                // Mengatur perbandingan lebar dan tinggi kartu
                                childAspectRatio: 3,
                              ),

                              // Jumlah kartu mengikuti hasil pencarian
                              itemCount: hasilCari.length,

                              itemBuilder: (context, index) {
                                // Mengambil data barang
                                final barang = hasilCari[index];

                                // Menampilkan barang menggunakan BarangCard
                                return BarangCard(
                                  nama: barang['nama'],
                                  hargaAnggota: barang['anggota'],
                                  stok: barang['stok'],
                                  kategori: barang['kategori'],
                                  sorot: true,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            : const Center(
                child: Text(
                  'Barang sudah dihapus',
                  style: TextStyle(fontSize: 18),
                ),
              ),

        // Tombol hapus
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              tampilkanBarang = false;
            });
          },
          child: const Icon(Icons.delete),
        ),
      ),
    );
  }
}