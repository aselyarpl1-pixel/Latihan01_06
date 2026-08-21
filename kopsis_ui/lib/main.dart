import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//Fungsi untuk memilih icon berdasarkan kategori
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
  
    //Variabel stok
    int stok = 40;

    //Kategori barang
    String kategori = 'Minuman';

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Koperasi Sekolah')
            ),
          body: Card (
            elevation: 4,
            margin: const EdgeInsets.all(12),
            child: ListTile(
              //icon barang
              leading: Icon(pilihIcon(kategori)),
              //menebalkan nama barang
              title: const Text(
                'Es Campur',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              //harga anggota dan umum
              subtitle: const Text('Anggota Rp3.000 | Umum Rp3.500'),
              //stok barang
              trailing: Text(
                // ignore: prefer_interpolation_to_compose_strings
                'Stok' + stok.toString(),
                style: TextStyle(color: stok == 0 ? Colors.red : Colors.black),
              ),
            ),
          ),
        ),
      );
    }
  }
