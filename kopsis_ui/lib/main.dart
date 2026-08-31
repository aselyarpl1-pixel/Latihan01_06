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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Koperasi Sekolah'),
        ),

        body: tampilkanBarang
            ? ListView.builder(
                itemCount: barangTersedia.length,
                itemBuilder: (context, index) {
                  final barang = barangTersedia[index];

                  return BarangCard(
                    nama: barang['nama'],
                    hargaAnggota: barang['anggota'],
                    stok: barang['stok'],
                    kategori: barang['kategori'],
                    sorot: true,
                  );
                },
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