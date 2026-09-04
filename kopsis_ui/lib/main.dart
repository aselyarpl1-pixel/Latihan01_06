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
  bool tampilkanBarang = true;

  // Controller untuk kotak pencarian
  late TextEditingController _controller;

  // Menyimpan kata yang dicari
  String kataCari = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // =========================
    // DATA BARANG
    // =========================
    final List<Map<String, dynamic>> daftarBarang = [
      {
        'nama': 'Buku Tulis Bergaris 58 Lembar Sampul Tebal',
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

    // =========================
    // FILTER STOK
    // =========================
    final barangTersedia =
        daftarBarang.where((barang) {
          return barang['stok'] > 0;
        }).toList();

    // =========================
    // FILTER PENCARIAN
    // =========================
    final hasilCari =
        barangTersedia.where((barang) {
          return barang['nama']
              .toString()
              .toLowerCase()
              .contains(kataCari);
        }).toList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(
          title: const Text('Koperasi Sekolah'),
        ),

        // =========================
        // BODY
        // =========================
        body: tampilkanBarang
            ? Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {

                    // Membatasi lebar tampilan maksimal 600 px
                    final double lebarTampilan =
                        constraints.maxWidth < 1000
                            ? constraints.maxWidth
                            : 1000;

                    // =========================
                    // MENENTUKAN JUMLAH KOLOM
                    // =========================
                    int kolom;

                    if (lebarTampilan < 600) {
                      kolom = 1;
                    } else if (lebarTampilan < 900) {
                      kolom = 2;
                    } else {
                      kolom = 3;
                    }

                    return SizedBox(
                      width: lebarTampilan,

                      child: Column(
                        children: [

                          // =========================
                          // KOTAK PENCARIAN
                          // =========================
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: TextField(
                              controller: _controller,

                              decoration: const InputDecoration(
                                hintText: 'Cari barang...',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(),
                              ),

                              onChanged: (nilai) {
                                setState(() {
                                  kataCari = nilai.toLowerCase();
                                });
                              },
                            ),
                          ),

                          // =========================
                          // INFORMASI LEBAR LAYAR
                          // =========================
                          Text(
                            'Lebar layar: '
                            '${lebarTampilan.toStringAsFixed(0)} px',
                          ),

                          const SizedBox(height: 8),

                          // =========================
                          // GRID BARANG
                          // =========================
                          Expanded(
                            child: GridView.builder(
                              padding: const EdgeInsets.all(8),

                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                // Jumlah kolom
                                crossAxisCount: kolom,

                                // Card dibuat lebih tinggi
                                // agar tidak overflow
                                childAspectRatio: 1.5,

                                // Jarak antar kolom
                                crossAxisSpacing: 8,

                                // Jarak antar baris
                                mainAxisSpacing: 8,
                              ),

                              // Jumlah barang
                              itemCount: hasilCari.length,

                              itemBuilder: (context, index) {
                                final barang = hasilCari[index];

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

            // =========================
            // JIKA BARANG DIHAPUS
            // =========================
            : const Center(
                child: Text(
                  'Barang sudah dihapus',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),

        // =========================
        // TOMBOL HAPUS
        // =========================
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