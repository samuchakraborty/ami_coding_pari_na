import 'package:ami_coding_pari_na/services/network_utils.dart';
import 'package:ami_coding_pari_na/widgets/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Future<List<DekhaoChobiModel>> fetchPhotos(http.Client client) async {
//   final response = await client
//       .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
//   return compute(parsePhotos, response.body);
// }
//
// List<DekhaoChobiModel> parsePhotos(String responseBody) {
//   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
//
//   return parsed
//       .map<DekhaoChobiModel>((json) => DekhaoChobiModel.fromJson(json))
//       .toList();
// }

class DekhaoChobi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Dekhao Chobi'),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: FutureBuilder(
            future: NetWork().getChobi(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CupertinoActivityIndicator(
                    radius: 30,
                  ),
                );
              } else {
                return GridView.builder(
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                            crossAxisCount: 4,
                            crossAxisSpacing: 2,
                            height: 200,
                            mainAxisSpacing: 2),
                    itemCount: 100,
                    itemBuilder: (ctx, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ConstrainedBox(
                          constraints:  BoxConstraints(minHeight: 200 ),

                          child: Container(
                            //height: 200,
                            // margin: EdgeInsets.only(left: 2, right: 2),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Text("Image ${index+1}"),
                                SizedBox(height: 10,),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 2, right: 2),
                                  //  padding: EdgeInsets.all(10),
                                    child: Image.network(
                                      snapshot.data[index]['url'],

                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),

                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            },
          ),
        ),

        // body: FutureBuilder<List<DekhaoChobiModel>>(
        //   future: fetchPhotos(http.Client()),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) print(snapshot.error);
        //
        //     return snapshot.hasData
        //         ? GridView.builder(
        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 3,
        //       ),
        //       itemCount: 21,
        //       itemBuilder: (context, index) {
        //         return Image.network(snapshot.data![index].thumbnailUrl);
        //       },
        //     )
        //         : Center(child: CircularProgressIndicator());
        //   },
        // ),
      ),
    );
  }
}
