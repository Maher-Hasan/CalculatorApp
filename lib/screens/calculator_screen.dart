import 'package:flutter/material.dart';
import '/widgets/calculator_button.dart';
import 'dart:math';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '0'; // Variable to hold the display text
  double? previousNumber;
  double? currentNumber;
  double? result;
  String? operator;
  bool clearDisplay =
      false; //Flag to determine if the display should be cleared
  String formatDisplay(double number) {
    if (!number.isFinite) {
      return 'Error';
    }
    if (number == number.toInt()) {
      return number.toInt().toString();
    } else {
      return number.toString();
    }
  }

  double memory = 0.0; // Variable to hold the memory value

  void onNumberPressed(String digit) {
    setState(() {
      if (digit == '.') {
        if (displayText.contains('.') && !clearDisplay) {
          return; // Prevent multiple dots in the current number
        } else if (clearDisplay) {
          displayText = '0.'; // Start new number with "0."
          clearDisplay = false;
        } else {
          displayText += '.'; // Append decimal point
        }
      } else {
        if (clearDisplay || displayText == '0') {
          displayText = digit;
          clearDisplay = false;
        } else {
          displayText += digit;
        }
      }

      currentNumber = double.tryParse(displayText);

      if (previousNumber != null && operator != null) {
        switch (operator) {
          case '+':
            result = previousNumber! + currentNumber!;
            break;
          case '-':
            result = previousNumber! - currentNumber!;
            break;
          case '/':
            result = previousNumber! / currentNumber!;
            break;
          case 'x':
            result = previousNumber! * currentNumber!;
            break;
        }
      }

      // Debugging
      print('Display: $displayText');
      print('Current: $currentNumber');
      print('Prev: $previousNumber');
      print('Result: $result');
    });
  }

  void onOperatorPressed(String op) {
    setState(() {
      previousNumber = double.tryParse(displayText);
      operator = op;
      if (result != null) {
        if (operator == '=' ||
            operator == '+' ||
            operator == '-' ||
            operator == '/' ||
            operator == 'x') {
          displayText = formatDisplay(result!);
          previousNumber = result;
        }
      } else if (op == '%') {
        double? num = double.tryParse(displayText);
        if (num != null) {
          result = num / 100;
          displayText = formatDisplay(result!);
          previousNumber = null;
          currentNumber = result;
          operator = null;
          clearDisplay = true;
        }
        return;
      } else {
        displayText =
            displayText = formatDisplay(
              currentNumber ?? 0,
            ); // Reset display if no previous number
      }
      clearDisplay = true; // So next number input will replace display
      // Debugging
      print('Operator: $operator');
      print('Current Number: $currentNumber');
      print('previousNumber: $previousNumber');
      print('result: $result');
      print(clearDisplay);
      print('Memory: $memory');
    });
  }

  void onClearEntryPressed() {
    setState(() {
      displayText = '0'; // Reset display to 0
      result = previousNumber;
      currentNumber = null;
      // Debugging
      print('Operator: $operator');
      print('Current Number: $currentNumber');
      print('previousNumber: $previousNumber');
      print('result: $result');
      print(clearDisplay);
      print('Memory: $memory');
    });
  }

  void onClearPressed() {
    setState(() {
      displayText = '0';
      previousNumber = null;
      currentNumber = null;
      result = null;
      operator = null;
      clearDisplay = false;
      // Debugging
      print('Operator: $operator');
      print('Current Number: $currentNumber');
      print('previousNumber: $previousNumber');
      print('result: $result');
      print(clearDisplay);
      print('Memory: $memory');
    });
  }

  void onSqrtPressed() {
    setState(() {
      double? num = double.tryParse(displayText);
      if (num != null && num >= 0) {
        result = double.parse((sqrt(num)).toStringAsFixed(10));
        displayText = formatDisplay(result!);
        previousNumber = null;
        currentNumber = result;
        operator = null;
        clearDisplay = true;
      }
    });
    print('Operator: $operator');
    print('Current Number: $currentNumber');
    print('previousNumber: $previousNumber');
    print('result: $result');
    print(clearDisplay);
    print('Memory: $memory');
  }

  void onToggleSignPressed() {
    setState(() {
      double? num = double.tryParse(displayText);
      if (num != null) {
        result = -num;
        displayText = formatDisplay(result!);
        currentNumber = result;
        clearDisplay = false;
      }
    });
    print('Operator: $operator');
    print('Current Number: $currentNumber');
    print('previousNumber: $previousNumber');
    print('result: $result');
    print(clearDisplay);
    print('Memory: $memory');
  }

  void onMemoryPlus() {
    memory += double.tryParse(displayText) ?? 0.0;
    // Debugging
    print('Operator: $operator');
    print('Current Number: $currentNumber');
    print('previousNumber: $previousNumber');
    print('result: $result');
    print(clearDisplay);
    print('Memory: $memory');
  }

  void onMemoryMinus() {
    memory -= double.tryParse(displayText) ?? 0.0;
    // Debugging
    print('Operator: $operator');
    print('Current Number: $currentNumber');
    print('previousNumber: $previousNumber');
    print('result: $result');
    print(clearDisplay);
    print('Memory: $memory');
  }

  void onMemoryRecall() {
    displayText = memory.toString();
    setState(() {});
    // Debugging
    print('Operator: $operator');
    print('Current Number: $currentNumber');
    print('previousNumber: $previousNumber');
    print('result: $result');
    print(clearDisplay);
    print('Memory: $memory');
  }

  void onMemoryClear() {
    if (displayText == memory.toString()) {
      displayText = '0';
      setState(() {});
    }
    memory = 0.0;
    // Debugging
    print('Operator: $operator');
    print('Current Number: $currentNumber');
    print('previousNumber: $previousNumber');
    print('result: $result');
    print(clearDisplay);
    print('Memory: $memory');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator'), centerTitle: true),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ), // <-- Left & Right Margin
          padding: const EdgeInsets.all(16.0), // <-- Inner padding
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey.shade200, Colors.grey.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(6, 6),
              ),
            ],
            border: Border.all(color: Colors.grey.shade500, width: 2),
            borderRadius: BorderRadius.circular(18),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double maxWidth =
                  constraints.maxWidth > 400 ? 400 : constraints.maxWidth;

              return SizedBox(
                width: maxWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Display
                    Container(
                      height: 100,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.grey.shade200],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        border: Border.all(
                          color: Colors.grey.shade500,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true, // New digits appear on the right
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            displayText,
                            style: TextStyle(
                              fontSize: 38,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Second Section: 5 Rows with 5 buttons each (Calculator Buttons)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildButton(
                          label: 'MC',
                          onPressed: () => onMemoryClear(),
                        ),
                        buildButton(
                          label: 'MR',
                          onPressed: () => onMemoryRecall(),
                        ),
                        buildButton(
                          label: 'M+',
                          onPressed: () => onMemoryPlus(),
                        ),
                        buildButton(
                          label: 'M-',
                          onPressed: () => onMemoryMinus(),
                        ),
                        buildButton(
                          label: '√',
                          onPressed: () => onSqrtPressed(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildButton(
                          label: 'C',
                          onPressed: () => onClearPressed(),
                        ),
                        buildButton(
                          label: '7',
                          onPressed: () => onNumberPressed('7'),
                        ),
                        buildButton(
                          label: '8',
                          onPressed: () => onNumberPressed('8'),
                        ),
                        buildButton(
                          label: '9',
                          onPressed: () => onNumberPressed('9'),
                        ),
                        buildButton(
                          label: '/',
                          onPressed: () => onOperatorPressed('/'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildButton(
                          label: 'CE',
                          onPressed: () => onClearEntryPressed(),
                        ),
                        buildButton(
                          label: '4',
                          onPressed: () => onNumberPressed('4'),
                        ),
                        buildButton(
                          label: '5',
                          onPressed: () => onNumberPressed('5'),
                        ),
                        buildButton(
                          label: '6',
                          onPressed: () => onNumberPressed('6'),
                        ),
                        buildButton(
                          label: 'x',
                          onPressed: () => onOperatorPressed('x'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildButton(
                          label: '%',
                          onPressed: () => onOperatorPressed('%'),
                        ),
                        buildButton(
                          label: '1',
                          onPressed: () => onNumberPressed('1'),
                        ),
                        buildButton(
                          label: '2',
                          onPressed: () => onNumberPressed('2'),
                        ),
                        buildButton(
                          label: '3',
                          onPressed: () => onNumberPressed('3'),
                        ),
                        buildButton(
                          label: '-',
                          onPressed: () => onOperatorPressed('-'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildButton(
                          label: '+/-',
                          onPressed: () => onToggleSignPressed(),
                        ),
                        buildButton(
                          label: '0',
                          onPressed: () => onNumberPressed('0'),
                        ),
                        buildButton(
                          label: '.',
                          onPressed: () => onNumberPressed('.'),
                        ),
                        buildButton(
                          label: '=',
                          onPressed: () => onOperatorPressed('='),
                        ),
                        buildButton(
                          label: '+',
                          onPressed: () => onOperatorPressed('+'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
