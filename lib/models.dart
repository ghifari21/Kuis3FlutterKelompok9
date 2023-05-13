class Umkm {
  String id;
  String nama;
  String jenis;

  Umkm({required this.id, required this.nama, required this.jenis});
}

class DetailUmkm {
  String id;
  String nama;
  String jenis;
  String omzetPerBulan;
  String lamaUsaha;
  String memberSejak;
  String jumlahPinjamanSukses;

  DetailUmkm(
      {required this.id,
        required this.nama,
        required this.jenis,
        required this.omzetPerBulan,
        required this.lamaUsaha,
        required this.memberSejak,
        required this.jumlahPinjamanSukses}
      );
}

class JenisPeminjaman {
  String id;
  String nama;

  JenisPeminjaman({required this.id, required this.nama});
}

class DetailJenisPeminjaman {
  String id;
  String nama;
  String bunga;
  String isSyariah;

  DetailJenisPeminjaman({required this.id, required this.nama, required this.bunga, required this.isSyariah});
}