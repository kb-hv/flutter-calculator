import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calculator/custom_button.dart';
import 'package:flutter_calculator/size_config.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var input = '';
  var calculation = '';
  List<String> buttons = [
    'C',
    '^',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "CALCULATOR",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            buttons = [
              'C',
              '^',
              '%',
              'DEL',
              '7',
              '8',
              '9',
              '/',
              '4',
              '5',
              '6',
              'x',
              '1',
              '2',
              '3',
              '-',
              '0',
              '.',
              '=',
              '+',
            ];
          }

          if (orientation == Orientation.landscape) {
            buttons = [
              '+',
              '-',
              'x',
              '/',
              '^',
              '%',
              'C',
              'DEL',
              '.',
              '=',
              '1',
              '2',
              '3',
              '4',
              '5',
              '6',
              '7',
              '8',
              '9',
              '0',
            ];
          }

          return Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 5, vertical: 0),
                          alignment: Alignment.centerRight,
                          child: AutoSizeText(
                            input,
                            style: TextStyle(
                                fontSize: orientation == Orientation.portrait
                                    ? SizeConfig.safeBlockHorizontal * 10
                                    : SizeConfig.safeBlockVertical * 5),
                            maxLines:
                                orientation == Orientation.portrait ? 2 : 1,

                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 5, vertical: 0),
                          alignment: Alignment.centerRight,
                          child: AutoSizeText(
                            calculation,
                            maxLines:
                                orientation == Orientation.portrait ? 2 : 1,
                            style: TextStyle(
                                fontSize: orientation == Orientation.portrait? SizeConfig.safeBlockHorizontal * 10
                                : SizeConfig.safeBlockVertical * 7,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ]),
                ),
              ),
              Expanded(
                flex: orientation == Orientation.portrait ? 2 : 1,
                child: Container(
                  child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          orientation == Orientation.portrait ? 4 : 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      // calculate
                      if (buttons[index] == '=') {
                        print(buttons[0]);
                        return CustomButton(
                          orientation: orientation,

                          onTap: () {
                            setState(() {
                              String userInput = input;
                              userInput = userInput.replaceAll('x', '*');
                              Parser parser = Parser();
                              Expression expression = parser.parse(userInput);
                              ContextModel cm = ContextModel();
                              double eval =
                                  expression.evaluate(EvaluationType.REAL, cm);
                              calculation = eval.toString();
                            });
                          },
                          text: buttons[index],
                          bgColor: Color(0xFFDD4A48),
                          color: Colors.white,
                        );
                      }
                      // Clear Button
                      else if (buttons[index] == 'C') {
                        return CustomButton(
                          orientation: orientation,
                          onTap: () {
                            setState(() {
                              input = '';
                              calculation = '0';
                            });
                          },
                          text: buttons[index],
                          bgColor: Color(0xFF97BFB4),
                          color: Colors.black,
                        );
                      }
                      // Delete
                      else if (buttons[index] == 'DEL') {
                        return CustomButton(
                          orientation: orientation,

                          onTap: () {
                            setState(() {
                              input = input.substring(0, input.length - 1);
                            });
                          },
                          text: buttons[index],
                          bgColor: Color(0xFF97BFB4),
                          color: Colors.black,
                        );
                      }

                      //  operators
                      else if (buttons[index] == '+' ||
                          buttons[index] == '-' ||
                          buttons[index] == '/' ||
                          buttons[index] == 'x' ||
                          buttons[index] == '%' ||
                          buttons[index] == '^') {
                        return CustomButton(
                          orientation: orientation,

                          onTap: () {
                            setState(() {
                              input += buttons[index];
                            });
                          },
                          text: buttons[index],
                          bgColor: Color(0xFF97BFB4),
                          color: Colors.white,
                        );
                      } else {
                        return CustomButton(
                          orientation: orientation,

                          onTap: () {
                            setState(() {
                              input += buttons[index];
                            });
                          },
                          text: buttons[index],
                          bgColor: Colors.white,
                          color: Colors.black,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          );
          // }
        },
      ),
    );
  }
}
