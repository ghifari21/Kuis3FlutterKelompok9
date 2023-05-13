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
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          BlocBuilder<DetailCubit, DetailUmkm>(
            builder: (context, dataDetail) {
              context.read<DetailCubit>().fetchData(paramId);
              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                    Text("Nama: ${dataDetail.nama}"),
                    Text("Detil: ${dataDetail.jenis}"),
                    Text("Member Sejak: ${dataDetail.memberSejak}"),
                    Text("Omzet perbulan: ${dataDetail.omzetPerBulan}"),
                    Text("lama usaha: ${dataDetail.lamaUsaha}"),
                    Text(
                        "Jumlah pinjaman sukses: ${dataDetail.jumlahPinjamanSukses}")
                  ]));
            },
          ),
        ]),
      ),
    ));
  }
}
