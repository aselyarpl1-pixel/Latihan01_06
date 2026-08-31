import 'package:flutter/material.dart';

// KeranjangItem menggunakan StatefulWidget
// karena jumlah barang dapat berubah saat tombol + atau - ditekan.
class KeranjangItem extends StatefulWidget {
  final int stok;
  final int harga;

  const KeranjangItem({
    super.key,
    required this.stok,
    required this.harga,
  });

  @override
  State<KeranjangItem> createState() => _KeranjangItemState();
}

// State untuk menyimpan jumlah barang yang dipilih.
class _KeranjangItemState extends State<KeranjangItem> {
  late int jumlah;

  @override
  void initState() {
    super.initState();

    // Jika stok tersedia, jumlah awal adalah 1.
    // Jika stok 0, jumlah awal adalah 0.
    jumlah = widget.stok > 0 ? 1 : 0;
  }

  // Fungsi untuk mengurangi jumlah barang.
  void kurangiJumlah() {
    if (jumlah > 0) {
      setState(() {
        jumlah--;
      });
    }
  }

  // Fungsi untuk menambah jumlah barang.
  void tambahJumlah() {
    // Jumlah tidak boleh melebihi stok.
    if (jumlah < widget.stok) {
      setState(() {
        jumlah++;
      });
    } else {
      // Menampilkan pesan jika jumlah sudah mencapai stok.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Jumlah tidak boleh melebihi stok barang',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Menghitung total harga berdasarkan jumlah barang.
    int totalHarga = widget.harga * jumlah;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol untuk mengurangi jumlah.
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: kurangiJumlah,
        ),

        // Menampilkan jumlah dan total harga.
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              jumlah.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              'Rp$totalHarga',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        // Tombol untuk menambah jumlah.
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: tambahJumlah,
        ),
      ],
    );
  }
}