import 'package:flutter/material.dart';

// KeranjangItem menggunakan StatefulWidget
// karena jumlah barang bisa berubah.
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

class _KeranjangItemState extends State<KeranjangItem> {
  late int jumlah;

  @override
  void initState() {
    super.initState();

    // Jika stok tersedia, jumlah awal = 1.
    // Jika stok 0, jumlah awal = 0.
    jumlah = widget.stok > 0 ? 1 : 0;
  }

  // Mengurangi jumlah
  void kurangiJumlah() {
    if (jumlah > 0) {
      setState(() {
        jumlah--;
      });
    }
  }

  // Menambah jumlah
  void tambahJumlah() {
    if (jumlah < widget.stok) {
      setState(() {
        jumlah++;
      });
    } else {
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
    // Menghitung total harga
    final int totalHarga = widget.harga * jumlah;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol -
        IconButton(
          onPressed: jumlah > 0 ? kurangiJumlah : null,
          icon: const Icon(Icons.remove),
          tooltip: 'Kurangi',
        ),

        // Jumlah dan total
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
                color: Colors.black54,
              ),
            ),
          ],
        ),

        // Tombol +
        IconButton(
          onPressed: jumlah < widget.stok
              ? tambahJumlah
              : null,
          icon: const Icon(Icons.add),
          tooltip: 'Tambah',
        ),
      ],
    );
  }
}