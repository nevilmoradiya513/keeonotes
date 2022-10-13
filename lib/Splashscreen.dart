import 'package:flutter/material.dart';
import 'AddNotes.dart';
import 'ViweNotes.dart';

class Splashscreen extends StatefulWidget {

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ViweNotes(),)
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splashscreen"),
      ),
      body:  Container(
        width: 240,
        height: 240,
        margin: EdgeInsets.all(70.0),
        padding: EdgeInsets.all(11.0),
        color: Colors.black26,
        child: Card(
          elevation: 45.0,
          shadowColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column
            (
            children:
            [
              Image.network("https://www.google.com/images/icons/product/keep-512.png"),
              Text("BUSINESS IMGES"),
            ],
          ),
        ),
      ),
    );
  }
}
