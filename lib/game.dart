import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logogame/level.dart';
import 'package:logogame/main.dart';

class game extends StatefulWidget {
  List l = [];
  int ind;

  game(this.l, this.ind);

  @override
  State<game> createState() => _gameState();
}

class _gameState extends State<game> {
  List temp = [];
  List user_ans = [];
  List ans = [
    "ADIDAS",
    "AMAZON",
    "APPLE",
    "FACEBOOK",
    "HONDA",
    "LACOSTE",
    "MCDONALDS",
    "MERCEDES",
    "NIKE",
    "PIZZAHUT",
    "SHELL",
    "STARBUCKS",
    "TOYOTA",
    "VISA",
    "VOLKSWAGEN",
    "WIKIPEDIA",
  ];
  List random_op = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  List option = [];
  List h = [];
  List abc = [];
  List abc1 = [];
  int level_no = 0;
  int  p=0;
  bool skip=false;
  PageController? controller;

  @override
  void initState() {
    controller = PageController(initialPage: widget.ind);
    h = List.filled(14, '');
    p=logo.prefes!.getInt('point') ?? 0;
    for (int i = 0; i < h.length; i++) {
      h[i] = logo.prefes!.getString('le_st$i') ?? "";
      setState(() {});
    }
    fun();
    win();
    setState(() {});
  }

  fun() {
    user_ans = List.filled(ans[widget.ind].toString().length, "");
    random_op.shuffle();
    option = List.filled(14, "");
    abc = List.filled(user_ans.length, "");
    abc1 = List.filled(user_ans.length, "");
    temp = List.filled(user_ans.length, '');

    for (int i = 0; i < user_ans.length; i++) {
      option[i] = ans[widget.ind][i];
    }
    for (int i = user_ans.length; i < 14; i++) {
      option[i] = random_op[i];
    }
    option.shuffle();
    setState(() {});
  }

  win() {
    String str = user_ans.join('');

    if (str == ans[widget.ind]) {

      if(skip==false)
      {
          p+=30;
      }

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.green,
            title: Center(
                child: Text(
              "Perfect!",
              style: TextStyle(fontSize: 30, color: Colors.white),
            )),
            actions: [
              TextButton(
                  onPressed: () {
                    logo.prefes!.setString('le_st${widget.ind}', 'yes');
                    logo.prefes!.setInt('point',p);
                    setState(() {});
                    if (widget.ind < ans.length - 1) {
                      widget.ind++;
                    }
                    skip=false;
                    controller?.jumpToPage(widget.ind);
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: Center(
                      child: Text(
                    "OK",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )))
            ],
          );
        },
      );
      setState(() {});
    } else {
      if (str.length == temp.length) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.black,
              title: Center(
                  child: Text(
                "Incorrect",
                style: TextStyle(fontSize: 25, color: Colors.white),
              )),
              icon: Center(
                  child: Container(
                height: 50,
                width: 50,
                child: Image(image: AssetImage('imgs/n_delete_all_red.png')),
              )),
              content: Text("Remove Some Letter Ans Try Again",
                  style: TextStyle(color: Colors.white)),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        "OK",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ))
              ],
            );
          },
        );
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("${widget.ind + 1}/${ans.length}     Point = ${p}")),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: PageView.builder(
              onPageChanged: (value) {
                widget.ind = value;
                fun();
                setState(() {});
              },
              controller: controller,
              itemCount: ans.length,
              itemBuilder: (context, index) {
                String test = logo.prefes!.getString('le_st$index') ?? "";
                return Column(children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Row(children: [
                        Expanded(
                          child: InkWell(
                              onTap: () {
                                if (widget.ind > 0) {
                                  widget.ind--;
                                }
                                controller?.jumpToPage(widget.ind);
                                setState(() {});
                              },
                              child: Icon(Icons.arrow_back_ios_new_outlined)),
                        ),
                        Expanded(
                            flex: 8,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          '${widget.l[widget.ind]}'))),
                            )),
                        Expanded(
                          child: InkWell(
                              onTap: () {
                                if (widget.ind < ans.length - 1) {
                                  widget.ind++;
                                }
                                controller?.jumpToPage(widget.ind);
                                setState(() {});
                              },
                              child: Icon(Icons.arrow_forward_ios_outlined)),
                        ),
                      ]),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: (test != 'yes')
                        ? Container(
                            child: Wrap(
                              children: List.generate(
                                user_ans.length,
                                (index) => (user_ans[index] != "")
                                    ? InkWell(
                                        onTap: () {
                                          option[temp[index]] = user_ans[index];
                                          user_ans[index] = "";
                                          setState(() {});
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.all(3),
                                          height: 50,
                                          width: 50,
                                          child: Text("${user_ans[index]}",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.black)),
                                          color: Colors.black54,
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.all(3),
                                        height: 50,
                                        width: 50,
                                        child: Text("${user_ans[index]}",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.black)),
                                        color: Colors.black54,
                                      ),
                              ),
                            ),
                          )
                        : Text("${ans[widget.ind]}",
                            style: TextStyle(fontSize: 35)),
                  ),
                  Expanded(
                    child: Container(
                      child: (test != "yes")
                          ? Row(children: [
                              Expanded(
                                flex: 3,
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.black,
                                          title: Center(
                                            child: Text("You Have 1 Hints",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                          content: Container(
                                              height: 200,
                                              width: 200,
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    InkWell(
                                                        onTap: ()
                                                        {
                                                          if(p>=10)
                                                          {
                                                            skip=true;
                                                            if(p>0)
                                                            {
                                                              p-=10;
                                                              logo.prefes!.setInt('point',p);
                                                            }
                                                            int r = Random()
                                                                .nextInt(user_ans
                                                                .length);

                                                            for (int i = 0;
                                                            i <
                                                                ans[widget
                                                                    .ind]
                                                                    .length;
                                                            i++) {
                                                              abc[i] =
                                                              ans[widget.ind]
                                                              [i];
                                                            }
                                                            user_ans[r] = abc[r];
                                                            for (int i = 0;
                                                            i < option.length;
                                                            i++) {
                                                              if (abc[r] ==
                                                                  option[i]) {
                                                                temp[r] = i;
                                                                option[i] = "";
                                                              }
                                                            }
                                                          }
                                                          Navigator.pop(
                                                              context);
                                                          win();
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              "Random 1 Letter",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          width: 200,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                        )),
                                                 InkWell(
                                                        onTap: () {
                                                          if(p>=20)
                                                          {
                                                            skip=true;
                                                              if(p>0)
                                                              {
                                                                p-=20;
                                                                logo.prefes!.setInt('point',p);
                                                              }

                                                            int r = Random().nextInt(user_ans.length);
                                                            int r1 = Random().nextInt(user_ans.length);

                                                            for (int i = 0; i < ans[widget.ind].length; i++)
                                                            {
                                                              abc[i] = ans[widget.ind][i];
                                                            }
                                                            for (int i = 0; i < ans[widget.ind].length; i++)
                                                            {
                                                              abc1[i] = ans[widget.ind][i];
                                                            }
                                                            user_ans[r] = abc[r];
                                                            for (int i = 0; i < option.length; i++)
                                                            {
                                                              if (abc[r] == option[i])
                                                              {
                                                                temp[r] = i;
                                                                option[i] = "";
                                                                break;
                                                              }
                                                            }
                                                            user_ans[r1] = abc[r1];
                                                            for (int i = 0; i < option.length; i++)
                                                            {
                                                              if (abc1[r1] == option[i])
                                                              {
                                                                temp[r1] = i;
                                                                option[i] = "";
                                                                break;
                                                              }
                                                            }

                                                            List main_anc=abc+abc1;

                                                          }
                                                          Navigator.pop(context);
                                                          win();
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              "Random 2 Letter",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          width: 200,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                        )),
                                                    InkWell(onTap: () {
                                                      if(p>=30)
                                                      {
                                                        skip=true;
                                                        if(p>0)
                                                        {
                                                          p-=30;
                                                          logo.prefes!.setInt('point',p);
                                                        }
                                                        for(int i=0;i<option.length;i++)
                                                        {
                                                          option[i]="";
                                                        }
                                                        for(int i=0;i<user_ans.length;i++)
                                                        {
                                                          option[i]=ans[widget.ind][i];
                                                        }
                                                        option.shuffle();
                                                        win();
                                                      }
                                                      Navigator.pop(context);
                                                      setState(() {});
                                                    },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            "Remove Extra Letters",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        width: 200,
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            10))),
                                                      ),
                                                    ),
                                                  ]),
                                              color: Colors.black),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: double.infinity,
                                      child: Text("Use Hints",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                      margin: EdgeInsets.only(
                                          left: 20,
                                          right: 5,
                                          bottom: 3,
                                          top: 3),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'imgs/game_button_use_hints_clicked.png')))),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    for (int i = 0; i < user_ans.length; i++) {
                                      if (user_ans[i] != "") {
                                        option[temp[i]] = user_ans[i];
                                        user_ans[i] = "";
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: 5, right: 5, bottom: 3, top: 3),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'imgs/n_delete_all_red.png')))),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    for (int i = temp.length - 1; i >= 0; i--) {
                                      if (temp[i] != "") {
                                        option[temp[i]] = user_ans[i];
                                        temp[i] = "";
                                        user_ans[i] = "";
                                        break;
                                      }
                                    }
                                    setState(() {});
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: 5,
                                          right: 10,
                                          bottom: 3,
                                          top: 3),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'imgs/n_delete_one_red.png')))),
                                ),
                              ),
                            ])
                          : Text(""),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: (test != "yes")
                        ? Container(
                            child: GridView.builder(
                            itemCount: 14,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 7),
                            itemBuilder: (context, index) {
                              return (option[index] != "")
                                  ? InkWell(
                                      onTap: () {
                                        for (int i = 0; i < user_ans.length; i++) {
                                          if (user_ans[i] == "") {
                                            user_ans[i] = option[index];
                                            temp[i] = index;
                                            option[index] = "";
                                            win();
                                            break;
                                          }
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 5,
                                            bottom: 2,
                                            right: 2,
                                            left: 2),
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${option[index]}",
                                          style: TextStyle(
                                              fontSize: 28,
                                              color: Colors.black),
                                        ),
                                      ),
                                    )
                                  : Text('');
                            },
                          ))
                        : Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(5),
                            color: Colors.green,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Perfect!",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: InkWell(
                                      onTap: () {
                                        if (widget.ind < ans.length - 1) {
                                          widget.ind++;
                                        }
                                        controller?.jumpToPage(widget.ind);
                                        setState(() {});
                                      },
                                      child: Text(
                                        "Next",
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.white),
                                      ),
                                    ))
                                  ],
                                ),
                              ],
                            )),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                ]);
              },
            )),
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
                        return level();
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
