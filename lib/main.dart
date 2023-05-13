import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
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
    return MaterialApp(
      title: "My App",
      home: BlocProvider(
        create: (_) => UmkmCubit(),
        child: const HalamanUtama(),
      ),
    );
  }
}

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('My App'),
          ),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text("2000952, Ghifari Octaverin; 2003623, Alief Muhammad Abdillah; Saya berjanji tidak akan berbuat curang data atau membantu orang lain berbuat curang"),
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
                    const SizedBox(height: 16.0,),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: umkm.listUmkm.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              // Todo
                            },
                            leading: Image.network(
                                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                            trailing: IconButton(
                              onPressed: () {

                              },
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
        )
      ),
    );
  }
}
