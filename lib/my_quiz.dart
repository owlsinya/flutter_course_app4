import 'dart:math';

import 'package:flutter/material.dart';

class TileInfo {
  String title;
  Color color;
  TileInfo({required this.title, this.color = Colors.purple});
}

int score = 0;

class MyQuiz extends StatefulWidget {
  @override
  State<MyQuiz> createState() => _MyQuizState();
}

class _MyQuizState extends State<MyQuiz> {
  int currentPage = 0;
  List<bool?> boolToShow = List.generate(10, (index) => Random().nextBool());
  List<bool?> boolCheckList = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    bool everythingIsFine = true;
    List<TileInfo> tileInfoList = [
      TileInfo(title: "Red", color: Colors.red),
      TileInfo(title: "Blue", color: Colors.blue),
      TileInfo(title: "Green", color: Colors.green),
      TileInfo(title: "Orange", color: Colors.orange),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Quiz"),
      ),
      body: currentPage == 0
          ? SingleChildScrollView(
              // width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  const Text(
                    "Select the red List Tile",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  ...List.generate(
                    tileInfoList.length,
                    (index) => _customListTile(
                      title: tileInfoList[index].title,
                      color: tileInfoList[index].color,
                    ),
                  ),
                  SizedBox(),
                ],
              ),
            )
          : currentPage == 1
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Check only YES Tile",
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(),
                      ...List.generate(boolCheckList.length, (index) {
                        for (int i = 0; i < boolCheckList.length; i++) {
                          if (boolToShow[i] != boolCheckList[i]) {
                            everythingIsFine = false;
                          }
                        }

                        return CheckboxListTile(
                          value: boolCheckList[index],
                          onChanged: (valueBool) {
                            setState(
                              () {
                                boolCheckList[index] = valueBool;
                              },
                            );
                          },
                          title: Text(boolToShow[index]! ? "YES" : "NO"),
                        );
                      }),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (everythingIsFine) {
                              score = score + 1;
                            }
                            currentPage = currentPage + 1;
                          });
                        },
                        child: Text("Finish"),
                      ),
                      SizedBox(),
                    ],
                  ),
                )
              : Container(
                  child: Center(
                    child: Text(
                      "Score $score",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
    );
  }

  Widget _customListTile({
    required String title,
    required Color color,
  }) =>
      ListTile(
        title: Text(title),
        tileColor: color,
        onTap: () {
          if (color == Colors.red) {
            print(score);
            score = 1;
            print(score);
          } else {
            score = 0;
          }
          setState(() {
            //it will rebuild everything from start
            currentPage = currentPage + 1;
          });
        },
      );
}
