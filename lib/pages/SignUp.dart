import 'package:ami_coding_pari_na/models/UserModel.dart';
import 'package:ami_coding_pari_na/pages/DashBoard.dart';
import 'package:ami_coding_pari_na/services/DataBaseHelper.dart';
import 'package:ami_coding_pari_na/widgets/CustomButton.dart';
import 'package:ami_coding_pari_na/widgets/CustomTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'LoginPage.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _secureText = true;

  final _formKey = GlobalKey<FormState>();
  var userName;
  var mobile;
  var password;
  var dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper().initDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 80, left: 40, right: 30),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(right: 120),
                child: Center(
                  child: Text(
                    "Create Account",
                    style: h1TextStyle,
                    maxLines: 2,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                labelName: 'User Name',
                hintTextName: 'Samu Chakraborty',
                textInputType: TextInputType.text,
                onChangedFunction: (value) {
                  userName = value;
                },
                validateFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your User Name';
                  }
                },
              ),
              SizedBox(
                height: 40,
              ),
              CustomTextField(
                labelName: 'Mobile',
                hintTextName: '018888888',
                textInputType: TextInputType.number,
                onChangedFunction: (value) {
                  mobile = value;
                },
                validateFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your Mobile Number';
                  }
                },
              ),
              SizedBox(
                height: 40,
              ),
              CustomTextField(
                labelName: 'Password',
                hintTextName: '*****',
                textInputType: TextInputType.visiblePassword,
                obscureTextTy: _secureText,
                validateFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your Password';
                  }
                },
                onChangedFunction: (value) {
                  password = value;
                },
                icon: _secureText
                    ? Icons.visibility_off_outlined
                    : Icons.remove_red_eye_outlined,
                onPressed: () {
                  setState(() {
                    _secureText = !_secureText;
                  });
                },
              ),
              SizedBox(
                height: 40,
              ),
              CustomButton(
                buttonName: 'SIGN UP',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await DBHelper()
                        .save(User(
                            userName: userName,
                            mobile: (mobile),
                            password: password))
                        .then((value) async {
                      if (value != null || value.isNotEmpty) {
                        print(value);

                         SharedPreferences localStorage = await SharedPreferences.getInstance();
                         localStorage.setString('token', value!.toString());
                        var s = localStorage.getString('token');
                        print('hhhhh');
                        print(s);

                        FocusScope.of(context).requestFocus(FocusNode());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${userName} is successfully register"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashBoard(
                              lastId: value!,
                            ),
                          ),
                        );
                      }
                    });
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LogIn(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 17, fontFamily: 'Poppins'),
                    ),
                    Text(
                      "Log In ",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.red,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
