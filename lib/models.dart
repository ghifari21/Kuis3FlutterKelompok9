class UmkmData {
  String id;
  String nama;
  String jenis;

  UmkmData({required this.id, required this.nama, required this.jenis});
}

class UmkmModel {
  List<UmkmData> listUmkm = <UmkmData>[];

  UmkmModel({required this.listUmkm});
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