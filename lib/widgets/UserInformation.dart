import 'package:flutter/material.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({
    required this.labelText,
    required this.value,
  });

  final String? value;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.center,
      margin: EdgeInsets.only(left: 50),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText, style: TextStyle(fontSize: 18, color: Colors.blueGrey)),
          SizedBox(
            width: 10,
          ),
          Text(value ?? ' ', style: TextStyle(fontSize: 18, color: Colors.indigo))
        ],
      ),
    );
  }
}