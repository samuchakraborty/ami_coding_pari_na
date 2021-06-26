
import 'package:ami_coding_pari_na/widgets/UserDrawer.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: UserDrawer(),
      appBar: AppBar(),
    );
  }
}
