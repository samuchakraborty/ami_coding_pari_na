import 'package:ami_coding_pari_na/services/DataBaseHelper.dart';
import 'package:ami_coding_pari_na/widgets/CustomButton.dart';
import 'package:ami_coding_pari_na/widgets/CustomTextField.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'DashBoard.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _secureText = true;
  final _formKey = GlobalKey<FormState>();

  var mobile;
  var password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(

        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'AMI_CODING_PARI_NA',
                  textStyle: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.blueGrey),
                  //speed: Duration(microseconds: 10)
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 40, left: 40, right: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  //  mainAxisAlignment: MainAxisAlignment.end,
                  //   mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(right: 120),
                      child: Center(
                        child: Text(
                          "Log In",
                          style: h1TextStyle,
                          maxLines: 2,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
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
                      buttonName: 'LOG IN',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
//

                          await DBHelper()
                              .loginUser(mobile: mobile, password: password)
                              .then((value) async {
                            if (value != null) {
                              print(value.id);

                              SharedPreferences localStorage =
                                  await SharedPreferences.getInstance();
                              localStorage.setString(
                                  'token', value.id.toString());

                              FocusScope.of(context).requestFocus(FocusNode());
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      " ${value.userName} is successfully login"),
                                  backgroundColor: Colors.green,
                                ),
                              );

                              Navigator.pop(context);
                              await Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashBoard(
                                    lastId: value.id,
                                  ),
                                ),
                              );
                            }
                          }).onError((error, stackTrace) {
                            print('user information not match');
                          });
                        }
                      },
                    ),

                    SizedBox(height: 40,),

                    SizedBox(
                      height: 200,
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                    fontSize: 17, fontFamily: 'Poppins'),
                              ),
                              Text(
                                "Sign up ",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.red,
                                    fontFamily: 'Poppins'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
