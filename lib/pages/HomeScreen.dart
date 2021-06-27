import 'package:ami_coding_pari_na/pages/DashBoard.dart';
import 'package:ami_coding_pari_na/pages/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  String authToken = "";

  @override
  void initState() {
    _checkIfLoggedIn();
print(authToken);
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStroge = await SharedPreferences.getInstance();
    var token = localStroge.getString('token');
     print(token.toString());
    if (token != null) {
      print(token);
      setState(() {
        isAuth = true;
        authToken = token;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (isAuth) {
      child = DashBoard(
        lastId: int.parse(authToken),
      );
    } else {
      child = SignUp();
    }

    return Scaffold(
      body: child,
    );
  }
}
