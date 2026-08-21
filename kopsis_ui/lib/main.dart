import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  
    //Variabel stok
    int stok = 40;

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Koperasi Sekolah')
            ),
          body: Card (
            margin: const EdgeInsets.all(12),
            child: ListTile(
              //icon barang
              leading: const Icon(Icons.inventory_2),
              //menebalkan nama barang
              title: const Text(
                'Buku Tulis',
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
