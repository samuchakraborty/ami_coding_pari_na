
import 'dart:convert';

import 'package:ami_coding_pari_na/models/DekhaoChobi.dart';
import 'package:ami_coding_pari_na/network_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<List<DekhaoChobiModel>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  return compute(parsePhotos, response.body);
}

List<DekhaoChobiModel> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<DekhaoChobiModel>((json) => DekhaoChobiModel.fromJson(json)).toList();
}




class DekhaoChobi extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dekhao Chobi'),
      ),
      body: FutureBuilder<List<DekhaoChobiModel>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 21,
            itemBuilder: (context, index) {
              return Image.network(snapshot.data![index].thumbnailUrl);
            },
          )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
