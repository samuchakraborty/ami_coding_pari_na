import 'package:ami_coding_pari_na/widgets/CustomButton.dart';
import 'package:ami_coding_pari_na/widgets/CustomTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class KhojTheSearch extends StatefulWidget {
  @override
  _KhojTheSearchState createState() => _KhojTheSearchState();
}

class _KhojTheSearchState extends State<KhojTheSearch> {
  final _formKey = GlobalKey<FormState>();
  var inputValues;
  var searchValue;
  var searchError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),

      body: Container(
        margin: EdgeInsets.only(top: 80, left: 40, right: 30),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            //  mainAxisAlignment: MainAxisAlignment.end,
            //   mainAxisSize: MainAxisSize.max,
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
                          inputValues: inputValues, searchValue: searchValue);
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


    );
  }

  kojFunction({inputValues, searchValue}) {
    // String myString = '9,1,5,7,10,11,0';
    //print(myString.runtimeType);
// var ss = json.decode(myString);
//  print(ss.runtimeType);
    List<String> array = inputValues.split(',');
    int value = int.parse(searchValue);

    List<int> dataListAsInt = array.map((data) => int.parse(data)).toList();
    //
    // print(dataListAsInt.runtimeType);
    // print(dataListAsInt);
    dataListAsInt.sort((b, a) => a.compareTo(b));
     print(dataListAsInt);
    // print(value.runtimeType);
    var s = dataListAsInt.contains(value);
    if (s) {
      print('True');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("The search value is matched"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      print('False');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("The search value is not matched"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
