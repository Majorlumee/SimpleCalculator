import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(home: CalculatorApp(),
    debugShowCheckedModeBanner: false,));
}
class CalculatorApp extends StatefulWidget {

  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 38;
  double  resultFontSize = 48;

  buttonPressed(String buttontext){
    setState(() {

      if(buttontext == 'C'){
        equation = '0';
        result = '0';
        equationFontSize = 38;
        resultFontSize = 48;
      }
      else if(buttontext == '='){
        equationFontSize = 38;
        resultFontSize = 48;
        expression = equation;
        expression = expression.replaceAll('x', '*');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }
        catch(e){
          result = 'ERROR';
        }
      }
      else if(buttontext == 'del'){
        equationFontSize = 48;
        resultFontSize = 38;
        equation = equation.substring(0, equation.length -1);
        if(equation == ''){
          equation = '0';
        }
      }
      else{
        equationFontSize = 48;
        resultFontSize = 38;
        if(equation == '0'){
          equation = buttontext;}
        else{
          equation = equation + buttontext;
        }
      }

    });
  }

  Widget buildbutton (Color color, String buttonText, double buttonHeight){
    return GestureDetector(
      onTap: (){
        buttonPressed(buttonText);
      },
      child: Container(
        height: buttonHeight,
        decoration:  BoxDecoration(
            color: color,
            shape: BoxShape.rectangle
        ),
        child:  Center(
          child: Text(buttonText,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.normal
            ),),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: const Center(
          child: Text('Calculator',
            style: TextStyle(
                color: Colors.white
            ),),
        ),
      ),
      backgroundColor: Colors.black26,
      body: Column(
        children: [
          Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(10, 20,10, 0),
              child: Text(equation,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: equationFontSize
                ),)),
          Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(10, 20,10, 0),
              child: Text(result,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: resultFontSize
                ),)),
          const Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildbutton(Colors.red, 'C', MediaQuery.of(context).size.height*0.1),
                          buildbutton(Colors.blueAccent, '/', MediaQuery.of(context).size.height*0.1),
                          buildbutton(Colors.blueAccent, 'x', MediaQuery.of(context).size.height*0.1),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildbutton(Colors.grey, '7', MediaQuery.of(context).size.height*0.1),
                          buildbutton(Colors.grey, '8', MediaQuery.of(context).size.height*0.1),
                          buildbutton(Colors.grey, '9', MediaQuery.of(context).size.height*0.1),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildbutton(Colors.grey, '4', MediaQuery.of(context).size.height*0.1),
                          buildbutton(Colors.grey, '5', MediaQuery.of(context).size.height*0.1),
                          buildbutton(Colors.grey, '6', MediaQuery.of(context).size.height*0.1),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildbutton(Colors.grey, '1', MediaQuery.of(context).size.height*0.1),
                          buildbutton(Colors.grey, '2', MediaQuery.of(context).size.height*0.1),
                          buildbutton(Colors.grey, '3', MediaQuery.of(context).size.height*0.1),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildbutton(Colors.grey, '.', MediaQuery.of(context).size.height*0.1),
                          buildbutton(Colors.grey, '0', MediaQuery.of(context).size.height*0.1),
                          buildbutton(Colors.grey, '00', MediaQuery.of(context).size.height*0.1),
                        ]
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.25,
                child: Column(children: [
                  buildbutton(Colors.blueAccent, 'del', MediaQuery.of(context).size.height*0.1),
                  buildbutton(Colors.blueAccent, '-', MediaQuery.of(context).size.height*0.1),
                  buildbutton(Colors.blueAccent, '+', MediaQuery.of(context).size.height*0.1),
                  buildbutton(Colors.red, '=', MediaQuery.of(context).size.height*0.2),
                ],),
              )
            ],
          )
        ],
      ),
    );
  }
}

