import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Koperasi Sekolah')),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Buku Tulis'),

                //memberi jarak antara nama barang dan harga
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //mengatur jarak harga agar tidak berdekatan
                  children: const [
                    Text('Anggota: Rp3.000'),
                    Text('Umum: Rp3.500'),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
