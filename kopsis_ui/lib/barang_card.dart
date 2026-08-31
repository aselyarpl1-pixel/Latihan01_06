import 'package:flutter/material.dart';
import 'keranjang_item.dart';

// BarangCard menggunakan StatelessWidget karena
// tidak memiliki state yang perlu diubah.
class BarangCard extends StatelessWidget {
  final String nama;
  final int hargaAnggota;
  final int stok;
  final String kategori;
  final bool sorot;

  const BarangCard({
    super.key,
    required this.nama,
    required this.hargaAnggota,
    required this.stok,
    required this.kategori,
    this.sorot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),

      // Warna kartu berdasarkan nilai sorot.
      color: sorot
          ? Colors.yellow.shade100
          : Colors.green.shade50,

      child: ListTile(
        // KeranjangItem menangani perubahan jumlah.
        leading: KeranjangItem(
          stok: stok,
          harga: hargaAnggota,
        ),

        // Menampilkan nama barang.
        title: Text(
          nama,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Menampilkan harga anggota.
        subtitle: Text(
          'Anggota Rp$hargaAnggota',
          style: const TextStyle(
            color: Colors.black87,
          ),
        ),

        // Menampilkan kategori dan stok.
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Label kategori.
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                kategori,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 4),

            // Menampilkan stok.
            Text(
              'Stok $stok',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}