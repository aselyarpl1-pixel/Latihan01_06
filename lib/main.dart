import 'package:flutter/material.dart';

// =======================
// Fungsi Perhitungan
// =======================

double hitungTotal(int jumlah, double harga) {
  return jumlah * harga;
}

double hitungHargaAkhir(double total, double persenPotongan) {
  return total - (total * persenPotongan / 100);
}

// HOTS-1
double hitungHarga(bool anggota, double hAnggota, double hUmum) {
  if (anggota) {
    return hAnggota;
  } else {
    return hUmum;
  }
}

/*
Memindahkan keputusan ke fungsi mengurangi risiko salah karena
logika penentuan harga hanya ditulis di satu tempat.
Jika aturan harga berubah, cukup mengubah fungsi ini.
*/

// HOTS-2
double bayarAkhir(
    int jumlah,
    double harga,
    double persenPotongan,
) {
  double total = hitungTotal(jumlah, harga);
  return hitungHargaAkhir(total, persenPotongan);
}

/*
Menyusun fungsi dari fungsi lain membuat program lebih rapi,
mengurangi pengulangan kode, dan mudah dirawat.
*/

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Koperasi Sekolah',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String rupiah(int angka) {
    return "Rp${angka.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    )}";
  }

  @override
  Widget build(BuildContext context) {

    String namaBarang = "Buku Tulis";
    int hargaAnggota = 5000;
    int hargaUmum = 6000;
    int jumlahStok = 40;
    int jumlahBeli = 120;

    bool anggota = true;
    bool tersedia = jumlahStok > 0;

    String kategori = "ATK";
    String rak = "Rak 1";

    double harga = hitungHarga(
      anggota,
      hargaAnggota.toDouble(),
      hargaUmum.toDouble(),
    );

    double total = hitungTotal(jumlahBeli, harga);

    double persenPotongan = 0;

    if (anggota && total > 500000) {
      persenPotongan = 15;
    } else if (total > 200000) {
      persenPotongan = 10;
    } else if (total > 100000) {
      persenPotongan = 5;
    }

    double hargaAkhir =
        bayarAkhir(jumlahBeli, harga, persenPotongan);

    double diskon = total - hargaAkhir;
        return Scaffold(
      appBar: AppBar(
        title: const Text("Koperasi Sekolah"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Center(
                  child: Text(
                    "LAPORAN TRANSAKSI KOPERASI",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Nama Barang : $namaBarang",
                  style: const TextStyle(fontSize: 18),
                ),

                Text(
                  "Harga Anggota : ${rupiah(hargaAnggota)}",
                  style: const TextStyle(fontSize: 18),
                ),

                Text(
                  "Harga Umum : ${rupiah(hargaUmum)}",
                  style: const TextStyle(fontSize: 18),
                ),

                Text(
                  "Jumlah Stok : $jumlahStok",
                  style: const TextStyle(fontSize: 18),
                ),

                Text(
                  "Jumlah Beli : $jumlahBeli",
                  style: const TextStyle(fontSize: 18),
                ),

                Text(
                  // ignore: dead_code
                  "Status Anggota : ${anggota ? "Ya" : "Tidak"}",
                  style: const TextStyle(fontSize: 18),
                ),

                Text(
                  "Barang Tersedia : ${tersedia ? "Ya" : "Tidak"}",
                  style: const TextStyle(fontSize: 18),
                ),

                Text(
                  "Kategori : $kategori",
                  style: const TextStyle(fontSize: 18),
                ),

                Text(
                  "Lokasi Rak : $rak",
                  style: const TextStyle(fontSize: 18),
                ),

                const Divider(height: 35),

                Text(
                  "Total Belanja : ${rupiah(total.toInt())}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "Potongan : $persenPotongan %",
                  style: const TextStyle(fontSize: 18),
                ),

                Text(
                  "Diskon : ${rupiah(diskon.toInt())}",
                  style: const TextStyle(fontSize: 18),
                ),

                Text(
                  "Harga Akhir : ${rupiah(hargaAkhir.toInt())}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Daftar Barang",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text("Buku Tulis"),
                  trailing: Text(rupiah(3000)),
                ),

                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text("Pulpen"),
                  trailing: Text(rupiah(2500)),
                ),

                ListTile(
                  leading: const Icon(Icons.cleaning_services),
                  title: const Text("Penghapus"),
                  trailing: Text(rupiah(1500)),
                ),

                ListTile(
                  leading: const Icon(Icons.fastfood),
                  title: const Text("Roti"),
                  trailing: Text(rupiah(5000)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}