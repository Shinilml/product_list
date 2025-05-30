import 'package:flutter/material.dart';
import 'package:product_list/controller/productscreencontroller.dart';
import 'package:product_list/views/bottomnavigationbar/bottomnavigationbar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Productscreencontroller(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavigation(),
      ),
    );
  }
}
