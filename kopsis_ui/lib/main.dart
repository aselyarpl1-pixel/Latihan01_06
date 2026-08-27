import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Fungsi untuk memilih icon berdasarkan kategori
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Data Barang
    final List<Map<String, dynamic>> daftarBarang = [
      {
        'nama': 'Buku Tulis',
        'anggota': 3000,
        'umum': 3500,
        'stok': 40,
      },
      {
        'nama': 'Pulpen',
        'anggota': 2500,
        'umum': 3000,
        'stok': 25,
      },
      {
        'nama': 'Roti',
        'anggota': 5000,
        'umum': 5500,
        'stok': 15,
      },
      {
        'nama': 'Pensil',
        'anggota': 2000,
        'umum': 2500,
        'stok': 30,
      },
      {
        'nama': 'Penghapus',
        'anggota': 1500,
        'umum': 2000,
        'stok': 20,
      },
      {
        'nama': 'Teh Botol',
        'anggota': 3000,
        'umum': 3500,
        'stok': 18,
      },
      {
        'nama': 'Air Mineral',
        'anggota': 2000,
        'umum': 2500,
        'stok': 35,
      },
      {
        'nama': 'Keripik',
        'anggota': 2500,
        'umum': 3000,
        'stok': 22,
      },
      {
        'nama': 'Mie Instan',
        'anggota': 4000,
        'umum': 4500,
        'stok': 12,
      },
      {
        'nama': 'Spidol',
        'anggota': 3500,
        'umum': 4000,
        'stok': 10,
      },
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Koperasi Sekolah'),
        ),
        body: ListView.builder(
          itemCount: daftarBarang.length,
          itemBuilder: (context, index) {
            final barang = daftarBarang[index];

            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: const Icon(Icons.inventory_2),
                title: Text(barang['nama']),
                subtitle: Text(
                  'Anggota Rp${barang['anggota']} | Umum Rp${barang['umum']}',
                ),
                trailing: Text(
                  'Stok ${barang['stok']}',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}