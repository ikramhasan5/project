import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

  void _onButtonPressed(String buttonText) {
    if (buttonText == "C") {
      setState(() {
        _output = "0";
        _outputHistory = "";
      });
      return;
    } else if (buttonText == "=") {
      // Calculate the result
      String result;
      try {
        result = evalExpression(_output);
      } catch (e) {
        result = "Error";
      }

      setState(() {
        _output = result;
        _outputHistory += "=$_output";
      });
      return;
    } else {
      setState(() {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
        _outputHistory += buttonText;
      });
    }
  }

  String evalExpression(String expression) {
    return expression;
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => _onButtonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    _outputHistory,
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                  Text(
                    _output,
                    style: TextStyle(fontSize: 48.0),
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 0.0),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("/"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("*"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("C"),
                  buildButton("0"),
                  buildButton("="),
                  buildButton("+"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
