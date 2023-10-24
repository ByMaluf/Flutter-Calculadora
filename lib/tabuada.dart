import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyTabuada(),
  ));
}

class MyTabuada extends StatelessWidget {
  const MyTabuada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabuada'),
      ),
      body: TabuadaCalculator(),
    );
  }
}

class TabuadaCalculator extends StatefulWidget {
  @override
  _TabuadaCalculatorState createState() => _TabuadaCalculatorState();
}

class _TabuadaCalculatorState extends State<TabuadaCalculator> {
  int _number = 1; // Número para o qual a tabuada será calculada
  String _output = '';

  void _calculateTabuada() {
    setState(() {
      _output = '';
      for (int i = 1; i <= 10; i++) {
        int result = _number * i;
        _output += '$_number x $i = $result\n';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _number = int.tryParse(value) ?? 1;
              });
            },
            decoration: InputDecoration(
              labelText: 'Digite um número',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _calculateTabuada,
          child: Text('Calcular Tabuada'),
        ),
        SizedBox(height: 16),
        Text(
          _output,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
