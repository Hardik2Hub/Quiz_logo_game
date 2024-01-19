import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logogame/game.dart';
import 'package:logogame/main.dart';

class level extends StatefulWidget {
  @override
  State<level> createState() => _levelState();
}

class _levelState extends State<level> {
  List h = [];
  List l = [];
  int level_no = 0;
  int p=0;

  @override
  void initState() {
    super.initState();

    h = List.filled(14, '');

    p=logo.prefes!.getInt('point') ?? 0;

    for (int i = 0; i < h.length; i++) {
      h[i] = logo.prefes!.getString('le_st$i') ?? "";
      setState(() {});
    }
    _initImages();
    setState(() {});

  }

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('img/'))
        .where((String key) => key.contains('.png'))
        .toList();

    setState(() {
      l = imagePaths;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Select Level   Point = ${p}"),
        ),
        body: GridView.builder(
          itemCount: l.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            String test = logo.prefes!.getString('le_st$index') ?? "";
            return InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return game(l, index);
                  },
                ));
              },
              child: Container(
                child: (test != 'yes')
                    ? Image(
                        image: AssetImage('${l[index]}'),
                        fit: BoxFit.fill,
                      )
                    : Opacity(
                        opacity: 0.2,
                        child: Image(
                          image: AssetImage('${l[index]}'),
                          fit: BoxFit.fill,
                        ),
                      ),
                decoration: BoxDecoration(
                  image: (test != "yes")
                      ? DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('${l[index]}'),
                        )
                      : DecorationImage(
                          alignment: Alignment.bottomLeft,
                          scale: 5,
                          image: AssetImage('imgs/level_guessed_badge.png'),
                        ),
                ),
              ),
            );
          },
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
                        return logo();
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
