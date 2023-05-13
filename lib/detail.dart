import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;
import 'models.dart';

class DetailCubit extends Cubit<DetailUmkm> {
  String url = "http://178.128.17.76:8000/detil_umkm";
  DetailCubit()
      : super(DetailUmkm(
            id: "",
            nama: "",
            jenis: "",
            omzetPerBulan: "",
            lamaUsaha: "",
            memberSejak: "",
            jumlahPinjamanSukses: ""));

  void setFromJson(Map<String, dynamic> json) {
    emit(DetailUmkm(
        id: json['id'],
        nama: json['nama'],
        jenis: json['jenis'],
        omzetPerBulan: json['omzet_bulan'],
        lamaUsaha: json['lama_usaha'],
        memberSejak: json['member_sejak'],
        jumlahPinjamanSukses: json['jumlah_pinjaman_sukses']));
  }

  void fetchData(String id) async {
    final response = await http.get(Uri.parse("$url/$id"));
    if (response.statusCode == 200) {
      setFromJson(jsonDecode(response.body));
    } else {
      throw Exception("Gagal Fetch API");
    }
  }
}

void main() {
  runApp(const DetailPage());
}

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => DetailCubit(),
        child: const DetailInterface(paramId: '1'),
      ),
    );
  }
}

class DetailInterface extends StatelessWidget {
  final String paramId;
  const DetailInterface({Key? key, required this.paramId}) : super(key: key);

  @override
  Widget build(Object context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Detail UMKM'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          BlocBuilder<DetailCubit, DetailUmkm>(
            builder: (context, dataDetail) {
              context.read<DetailCubit>().fetchData(paramId);
              /* var imageUrl = "";
              if (dataDetail.jenis == "makanan/minuman") {
                imageUrl = "https://img.okezone.com/content/2017/09/11/337/1773600/okezone-files-wajib-tahu-ini-ciri-ciri-warteg-asli-tegal-atau-bukan-Il9HFAsOJj.jpg";
              }else if (dataDetail.jenis == "sembako"){
                imageUrl = "https://radarpekalongan.id/wp-content/uploads/2023/01/toko-sembako-1536x1152.jpg";
              }else if (dataDetail.jenis == "jasa") {
                imageUrl = "https://www.maxmanroe.com/vid/wp-content/uploads/2019/11/Pengertian-Jasa-Adalah.jpg";
              }else {
                imageUrl = "https://cdn-2.tstatic.net/jakarta/foto/bank/images/metro-atom-pasar-baru-2.jpg";
              } */
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* Image.network(
                      "https://www.maxmanroe.com/vid/wp-content/uploads/2019/11/Pengertian-Jasa-Adalah.jpg",
                      height: 500,
                      fit: BoxFit.cover,
                    ), */
                    Text(
                      dataDetail.nama,
                      style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Jenis UMKM: ${dataDetail.jenis}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Member sejak: ${dataDetail.memberSejak}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Omzet perbulan: ${dataDetail.omzetPerBulan}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Lama usaha: ${dataDetail.lamaUsaha}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Jumlah pinjaman sukses: ${dataDetail.jumlahPinjamanSukses}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            },
          ),
        ]),
      ),
    ));
  }
}
