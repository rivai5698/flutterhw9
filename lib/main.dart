import 'package:flutter/material.dart';
import 'package:flutterhw9/category_bloc/category_bloc.dart';
import 'package:flutterhw9/model/item.dart' as it;
import 'package:flutterhw9/pages/category_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  CategoryPage(items: it.items,cart: [],),
    );
  }
}

