import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logogame/level.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: logo(),
    debugShowCheckedModeBanner: false,
  ));
}

class logo extends StatefulWidget {
  static SharedPreferences? prefes;

  @override
  State<logo> createState() => _logoState();
}

class _logoState extends State<logo> {
  int level_no = 0;
  List h = [];
  int p = 0;

  @override
  void initState() {
    super.initState();
    get_per();
  }

  get_per() async {
    logo.prefes = await SharedPreferences.getInstance();

    h = List.filled(14, '');

    p=logo.prefes!.getInt('point') ?? 0;

    for (int i = 0; i < h.length; i++) {
      h[i] = logo.prefes!.getString('le_st$i') ?? "";
      setState(() {});
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text("LOGO QUIZ   Point = ${p}"),
        ),
        body: Center(
          child: InkWell(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return level();
                },
              ));
            },
            child: Container(
              alignment: Alignment.center,
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text("Start", style: TextStyle(fontSize: 30)),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Are You Exit"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("CANCLE"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return exit(0);
                      },
                    ));
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
        return true;
      },
    );
  }
}
