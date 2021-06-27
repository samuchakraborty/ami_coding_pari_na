import 'package:ami_coding_pari_na/services/DataBaseHelper.dart';
import 'package:ami_coding_pari_na/widgets/UserDrawer.dart';
import 'package:ami_coding_pari_na/widgets/UserInformation.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  final lastId;

  DashBoard({this.lastId});

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String? mobile;
  String? password;
  String? name;
  String? id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("last id get");
    print(widget.lastId.runtimeType);
     getData();
  }

  getData() async {
    return await DBHelper().getUser(lastId: widget.lastId).then((value) {
      setState(() {
        mobile = value?.mobile.toString();
        password = value?.password.toString();
        name = value?.userName.toString();
        id = value?.id.toString();
      });
    });

    //   print(i!.mobile);
  }

  @override
  Widget build(BuildContext context) {
   // getData();
    return Scaffold(
      drawer: UserDrawer(
        userMobile: mobile,
        userName: name,
        userId: id


      ),
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
        //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'User Profile',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            SizedBox(
              height: 40,
            ),
            UserInformation(
              value: id,
              labelText: 'Id: ',
            ),
            SizedBox(
              height: 10,
            ),
            UserInformation(
              value: name,
              labelText: 'Name: ',
            ),
            SizedBox(
              height: 10,
            ),
            UserInformation(
              value: mobile,
              labelText: 'Mobile: ',
            ),
            SizedBox(
              height: 10,
            ),
            UserInformation(
              value: password,
              labelText: 'Password: ',
            ),
          ],
        ),
      ),
    );
  }
}


