import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _outputHistory = "";

  String operand = "";
  double num1 = 0.0;
  double num2 = 0.0;

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "";
      _outputHistory = "";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "*") {
      if (num1 != 0) {
        buttonPressed("=");
      }
      num1 = double.parse(_output);
      operand = buttonText;
      _outputHistory += buttonText;
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      } else {
        _output += buttonText;
        _outputHistory += buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(_output);
      _outputHistory += "=$_output";
      switch (operand) {
        case "+":
          _output = (num1 + num2).toString();
          break;
        case "-":
          _output = (num1 - num2).toString();
          break;
        case "*":
          _output = (num1 * num2).toString();
          break;
        case "/":
          _output = (num1 / num2).toString();
          break;
        default:
          break;
      }
      num1 = double.parse(_output);
      num2 = 0;
      operand = "";
    } else {
      if (_output == "0" && buttonText != ".") {
        _output = buttonText;
      } else {
        _output += buttonText;
      }
      _outputHistory += buttonText;
    }

    setState(() {});
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(15.0),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Text(
              _outputHistory,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Text(
              _output,
              style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("/"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("*"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("-"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton("."),
              buildButton("0"),
              buildButton("C"),
              buildButton("+"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton("="),
            ],
          ),
        ],
      ),
    );
  }
}
