import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  const MyCalculator({Key? key});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String _output = '';
  String _currentNumber = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operator = '';
  bool _isOperatorClicked = false;

  void _buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      _output = '';
      _currentNumber = '';
      _num1 = 0;
      _num2 = 0;
      _operator = '';
      _isOperatorClicked = false;
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '×' ||
        buttonText == '÷') {
      if (_isOperatorClicked) {
        if (_num1 != 0 && _currentNumber.isNotEmpty) {
          _num2 = double.parse(_currentNumber);
          if (_operator == '+') {
            _currentNumber = (_num1 + _num2).toString();
          } else if (_operator == '-') {
            _currentNumber = (_num1 - _num2).toString();
          } else if (_operator == '×') {
            _currentNumber = (_num1 * _num2).toString();
          } else if (_operator == '÷') {
            _currentNumber = (_num1 / _num2).toString();
          }
          _num1 = double.parse(_currentNumber);
        }
        _operator = buttonText;
        _isOperatorClicked = true;
      } else {
        _num1 = double.parse(_currentNumber);
        _operator = buttonText;
        _isOperatorClicked = true;
      }
      _currentNumber = '';
    } else if (buttonText == '=') {
      if (_isOperatorClicked && _num1 != 0 && _currentNumber.isNotEmpty) {
        _num2 = double.parse(_currentNumber);
        if (_operator == '+') {
          _currentNumber = (_num1 + _num2).toString();
        } else if (_operator == '-') {
          _currentNumber = (_num1 - _num2).toString();
        } else if (_operator == '×') {
          _currentNumber = (_num1 * _num2).toString();
        } else if (_operator == '÷') {
          _currentNumber = (_num1 / _num2).toString();
        }
        _num1 = double.parse(_currentNumber);
        _operator = '';
        _isOperatorClicked = false;
      }
    } else if (buttonText == '.') {
      if (!_currentNumber.contains('.') && _currentNumber.isNotEmpty) {
        _currentNumber += '.';
      }
    } else {
      _currentNumber += buttonText;
    }

    setState(() {
      _output = _currentNumber;
    });
  }

  Widget buildButton(String buttonText, {double? width, double? height}) {
    return Container(
      width: width ?? 80.0,
      height: height ?? 80.0,
      child: OutlinedButton(
        onPressed: () {
          _buttonPressed(buttonText);
        },
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(width ?? 80, height ?? 80)),
          padding: MaterialStateProperty.all(EdgeInsets.all(0)),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          backgroundColor: buttonText == 'C'
              ? MaterialStateProperty.all(Colors.grey[300])
              : MaterialStateProperty.all(Colors.grey[100]),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          )),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Calculadora'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(
              _output,
              style: TextStyle(
                fontSize: 65.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: <Widget>[
                buildButton('7'),
                buildButton('8'),
                buildButton('9'),
                buildButton('÷'),
                buildButton('4'),
                buildButton('5'),
                buildButton('6'),
                buildButton('×'),
                buildButton('1'),
                buildButton('2'),
                buildButton('3'),
                buildButton('-'),
                buildButton('0'), // Wider '0' button
                buildButton('.'),
                buildButton('+'),
                buildButton('='), // Taller '=' button
                buildButton('C'), // Taller and narrower 'C' button
              ],
            ),
          ),
        ],
      ),
    );
  }
}
