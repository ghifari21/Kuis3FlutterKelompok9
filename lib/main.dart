import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:kuis3flutterkelompok9/detail.dart';
import 'models.dart';

void main() {
  runApp(const MyApp());
}

class UmkmCubit extends Cubit<UmkmModel> {
  String url = "http://178.128.17.76:8000/daftar_umkm";

  UmkmCubit() : super(UmkmModel(listUmkm: []));

  void setFromJson(Map<String, dynamic> json) {
    List<UmkmData> listData = <UmkmData>[];
    var data = json['data'];
    for (var val in data) {
      listData
          .add(UmkmData(id: val['id'], nama: val['nama'], jenis: val['jenis']));
    }
    emit(UmkmModel(listUmkm: listData));
  }

  void fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setFromJson(jsonDecode(response.body));
    } else {
      throw Exception("gagal load");
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UmkmCubit(),
        ),
        BlocProvider(
          create: (context) => DetailCubit(),
        )
      ],
      child: const MaterialApp(
        title: "My App",
        home: HalamanUtama(),
      ),
    );
  }
}

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('My App'),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
                "2000952, Ghifari Octaverin; 2003623, Alief Muhammad Abdillah; Saya berjanji tidak akan berbuat curang data atau membantu orang lain berbuat curang"),
          ),
          BlocBuilder<UmkmCubit, UmkmModel>(
            builder: (context, umkm) {
              return Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      context.read<UmkmCubit>().fetchData();
                    },
                    child: const Text("Reload Daftar Umkm"),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: umkm.listUmkm.length,
                    itemBuilder: (context, index) {
                      var imageUrl = "";
                      if (umkm.listUmkm[index].jenis == "makanan/minuman") {
                        imageUrl =
                        'https://upload.wikimedia.org/wikipedia/commons/c/ca/Warung_Tegal_di_Kota_Tegal.JPG';
                      } else if (umkm.listUmkm[index].jenis == "sembako") {
                        imageUrl =
                        'https://radarpekalongan.id/wp-content/uploads/2023/01/toko-sembako-1536x1152.jpg';
                      } else if (umkm.listUmkm[index].jenis == "jasa") {
                        imageUrl =
                        'https://cdn.popmama.com/content-images/post/20230304/tugas-61-aktivitas-ekonomi-bidang-jasajpg-71c31296a7dbe822f05bc24fa14f52ed.jpg';
                      } else {
                        imageUrl =
                        'https://1.bp.blogspot.com/-qbxGYU9b6GE/YVKvjTJ-czI/AAAAAAAAMPk/LNsEZaK3XHEPQ2rEZ2OeqFrWRC_MVwUgACLcBGAsYHQ/w400-h266/Desain-Interior-Toko-Baju.jpg';
                      }
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return DetailInterface(paramId: umkm.listUmkm[index].id);
                            }));
                          },
                          leading: Image.network(imageUrl, fit: BoxFit.contain, width: 50,),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert),
                          ),
                          title: Text(umkm.listUmkm[index].nama),
                          subtitle: Text(umkm.listUmkm[index].jenis),
                          tileColor: Colors.white70,
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
