import 'package:ami_coding_pari_na/constants.dart';
import 'package:ami_coding_pari_na/pages/Dekhao%20Chobi/DekhaoChobi.dart';
import 'package:ami_coding_pari_na/pages/KhojTheSearch/khojTheSearch.dart';
import 'package:ami_coding_pari_na/pages/SignUp.dart';
import 'package:ami_coding_pari_na/widgets/CustomDrawerItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDrawer extends StatelessWidget {
  final String? userName;
  final String? userMobile;
  final String? userId;

  UserDrawer(
      {required this.userName, required this.userMobile, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: 190,
              child: DrawerHeader(
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(CupertinoIcons.clear),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: Icon(
                            Icons.person,
                            size: 40,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(userName ?? ' ', style: emailTextStyle),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          userMobile ?? ' ',
                          style: emailTextStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            CustomDrawerItem(
              isOptional: false,
              iconsOptional: Icons.arrow_forward_ios_sharp,
              icon: CupertinoIcons.search,
              labelText: 'Khoj the search',
              route: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => KhojTheSearch(
                      userId: userId,
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 4,
            ),
            CustomDrawerItem(
              isOptional: false,
              icon: Icons.image_outlined,
              iconsOptional: Icons.arrow_forward_ios_sharp,
              labelText: 'Dekhao Chobi',
              route: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DekhaoChobi(),
                  ),
                );
              },
            ),
            // SizedBox(
            //   height: 8,
            // ),
            Expanded(
              flex: 2,
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(left: 40),
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () async {
                        SharedPreferences localStorage =
                            await SharedPreferences.getInstance();
                        localStorage.remove('token');
                        // print(localStorage.getString('token'));

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.logout,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Log Out',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
