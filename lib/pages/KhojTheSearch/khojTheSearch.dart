import 'package:ami_coding_pari_na/network_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KhojTheSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      body: FutureBuilder(
        future: NetWork().getChobi(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return CupertinoActivityIndicator();
          } else {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 100,
                itemBuilder: (ctx, index) {
                  return Image.network(snapshot.data[index]['thumbnailUrl']);
                });
          }
        },
      ),
    );
  }
}
