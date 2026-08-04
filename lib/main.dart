import 'package:flutter/material.dart';


double hitungTotal(int jumlah, double harga) {
  return jumlah * harga;
}

double hitungHargaAkhir(double total, double persenPotongan) {
  return total - (total * persenPotongan / 100);
}

void main() {
  // Data Barang // Pemilihan tipe data yang tepat membuat data lebih mudah diolah dan mengurangi kesalahan saat kasir menghitung transaksi.
  String namaBarang = "Buku Tulis"; // Saya menggunakan tipe data String untuk nama barang,
  int hargaAnggota = 5000; // int untuk harga dan stok karena berupa angka,
  int hargaUmum = 6000;
  int jumlahStok = 40;
  String kategori = "atk";
  String rak = "Rak 1";
  
  // Menentukan apakah barang tersedia
  bool tersedia = jumlahStok > 0; // serta bool untuk menunjukkan apakah barang tersedia atau tidak.

  // jumlah yang dibeli
  int jumlahBeli = 120;

  // Status pembeli
  bool anggota = true;

  // Menentukan harga sesuai jenis pembeli
  int harga;

  if (anggota) {
    harga = hargaAnggota;
  } else {
    harga = hargaUmum;
  }

  // Perhitungan
  int totalAnggota = jumlahBeli * hargaAnggota;
  int totalUmum = jumlahBeli * hargaUmum;
  int selisih = totalUmum - totalAnggota;

  // Hitung total belanja menggunakan fungsi
  double total = hitungTotal(jumlahBeli, harga.toDouble());

  double diskon = 0;
  double hargaAkhir = 0;
  double persenPotongan = 0;

  if (anggota && total > 500000) {
    persenPotongan = 15;
  } else if (total > 200000) {
    persenPotongan = 10;
  } else if (total > 100000) {
    persenPotongan = 5;
  }

  hargaAkhir = hitungHargaAkhir(total, persenPotongan);
  diskon = total - hargaAkhir;

  //pemisah ribuan
  String rupiah(int angka) {
  return "Rp${angka.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (match) => '.',
  )}";
}

//switch case untuk kategori barang
// Switch-case lebih rapi digunakan karena hanya memeriksa satu variabel,
// yaitu kategori, dengan beberapa kemungkinan nilai.
// Jika menggunakan banyak if-else, kode akan lebih panjang dan lebih sulit dibaca.

switch (kategori) {
  case "atk":
    rak = "Rak 1";
    break;
  case "makanan":
    rak = "Rak 2";
    break;
  case "minuman":
    rak = "Rak 3";
    break;
  default:
    rak = "Rak Lain";
}

  // ======================
  // Daftar Barang Bernomor
  // ======================

  List<String> daftarBarang = [
    "Buku Tulis",
    "Pulpen",
    "Penghapus",
    "Roti"
  ];

  List<int> daftarHarga = [
    3000,
    2500,
    1500,
    5000
  ];

  print("=== DAFTAR BARANG ===");

  for (int i = 0; i < daftarBarang.length; i++) {
    print("${i + 1}. ${daftarBarang[i]} - ${rupiah(daftarHarga[i])}");
  }

  //menampilkan hasil
  print("=== Kartu Data Barang ===");
  print("Nama Barang: $namaBarang");
  print("Harga Anggota: ${rupiah(hargaAnggota)}");
  print("Harga Umum: ${rupiah(hargaUmum)}");
  print("Jumlah Stok: $jumlahStok");
  print("Tersedia: $tersedia");
  print("Total (anggota): $jumlahBeli pcs : ${rupiah(totalAnggota)}");
  print("Selisih vs umum: ${rupiah(selisih)}");
  print("Status Anggota: $anggota");
  print("Harga yang digunakan: ${rupiah(harga)}");
  print("Total Belanja : ${rupiah(total.toInt())}");
  print("Persen Potongan : $persenPotongan%");
  print("Diskon : Rp${diskon.toInt()}");
  print("Harga Akhir : Rp${hargaAkhir.toInt()}");
  print("Kategori : $kategori");
  print("Lokasi Rak : $rak");

  if (tersedia) {
    print("Status : Barang tersedia");
  } else {
    print("Status : Barang tidak tersedia");
  }


  // ======================
  // Perulangan While
  // ======================

  // Bahaya jika kondisi while keliru:
  // Perulangan bisa terus berjalan atau menjual barang melebihi stok,
  // sehingga stok menjadi negatif dan data penjualan tidak valid.

  // Untuk mencegahnya, kondisi while dibuat "stok > 0".
  // Dengan begitu penjualan akan berhenti tepat saat stok habis (0),
  // sehingga koperasi tidak dapat menjual barang melebihi stok.

  int stok = 3;

  print("---- Penjualan Buku Tulis ----");

  while (stok > 0) {
    stok--;
    print("Terjual 1, sisa stok: $stok");
  }

  // ======================
  // Total Nilai Seluruh Stok
  // ======================

  List<int> daftarStok = [
    2, // Buku Tulis
    3, // Pulpen
    4, // Penghapus
    5  // Roti
  ];

  int totalNilaiStok = 0;

  for (int i = 0; i < daftarBarang.length; i++) {
    totalNilaiStok += daftarHarga[i] * daftarStok[i];
  }

  print("=== TOTAL NILAI SELURUH STOK ===");
  print("Total nilai seluruh stok: ${rupiah(totalNilaiStok)}");

  // ======================
  // Barang dengan Stok Menipis
  // ======================

  print("=== BARANG DENGAN STOK MENIPIS ===");

  for (int i = 0; i < daftarBarang.length; i++) {
    if (daftarStok[i] < 5) {
      print("${daftarBarang[i]} - Stok: ${daftarStok[i]}");
    }
  }

  print(
      "Laporan ini membantu koperasi mengetahui barang yang hampir habis sehingga dapat segera melakukan restok.");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      home: const MyHomePage(title: 'Latihan Flutter Aselya'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Selamat Datang di Aplikasi Flutter Aselya!'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
