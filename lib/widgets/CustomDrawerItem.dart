import 'package:flutter/material.dart';
class CustomDrawerItem extends StatelessWidget {
  CustomDrawerItem(
      {required this.labelText,
        required this.isOptional,
        this.route,
        required this.icon,
        this.iconsOptional});

  final IconData icon;
  final String labelText;
  final IconData? iconsOptional;
  final bool isOptional;
  final Function()? route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: route,
      child: Container(
        margin:
        isOptional == false ? EdgeInsets.only(left: 20, right: 10) : EdgeInsets.all(0),
        padding: isOptional == false ? EdgeInsets.all(8) : EdgeInsets.all(0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(
              width: 10,
            ),
            Text(
              labelText,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(iconsOptional),
              ),
            ),
            // SizedBox(
            //   width: 10,
            // ),
          ],
        ),
      ),
    );
  }
}