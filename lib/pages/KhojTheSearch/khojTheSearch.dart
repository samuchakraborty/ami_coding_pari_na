import 'package:ami_coding_pari_na/models/StoreData.dart';
import 'package:ami_coding_pari_na/services/DataBaseHelper.dart';
import 'package:ami_coding_pari_na/widgets/CustomButton.dart';
import 'package:ami_coding_pari_na/widgets/CustomTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class KhojTheSearch extends StatefulWidget {
  final userId;

  KhojTheSearch({required this.userId});

  @override
  _KhojTheSearchState createState() => _KhojTheSearchState();
}

class _KhojTheSearchState extends State<KhojTheSearch> {
  final _formKey = GlobalKey<FormState>();
  var inputValues;
  var searchValue;
  var searchError;
  late Future<List<StoreData>?> listOfStoreData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshList();
  }

  refreshList() {
    setState(() {
      listOfStoreData = DBHelper().getAllStoreDataById(id: widget.userId);
    });
  }

  Widget dataTable(List<StoreData> storeData) {
    var kMinWidthOfLargeScreen =MediaQuery.of(context).size.width-10;
    bool isScreenWide = MediaQuery.of(context).size.width >= kMinWidthOfLargeScreen;
    return
        // SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        // scrollDirection: Axis.vertical,
        // child:
        //
      FittedBox(
     // width: MediaQuery.of(context).size.width,
      //margin: EdgeInsets.only(left: 10, right: 20),
      child:
        ConstrainedBox(

          constraints:  BoxConstraints(minWidth: MediaQuery.of(context).size.width -10),
          child: DataTable(
            columns: [
              DataColumn(
                label: Container(
                     child: Text('id')),
              ),
              DataColumn(
                label: Container(
                  //  width: MediaQuery.of(context).size.width / 14,
                    child: Text('Input')),
              ),
              DataColumn(
                label: Container(

                    child: Text('SearchBy')),
              ),
              DataColumn(
                label: Container(child: Text('Timestamp')),
              ),
              DataColumn(
                label: Container(
                    //width:,
                    child: Text('Result'),

                ),
              ),

            ],
            rows: storeData.reversed
                .map(
                  (element) => DataRow(cells: [
                    DataCell(
                      Container(
                         child: Text(
                          element.id.toString(),
                        ),
                      ),
                    ),
                    DataCell(
                      Container(

                        child: Text(
                          element.storeValue.toString(),
                          maxLines: 5,
                        ),
                      ),
                    ),
                    DataCell(
                      Container(

                        child: Text(
                          element.searchByValue.toString(),
                        ),
                      ),
                    ),

                    DataCell(
                      Container(

                        child: Text(
                          DateFormat("yyyy-MM-dd")
                              .add_jm()
                              .format(DateTime.parse(element.timestamp.toString()))
                              .toString(),
                          //maxLines: 5,
                        ),
                      ),
                    ),

                    DataCell(
                      Container(
                        child: Text(
                          element.result.toString(),
                        ),
                      ),
                    ),
                  ]),
                )
                .toList(),
          ),
        ),)

      ;
  //  );
    //,
    // );
  }

  list() {
    return Container(
      child: FutureBuilder(
        future: listOfStoreData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Center(child: Text("No Data Found"));
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // getData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Koj the Search'),
        centerTitle: true,
      ),
      body: Container(
        //margin: EdgeInsets.only(top: 80, left: 40, right: 30),

        child: ListView(
          //  physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,

          children: [
            Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.only(top: 80, left: 40, right: 30),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(right: 120),
                      child: Center(
                        child: Text(
                          "Koj The Search",
                          style: h1TextStyle,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CustomTextField(
                      labelName: 'Input Fields',
                      hintTextName: 'Enter Your List of Number including Comma',
                      textInputType: TextInputType.text,
                      onChangedFunction: (value) {
                        inputValues = value;
                      },
                      validateFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your List of Integer value';
                        }
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CustomTextField(
                      labelName: 'Search Value',
                      errorText: searchError,
                      hintTextName: 'Enter your Search number',
                      textInputType: TextInputType.visiblePassword,
                      //obscureTextTy: _secureText,
                      onChangedFunction: (value) {
                        searchValue = value;
                      },
                      validateFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Search value';
                        }
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      //width: 100,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 180, right: 100),
                      //padding: EdgeInsets.only(left: 10),
                      child: CustomButton(
                        buttonName: 'Khoj ',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print(searchValue.runtimeType);
                            print(inputValues.runtimeType);
                            FocusScope.of(context).requestFocus(FocusNode());
                            kojFunction(
                                inputValues: inputValues,
                                searchValue: searchValue);

                            refreshList();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            list(),
          ],
        ),
      ),
    );
  }

  kojFunction({inputValues, searchValue}) async {
    List<String> array = inputValues.split(',');
    int value = int.parse(searchValue);

    List<int> dataListAsInt = array.map((data) => int.parse(data)).toList();

    dataListAsInt.sort((b, a) => a.compareTo(b));
    print(dataListAsInt);

    var s = dataListAsInt.contains(value);
    if (s) {
      // print('True');
      // print(dataListAsInt.join(','));

      await DBHelper().storeData(
        StoreData(
          id: int.parse(widget.userId),
          timestamp: DateTime.now().toString(),
          searchByValue: searchValue.toString(),
          storeValue: dataListAsInt.join(',').toString(),
          result: "True",
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("The search value is matched"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      print('False');
      await DBHelper().storeData(
        StoreData(
          id: int.parse(widget.userId),
          timestamp: DateTime.now().toString(),
          searchByValue: searchValue.toString(),

          storeValue: dataListAsInt.join(',').toString(),
          result: "False",
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("The search value is not matched"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
