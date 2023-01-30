import 'package:flutter/material.dart';
import 'package:custom_radius_border/custom_radius_border.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          decoration: const BoxDecoration(
            color: Colors.red,
            border: CustomBorder(
              top: BorderSide(
                color: Colors.amber,
                strokeAlign: -1,
                width: 10,
              ),
              left: BorderSide(
                color: Colors.black,
                strokeAlign: -1,
                width: 10,
              ),
              right: BorderSide(
                color: Colors.green,
                strokeAlign: -1,
                width: 10,
              ),
              bottom: BorderSide(
                color: Colors.blue,
                strokeAlign: -1,
                width: 10,
              ),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomLeft: Radius.circular(50),
              topRight: Radius.circular(50),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: const Center(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
