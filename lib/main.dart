import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleCalculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '';
  String _expression = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '';
        _expression = '';
      } else if (buttonText == '=') {
        try {
          String finalExpression =
              _expression.replaceAll('×', '*').replaceAll('÷', '/');
          Expression exp = Parser().parse(finalExpression);
          ContextModel cm = ContextModel();
          double result = exp.evaluate(EvaluationType.REAL, cm);
          _output = _formatResult(result);
          _expression = _output;
        } catch (e) {
          _output = 'Error';
        }
      } else if (buttonText == '√') {
        try {
          double value = double.parse(_expression);
          double result = sqrt(value);
          _output = _formatResult(result);
          _expression = _output;
        } catch (e) {
          _output = 'Error';
        }
      } else if (buttonText == 'x²') {
        try {
          double value = double.parse(_expression);
          double result = pow(value, 2) as double;
          _output = _formatResult(result);
          _expression = _output;
        } catch (e) {
          _output = 'Error';
        }
      } else if (buttonText == 'sin') {
        try {
          double value = double.parse(_expression);
          double result = sin(value);
          _output = _formatResult(result);
          _expression = _output;
        } catch (e) {
          _output = 'Error';
        }
      } else if (buttonText == 'cos') {
        try {
          double value = double.parse(_expression);
          double result = cos(value);
          _output = _formatResult(result);
          _expression = _output;
        } catch (e) {
          _output = 'Error';
        }
      } else if (buttonText == 'tan') {
        try {
          double value = double.parse(_expression);
          double result = tan(value);
          _output = _formatResult(result);
          _expression = _output;
        } catch (e) {
          _output = 'Error';
        }
      } else if (buttonText == 'π') {
        _output = pi.toString();
        _expression = pi.toString();
      } else if (buttonText == 'e') {
        _output = e.toString();
        _expression = e.toString();
      } else {
        _expression += buttonText;
        _output = _expression;
      }
    });
  }

  String _formatResult(double result) {
    if (result == result.toInt()) {
      return result.toInt().toString();
    } else {
      return result.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SimpleCalculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerRight,
              child: Text(
                _output,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double buttonHeight = constraints.maxHeight / 6;
                double buttonWidth = constraints.maxWidth / 4;
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _buttonNames.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: buttonWidth / buttonHeight,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: buttonHeight,
                      width: buttonWidth,
                      child: CalculatorButton(
                        buttonText: _buttonNames[index],
                        callback: _onButtonPressed,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String buttonText;
  final Function(String) callback;

  const CalculatorButton({
    required this.buttonText,
    required this.callback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1.0),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: _getButtonColor(buttonText),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        onPressed: () => callback(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Color _getButtonColor(String buttonText) {
    if (buttonText == 'C') {
      return Colors.brown;
    } else if (buttonText == '√' ||
        buttonText == '%' ||
        buttonText == '÷' ||
        buttonText == '×' ||
        buttonText == '-' ||
        buttonText == '+' ||
        buttonText == '=' ||
        buttonText == 'π' ||
        buttonText == 'e') {
      return Colors.yellow;
    } else {
      return Colors.black;
    }
  }
}

final List<String> _buttonNames = [
  'C',
  '√',
  '%',
  '÷',
  '7',
  '8',
  '9',
  '×',
  '4',
  '5',
  '6',
  '-',
  '1',
  '2',
  '3',
  '+',
  '0',
  '.',
  '±',
  '=',
  'π',
  'e',
  'x²',
  'sin',
  'cos',
  'tan'
];
