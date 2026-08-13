// ignore_for_file: use_super_parameters, avoid_print, dead_code

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
double hitungHarga(
  bool anggota,
  double hAnggota,
  double hUmum,
) {
  if (anggota) {
    return hAnggota;
  } else {
    return hUmum;
  }
}

// Memindahkan keputusan ke fungsi mengurangi risiko salah karena
// logika penentuan harga hanya ditulis di satu tempat.

// =======================
// HOTS-2
// =======================

double bayarAkhir(
  int jumlah,
  double harga,
  double persenPotongan,
) {
  double total = hitungTotal(jumlah, harga);
  return hitungHargaAkhir(total, persenPotongan);
}

// Menyusun fungsi dari fungsi lain membuat program lebih rapi,
// mengurangi pengulangan kode, dan mudah dirawat.

// =======================
// CLASS BARANG
// =======================

class Barang {
  String nama;
  int harga;

  // Stok dibuat private
  int _stok;

  String kategori;

  // Konstruktor
  Barang(
    this.nama,
    this.harga,
    this._stok,
    this.kategori,
  );

  // =======================
  // GETTER STOK
  // =======================

  // Getter digunakan untuk membaca stok
  int get stok {
    return _stok;
  }

  // =======================
  // METHOD JUAL
  // =======================

  // Method jual digunakan untuk mengurangi stok.
  void jual(int n) {
    if (n > 0 && n <= _stok) {
      _stok -= n;

      print("Penjualan berhasil.");
      print("Jumlah terjual : $n");
      print("Sisa stok      : $_stok");
    } else {
      print("Penjualan gagal.");
      print("Stok tidak mencukupi.");
    }
  }

  // =======================
  // METHOD TAMPILKAN
  // =======================

  void tampilkan() {
    print("===== KARTU BARANG =====");
    print("Nama      : $nama");
    print("Harga     : Rp$harga");
    print("Stok      : $_stok");
    print("Kategori  : $kategori");
    print("========================");
  }
}

// =======================
// CLASS TURUNAN BARANG PROMO
// =======================

class BarangPromo extends Barang {
  double diskon;

  // Konstruktor BarangPromo
  BarangPromo(
    String nama,
    int harga,
    int stok,
    String kategori,
    this.diskon,
  ) : super(
          nama,
          harga,
          stok,
          kategori,
        );

  // Method khusus BarangPromo
  double hargaPromo() {
    return harga - (harga * diskon / 100);
  }
}

// =======================
// FUNGSI PROSES BELI
// =======================

void prosesBeli(String inputJumlah) {
  try {
    // Mengubah input menjadi angka
    int jumlah = int.parse(inputJumlah);

    // Membuat objek barang
    Barang barang = Barang(
      "Buku Tulis",
      5000,
      40,
      "ATK",
    );

    print("===== PROSES BELI =====");
    print("Input jumlah : $inputJumlah");

    // Memproses penjualan
    barang.jual(jumlah);
  } catch (e) {
    // Jika input bukan angka
    print("Input tidak valid.");
    print("Silakan masukkan jumlah dalam bentuk angka.");
  } finally {
    // Selalu dijalankan
    print("Transaksi dicatat di log.");
    print("======================");
  }
}

// =======================
// MAIN
// =======================

void main() {
  // =======================
  // UJI ENKAPSULASI
  // =======================

  Barang barangUji = Barang(
    "Buku Tulis",
    5000,
    40,
    "ATK",
  );

  print("===== SEBELUM PENJUALAN =====");
  barangUji.tampilkan();

  // Menjual 10 barang
  barangUji.jual(10);

  print("");
  print("===== SETELAH PENJUALAN =====");
  print("Stok sekarang : ${barangUji.stok}");

  // =======================
  // UJI BARANG PROMO
  // =======================

  BarangPromo barangPromo = BarangPromo(
    "Buku Tulis Promo",
    5000,
    40,
    "ATK",
    10,
  );

  double hargaPromo = barangPromo.hargaPromo();

  print("");
  print("===== BARANG PROMO =====");
  print("Nama        : ${barangPromo.nama}");
  print("Harga       : Rp${barangPromo.harga}");
  print("Stok        : ${barangPromo.stok}");
  print("Kategori    : ${barangPromo.kategori}");
  print("Diskon      : ${barangPromo.diskon}%");
  print("Harga Promo : Rp${hargaPromo.toInt()}");
  print("========================");

  // =======================
  // UJI VALIDASI INPUT
  // =======================

  print("");
  print("===== UJI VALIDASI INPUT =====");

  // Input benar
  prosesBeli("2");

  print("");

  // Input salah
  prosesBeli("dua");

  // Membuktikan program tetap berjalan
  // setelah menerima input yang salah
  print("Setelah input salah, program masih berjalan.");
  print("===== PROGRAM SELESAI =====");

  runApp(const MyApp());
}

// =======================
// MY APP
// =======================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Koperasi Sekolah',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
      ),
      home: const HomePage(),
    );
  }
}

// =======================
// HOME PAGE
// =======================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Fungsi format rupiah
  String rupiah(int angka) {
    return "Rp${angka.toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => '.',
        )}";
  }

  @override
  Widget build(BuildContext context) {
    // =======================
    // DAFTAR BARANG
    // =======================

    List<Barang> daftarBarang = [
      Barang(
        "Buku Tulis",
        5000,
        40,
        "ATK",
      ),
      Barang(
        "Pulpen",
        3000,
        25,
        "ATK",
      ),
      Barang(
        "Roti",
        7000,
        15,
        "Makanan",
      ),
    ];

    // =======================
    // OBJEK BARANG PROMO
    // =======================

    BarangPromo barangPromo = BarangPromo(
      "Buku Tulis Promo",
      5000,
      40,
      "ATK",
      10,
    );

    double hargaPromo = barangPromo.hargaPromo();

    // =======================
    // DATA TRANSAKSI
    // =======================

    bool anggota = true;

    bool tersedia = daftarBarang[0].stok > 0;

    String rak = "Rak 1";

    int hargaAnggota = daftarBarang[0].harga;

    int hargaUmum = 6000;

    int jumlahStok = daftarBarang[0].stok;

    int jumlahBeli = 10;

    String namaBarang = daftarBarang[0].nama;

    // =======================
    // MENENTUKAN HARGA
    // =======================

    double harga = hitungHarga(
      anggota,
      hargaAnggota.toDouble(),
      hargaUmum.toDouble(),
    );

    // =======================
    // TOTAL BELANJA
    // =======================

    double total = hitungTotal(
      jumlahBeli,
      harga,
    );

    // =======================
    // MENENTUKAN POTONGAN
    // =======================

    double persenPotongan = 0;

    if (anggota && total > 500000) {
      persenPotongan = 15;
    } else if (total > 200000) {
      persenPotongan = 10;
    } else if (total > 100000) {
      persenPotongan = 5;
    }

    // =======================
    // HARGA AKHIR
    // =======================

    double hargaAkhir = bayarAkhir(
      jumlahBeli,
      harga,
      persenPotongan,
    );

    double diskonTransaksi = total - hargaAkhir;

    // =======================
    // TAMPILAN
    // =======================

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Koperasi Sekolah",
        ),
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
                // =======================
                // JUDUL
                // =======================

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

                // =======================
                // DATA BARANG
                // =======================

                Text(
                  "Nama Barang : $namaBarang",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Harga Anggota : ${rupiah(hargaAnggota)}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Harga Umum : ${rupiah(hargaUmum)}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Jumlah Stok : $jumlahStok",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Jumlah Beli : $jumlahBeli",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Status Anggota : ${anggota ? "Ya" : "Tidak"}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Barang Tersedia : ${tersedia ? "Ya" : "Tidak"}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Kategori : ${daftarBarang[0].kategori}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Lokasi Rak : $rak",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                const Divider(
                  height: 35,
                ),

                // =======================
                // TRANSAKSI
                // =======================

                Text(
                  "Total Belanja : ${rupiah(total.toInt())}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "Potongan : $persenPotongan%",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Diskon : ${rupiah(diskonTransaksi.toInt())}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Harga Akhir : ${rupiah(hargaAkhir.toInt())}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Divider(
                  height: 35,
                ),

                // =======================
                // BARANG PROMO
                // =======================

                const Text(
                  "BARANG PROMO",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Nama Barang Promo : ${barangPromo.nama}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Harga Awal : ${rupiah(barangPromo.harga)}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Stok : ${barangPromo.stok}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Kategori : ${barangPromo.kategori}",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Diskon : ${barangPromo.diskon}%",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Harga Promo : ${rupiah(hargaPromo.toInt())}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                // =======================
                // DAFTAR BARANG
                // =======================

                const Text(
                  "Daftar Barang",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                ListView(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  children: daftarBarang.map((barang) {
                    return ListTile(
                      leading: const Icon(
                        Icons.shopping_bag,
                      ),
                      title: Text(
                        barang.nama,
                      ),
                      subtitle: Text(
                        "Stok: ${barang.stok} | ${barang.kategori}",
                      ),
                      trailing: Text(
                        rupiah(barang.harga),
                      ),
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
Melindungi _stok penting agar stok barang tidak bisa diubah
sembarangan dari luar class.

Dengan menggunakan _stok sebagai private, perubahan stok
hanya dilakukan melalui method jual() yang sudah memiliki
aturan pengecekan.

Hal ini menjaga data stok tetap benar dan mencegah jumlah
stok menjadi tidak sesuai dengan transaksi koperasi.
*/