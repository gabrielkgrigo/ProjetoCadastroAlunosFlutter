import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'ctcdata.dart';

Future<List<ctcData>> fetchData() async {
  var response = await http.get(
      Uri.parse("https://www.slmm.com.br/CTC/getLista.php"),
      headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
    // print(response.body);
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new ctcData.fromJson(data)).toList();
  } else {
    throw Exception('Erro inesperado....');
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ctcData>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("listagem"),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<List<ctcData>>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ctcData> data = snapshot.data!;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: Container(
                          padding: EdgeInsets.all(10),
                          height: 75,
                          color: Colors.white,
                          child: Center(
                            child: Text(data[index].id.toString() +
                                " : " +
                                data[index].nome),
                          ),
                        ));
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // by default
                return CircularProgressIndicator();
              }),
        ));
  }
}
