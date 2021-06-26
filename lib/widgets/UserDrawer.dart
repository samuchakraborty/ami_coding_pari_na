import 'package:ami_coding_pari_na/constants.dart';
import 'package:ami_coding_pari_na/pages/Dekhao%20Chobi/DekhaoChobi.dart';
import 'package:ami_coding_pari_na/pages/KhojTheSearch/khojTheSearch.dart';
import 'package:ami_coding_pari_na/widgets/CustomDrawerItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 280,
            child: DrawerHeader(
              // decoration: BoxDecoration(
              //   color: Colors.blue,
              // ),
              child: Column(
                //shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
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
                        radius: 60,
                        //   backgroundColor: Colors.transparent,
                        // backgroundImage: AssetImage(
                        //   'assets/images/child.jpg',
                        //   // fit: BoxFit.contain,
                        // ),
                         child: Icon(Icons.person, size: 40,),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Samu Chakraborty", style: emailTextStyle),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "samuckb@gmail.com",
                        style: emailTextStyle,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          CustomDrawerItem(
            isOptional: false,
            iconsOptional: Icons.arrow_forward_ios_sharp,
            icon: CupertinoIcons.search,
            labelText: 'Khoj the search',
            route: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => KhojTheSearch(),
                ),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustomDrawerItem(
            isOptional: false,
            icon: CupertinoIcons.flag,
            iconsOptional: Icons.arrow_forward_ios_sharp,
            labelText: 'Dekhao Chobi',
            route: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DekhaoChobi(),
                ),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(left: 40),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Log Out',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
