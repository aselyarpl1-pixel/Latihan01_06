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

class Barang {
  String nama;
  int harga;
  int stok;
  String kategori;

  // Konstruktor
  Barang(this.nama, this.harga, this.stok, this.kategori);

  // Method
  void tampilkan() {
    print("===== KARTU BARANG =====");
    print("Nama      : $nama");
    print("Harga     : Rp$harga");
    print("Stok      : $stok");
    print("Kategori  : $kategori");
    print("========================");
  }
}

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

    List<Barang> daftarBarang = [
      Barang("Buku Tulis", 5000, 40, "ATK"),
      Barang("Pulpen", 3000, 25, "ATK"),
      Barang("Roti", 7000, 15, "Makanan"),
    ];

    // Memanggil method
    for (var barang in daftarBarang) {
      barang.tampilkan();
    }

    bool anggota = true;
    bool tersedia = daftarBarang[0].stok > 0;

    String rak = "Rak 1";

    int hargaAnggota = daftarBarang[0].harga;
    int hargaUmum = 6000;
    int jumlahStok = daftarBarang[0].stok;
    int jumlahBeli = 120;

    String namaBarang = daftarBarang[0].nama;

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
                  "Kategori : ${daftarBarang[0].kategori}",
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

                /*Menggunakan List<Barang> lebih baik karena 
                semua data barang tersimpan dalam satu koleksi dan 
                dapat ditampilkan menggunakan perulangan.
                Jika jumlah barang bertambah atau berkurang, 
                cukup mengubah isi list tanpa perlu menambah atau 
                menghapus banyak baris kode seperti pada Sprint 3.*/

                Column(
                  children: daftarBarang.map((barang) {
                    return ListTile(
                      leading: const Icon(Icons.shopping_bag),
                      title: Text(barang.nama),
                      subtitle: Text(
                        "Stok: ${barang.stok} | ${barang.kategori}",
                      ),
                      trailing: Text(rupiah(barang.harga)),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
Barang dimodelkan sebagai objek agar program lebih terstruktur,
mudah dikembangkan, dan mengurangi pengulangan kode. Jika ada
perubahan pada data atau fitur barang, cukup mengubah kelas
Barang sehingga semua objek ikut menggunakan perubahan tersebut.
*/