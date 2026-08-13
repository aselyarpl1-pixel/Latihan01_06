// ignore_for_file: dead_code, use_super_parameters, avoid_print

import 'package:flutter/material.dart';

// ======================================================
// FUNGSI PERHITUNGAN
// ======================================================

double hitungTotal(int jumlah, double harga) {
  return jumlah * harga;
}

double hitungHargaAkhir(
  double total,
  double persenPotongan,
) {
  return total - (total * persenPotongan / 100);
}

// ======================================================
// MENENTUKAN HARGA
// ======================================================

double hitungHarga(
  bool anggota,
  double hargaAnggota,
  double hargaUmum,
) {
  if (anggota) {
    return hargaAnggota;
  }

  return hargaUmum;
}

// ======================================================
// HOTS-2
// ======================================================

double bayarAkhir(
  int jumlah,
  double harga,
  double persenPotongan,
) {
  double total = hitungTotal(jumlah, harga);

  return hitungHargaAkhir(
    total,
    persenPotongan,
  );
}

// ======================================================
// ASYNC - MEMUAT LAPORAN
// ======================================================

Future<void> muatLaporan() async {
  print("=================================");
  print("        BRANTAS MART");
  print("=================================");
  print("Menyiapkan laporan...");

  await Future.delayed(
    const Duration(seconds: 1),
  );

  print("Laporan siap!");
  print("");
}

// ======================================================
// CLASS BARANG
// ======================================================

class Barang {
  String nama;
  int harga;
  int _stok;
  String kategori;

  Barang(
    this.nama,
    this.harga,
    this._stok,
    this.kategori,
  );

  // ====================================================
  // GETTER STOK
  // ====================================================

  int get stok {
    return _stok;
  }

  // ====================================================
  // METHOD JUAL
  // ====================================================

  bool jual(int jumlah) {
    if (jumlah > 0 && jumlah <= _stok) {
      _stok -= jumlah;

      return true;
    }

    return false;
  }

  // ====================================================
  // METHOD TAMPILKAN
  // ====================================================

  void tampilkan() {
    print("Nama      : $nama");
    print("Harga     : Rp$harga");
    print("Stok      : $_stok");
    print("Kategori  : $kategori");
  }
}

// ======================================================
// CLASS TURUNAN BARANG PROMO
// ======================================================

class BarangPromo extends Barang {
  double diskon;

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

  double hargaPromo() {
    return harga - (harga * diskon / 100);
  }
}

// ======================================================
// FUNGSI MENAMPILKAN DAFTAR BARANG
// ======================================================

void tampilkanDaftarBarang(
  List<Barang> daftarBarang,
) {
  print("=================================");
  print("         DAFTAR BARANG");
  print("=================================");

  for (Barang barang in daftarBarang) {
    barang.tampilkan();
    print("---------------------------------");
  }
}

// ======================================================
// FUNGSI PROSES 1 TRANSAKSI
// ======================================================

void prosesTransaksi({
  required Barang barang,
  required String inputJumlah,
  required bool anggota,
  required int hargaUmum,
}) {
  print("=================================");
  print("         PROSES TRANSAKSI");
  print("=================================");

  try {
    // -----------------------------------------------
    // VALIDASI INPUT
    // -----------------------------------------------

    int jumlah = int.parse(inputJumlah);

    if (jumlah <= 0) {
      print("Transaksi gagal.");
      print("Jumlah pembelian harus lebih dari 0.");
      return;
    }

    // -----------------------------------------------
    // CEK STOK
    // -----------------------------------------------

    if (jumlah > barang.stok) {
      print("Transaksi gagal.");
      print("Stok ${barang.nama} tidak mencukupi.");
      print("Stok tersedia : ${barang.stok}");
      return;
    }

    // -----------------------------------------------
    // MENENTUKAN HARGA
    // -----------------------------------------------

    double harga = hitungHarga(
      anggota,
      barang.harga.toDouble(),
      hargaUmum.toDouble(),
    );

    // -----------------------------------------------
    // TOTAL BELANJA
    // -----------------------------------------------

    double total = hitungTotal(
      jumlah,
      harga,
    );

    // -----------------------------------------------
    // MENENTUKAN POTONGAN
    // -----------------------------------------------

    double persenPotongan = 0;

    if (anggota && total > 500000) {
      persenPotongan = 15;
    } else if (total > 200000) {
      persenPotongan = 10;
    } else if (total > 100000) {
      persenPotongan = 5;
    }

    // -----------------------------------------------
    // HARGA AKHIR
    // -----------------------------------------------

    double hargaAkhir = bayarAkhir(
      jumlah,
      harga,
      persenPotongan,
    );

    double nilaiPotongan =
        total - hargaAkhir;

    // -----------------------------------------------
    // KURANGI STOK
    // -----------------------------------------------

    bool berhasil = barang.jual(jumlah);

    if (!berhasil) {
      print("Transaksi gagal.");
      print("Stok tidak mencukupi.");
      return;
    }

    // -----------------------------------------------
    // HASIL TRANSAKSI
    // -----------------------------------------------

    print("Nama barang       : ${barang.nama}");
    print("Jumlah beli       : $jumlah");
    print(
      "Status anggota    : ${anggota ? "Ya" : "Tidak"}",
    );
    print("Harga satuan      : Rp${harga.toInt()}");
    print("Total belanja     : Rp${total.toInt()}");
    print("Potongan          : $persenPotongan%");
    print(
      "Nilai potongan    : Rp${nilaiPotongan.toInt()}",
    );
    print(
      "Harga akhir       : Rp${hargaAkhir.toInt()}",
    );
    print("Sisa stok         : ${barang.stok}");
    print("---------------------------------");
    print("TRANSAKSI BERHASIL");
    print("=================================");
  } on FormatException {
    // -----------------------------------------------
    // MENANGANI INPUT BUKAN ANGKA
    // -----------------------------------------------

    print("Input tidak valid.");
    print("Jumlah pembelian harus berupa angka.");
    print("Transaksi dibatalkan.");
    print("Program tetap berjalan.");
    print("=================================");
  } catch (e) {
    // -----------------------------------------------
    // MENANGANI ERROR LAIN
    // -----------------------------------------------

    print("Terjadi kesalahan.");
    print("Transaksi tidak dapat diproses.");
    print("Program tetap berjalan.");
    print("=================================");
  }
}

// ======================================================
// MAIN
// ======================================================

Future<void> main() async {
  // ====================================================
  // 1. MUAT LAPORAN
  // ====================================================

  await muatLaporan();

  // ====================================================
  // 2. DATA BARANG
  // ====================================================

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

  // ====================================================
  // 3. TAMPILKAN BARANG
  // ====================================================

  tampilkanDaftarBarang(
    daftarBarang,
  );

  print("");

  // ====================================================
  // 4. DATA TRANSAKSI
  // ====================================================

  Barang barangDipilih =
      daftarBarang[0];

  bool anggota = true;

  int hargaUmum = 6000;

  // ====================================================
  // 5. PROSES 1 TRANSAKSI
  // ====================================================

  // Input benar
  prosesTransaksi(
    barang: barangDipilih,
    inputJumlah: "10",
    anggota: anggota,
    hargaUmum: hargaUmum,
  );

  // ====================================================
  // 6. BUKTI PROGRAM TETAP BERJALAN
  // ====================================================

  print("");
  print("===== SETELAH TRANSAKSI =====");
  print(
    "Stok ${barangDipilih.nama} sekarang : "
    "${barangDipilih.stok}",
  );

  // ====================================================
  // 7. UJI SALAH INPUT
  // ====================================================

  print("");
  print("===== UJI SALAH INPUT =====");

  prosesTransaksi(
    barang: barangDipilih,
    inputJumlah: "dua",
    anggota: anggota,
    hargaUmum: hargaUmum,
  );

  // ====================================================
  // 8. PROGRAM TETAP BERJALAN
  // ====================================================

  print("");
  print("===== PROGRAM SELESAI =====");
  print("Program berjalan tanpa runtime error.");

  // ====================================================
  // 9. JALANKAN FLUTTER
  // ====================================================

  runApp(const MyApp());
}

// ======================================================
// MY APP
// ======================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Brantas Mart",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// ======================================================
// HOME PAGE
// ======================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // ====================================================
  // FORMAT RUPIAH
  // ====================================================

  String rupiah(int angka) {
    return "Rp${angka.toString().replaceAllMapped(
          RegExp(
            r'\B(?=(\d{3})+(?!\d))',
          ),
          (match) => ".",
        )}";
  }

  @override
  Widget build(BuildContext context) {
    // ==================================================
    // DAFTAR BARANG
    // ==================================================

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

    // ==================================================
    // BARANG PROMO
    // ==================================================

    BarangPromo barangPromo =
        BarangPromo(
      "Buku Tulis Promo",
      5000,
      40,
      "ATK",
      10,
    );

    double hargaPromo =
        barangPromo.hargaPromo();

    // ==================================================
    // DATA TRANSAKSI
    // ==================================================

    bool anggota = true;

    Barang barang =
        daftarBarang[0];

    int hargaAnggota =
        barang.harga;

    int hargaUmum = 6000;

    int jumlahBeli = 10;

    double harga = hitungHarga(
      anggota,
      hargaAnggota.toDouble(),
      hargaUmum.toDouble(),
    );

    double total = hitungTotal(
      jumlahBeli,
      harga,
    );

    // ==================================================
    // POTONGAN
    // ==================================================

    double persenPotongan = 0;

    if (anggota && total > 500000) {
      persenPotongan = 15;
    } else if (total > 200000) {
      persenPotongan = 10;
    } else if (total > 100000) {
      persenPotongan = 5;
    }

    double hargaAkhir = bayarAkhir(
      jumlahBeli,
      harga,
      persenPotongan,
    );

    double nilaiPotongan =
        total - hargaAkhir;

    // ==================================================
    // TAMPILAN
    // ==================================================

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Brantas Mart",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15),
          ),
          child: Padding(
            padding:
                const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // ======================================
                // JUDUL
                // ======================================

                const Center(
                  child: Text(
                    "LAPORAN TRANSAKSI BRANTAS MART",
                    textAlign:
                        TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // ======================================
                // DATA BARANG
                // ======================================

                const Text(
                  "DATA BARANG",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Text(
                  "Nama Barang : ${barang.nama}",
                  style:
                      const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Kategori : ${barang.kategori}",
                  style:
                      const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Harga Anggota : "
                  "${rupiah(hargaAnggota)}",
                  style:
                      const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Harga Umum : "
                  "${rupiah(hargaUmum)}",
                  style:
                      const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Stok : ${barang.stok}",
                  style:
                      const TextStyle(
                    fontSize: 18,
                  ),
                ),

                const Divider(
                  height: 35,
                ),

                // ======================================
                // TRANSAKSI
                // ======================================

                const Text(
                  "TRANSAKSI",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Text(
                  "Jumlah Beli : $jumlahBeli",
                  style:
                      const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Status Anggota : "
                  "${anggota ? "Ya" : "Tidak"}",
                  style:
                      const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Harga Satuan : "
                  "${rupiah(harga.toInt())}",
                  style:
                      const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Total Belanja : "
                  "${rupiah(total.toInt())}",
                  style:
                      const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                Text(
                  "Potongan : "
                  "$persenPotongan%",
                  style:
                      const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Nilai Potongan : "
                  "${rupiah(nilaiPotongan.toInt())}",
                  style:
                      const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Harga Akhir : "
                  "${rupiah(hargaAkhir.toInt())}",
                  style:
                      const TextStyle(
                    fontSize: 20,
                    color:
                        Colors.green,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const Divider(
                  height: 35,
                ),

                // ======================================
                // BARANG PROMO
                // ======================================

                const Text(
                  "BARANG PROMO",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Text(
                  "Nama : "
                  "${barangPromo.nama}",
                  style:
                      const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Harga Awal : "
                  "${rupiah(barangPromo.harga)}",
                  style:
                      const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Stok : "
                  "${barangPromo.stok}",
                  style:
                      const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Kategori : "
                  "${barangPromo.kategori}",
                  style:
                      const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Diskon : "
                  "${barangPromo.diskon}%",
                  style:
                      const TextStyle(
                    fontSize: 18,
                  ),
                ),

                Text(
                  "Harga Promo : "
                  "${rupiah(hargaPromo.toInt())}",
                  style:
                      const TextStyle(
                    fontSize: 20,
                    color:
                        Colors.green,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // ======================================
                // DAFTAR BARANG
                // ======================================

                const Text(
                  "DAFTAR BARANG",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                ListView(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  children:
                      daftarBarang.map(
                    (barang) {
                      return ListTile(
                        leading:
                            const Icon(
                          Icons.shopping_bag,
                        ),
                        title: Text(
                          barang.nama,
                        ),
                        subtitle: Text(
                          "Stok: "
                          "${barang.stok} | "
                          "${barang.kategori}",
                        ),
                        trailing: Text(
                          rupiah(
                            barang.harga,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}