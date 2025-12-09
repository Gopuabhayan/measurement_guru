import 'package:flutter/material.dart';

class ScreenCalculator extends StatefulWidget {
  const ScreenCalculator({super.key});

  @override
  State<ScreenCalculator> createState() => _ScreenCalculatorState();
}

class _ScreenCalculatorState extends State<ScreenCalculator> {
  String _display = '0';
  String _expression = '';
  double _firstOperand = 0;
  String _operator = '';
  bool _shouldResetDisplay = false;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '0';
        _expression = '';
        _firstOperand = 0;
        _operator = '';
        _shouldResetDisplay = false;
      } else if (value == '⌫') {
        if (_display.length > 1) {
          _display = _display.substring(0, _display.length - 1);
        } else {
          _display = '0';
        }
      } else if (['+', '-', '×', '÷', '%'].contains(value)) {
        _firstOperand = double.parse(_display);
        _operator = value;
        _expression = '$_display $value';
        _shouldResetDisplay = true;
      } else if (value == '=') {
        if (_operator.isNotEmpty) {
          double secondOperand = double.parse(_display);
          double result = 0;

          switch (_operator) {
            case '+':
              result = _firstOperand + secondOperand;
              break;
            case '-':
              result = _firstOperand - secondOperand;
              break;
            case '×':
              result = _firstOperand * secondOperand;
              break;
            case '÷':
              result = secondOperand != 0 ? _firstOperand / secondOperand : 0;
              break;
            case '%':
              result = _firstOperand % secondOperand;
              break;
          }

          _expression = '$_expression $_display';
          _display = result.toString();
          if (_display.endsWith('.0')) {
            _display = _display.substring(0, _display.length - 2);
          }
          _operator = '';
          _shouldResetDisplay = true;
        }
      } else if (value == '.') {
        if (!_display.contains('.')) {
          _display = _display + '.';
        }
      } else {
        if (_shouldResetDisplay) {
          _display = value;
          _shouldResetDisplay = false;
        } else {
          _display = _display == '0' ? value : _display + value;
        }
      }
    });
  }

  Widget _buildButton(String text, {Color? color, Color? textColor, double? flex}) {
    return Expanded(
      flex: (flex ?? 1).toInt(),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.white,
            foregroundColor: textColor ?? Colors.black87,
            padding: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Calculator')),
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // Display Area
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(24),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _expression,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _display,
                      style: const TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            // Button Grid
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton('C', color: Colors.red[400], textColor: Colors.white),
                          _buildButton('⌫', color: Colors.orange[400], textColor: Colors.white),
                          _buildButton('%', color: Colors.blue[400], textColor: Colors.white),
                          _buildButton('÷', color: Colors.blue[400], textColor: Colors.white),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton('7'),
                          _buildButton('8'),
                          _buildButton('9'),
                          _buildButton('×', color: Colors.blue[400], textColor: Colors.white),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton('4'),
                          _buildButton('5'),
                          _buildButton('6'),
                          _buildButton('-', color: Colors.blue[400], textColor: Colors.white),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton('1'),
                          _buildButton('2'),
                          _buildButton('3'),
                          _buildButton('+', color: Colors.blue[400], textColor: Colors.white),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton('0', flex: 2),
                          _buildButton('.'),
                          _buildButton('=', color: Colors.green[500], textColor: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}