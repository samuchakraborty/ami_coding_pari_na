
import 'package:flutter/material.dart';
import 'pages/HomeScreen.dart';
void main() {
 WidgetsFlutterBinding.ensureInitialized();
 runApp(MyApp());
}
class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
  return MaterialApp(
   debugShowCheckedModeBanner: false,
   theme: ThemeData(
    primarySwatch: Colors.red,
   ),
   home: Home(),
  );
 }
}