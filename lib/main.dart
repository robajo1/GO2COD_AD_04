import 'package:flutter/material.dart';

void main() {
  runApp(UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UnitConverterHome(),
    );
  }
}

class UnitConverterHome extends StatefulWidget {
  @override
  _UnitConverterHomeState createState() => _UnitConverterHomeState();
}

class _UnitConverterHomeState extends State<UnitConverterHome> {
  final List<String> units = ['Temperature', 'Weight', 'Length'];
  String selectedUnit = 'Temperature';

  final Map<String, List<String>> subUnits = {
    'Temperature': ['Celsius', 'Fahrenheit', 'Kelvin'],
    'Weight': ['Kilograms', 'Pounds', 'Ounces'],
    'Length': ['Meters', 'Inches', 'Feet'],
  };

  String fromUnit = 'Celsius';
  String toUnit = 'Fahrenheit';
  String input = '';
  String result = '';

  void convert() {
    double? value = double.tryParse(input);
    if (value == null) {
      setState(() {
        result = 'Invalid input';
      });
      return;
    }

    double convertedValue;
    switch (selectedUnit) {
      case 'Temperature':
        if (fromUnit == 'Celsius' && toUnit == 'Fahrenheit') {
          convertedValue = (value * 9 / 5) + 32;
        } else if (fromUnit == 'Fahrenheit' && toUnit == 'Celsius') {
          convertedValue = (value - 32) * 5 / 9;
        } else if (fromUnit == 'Celsius' && toUnit == 'Kelvin') {
          convertedValue = value + 273.15;
        } else if (fromUnit == 'Kelvin' && toUnit == 'Celsius') {
          convertedValue = value - 273.15;
        } else if (fromUnit == 'Fahrenheit' && toUnit == 'Kelvin') {
          convertedValue = (value - 32) * 5 / 9 + 273.15;
        } else if (fromUnit == 'Kelvin' && toUnit == 'Fahrenheit') {
          convertedValue = (value - 273.15) * 9 / 5 + 32;
        } else {
          convertedValue = value; // No conversion, same unit
        }
        break;

      case 'Weight':
        if (fromUnit == 'Kilograms' && toUnit == 'Pounds') {
          convertedValue = value * 2.20462;
        } else if (fromUnit == 'Pounds' && toUnit == 'Kilograms') {
          convertedValue = value / 2.20462;
        } else if (fromUnit == 'Kilograms' && toUnit == 'Ounces') {
          convertedValue = value * 35.274;
        } else if (fromUnit == 'Ounces' && toUnit == 'Kilograms') {
          convertedValue = value / 35.274;
        } else if (fromUnit == 'Pounds' && toUnit == 'Ounces') {
          convertedValue = value * 16;
        } else if (fromUnit == 'Ounces' && toUnit == 'Pounds') {
          convertedValue = value / 16;
        } else {
          convertedValue = value;
        }
        break;

      case 'Length':
        if (fromUnit == 'Meters' && toUnit == 'Inches') {
          convertedValue = value * 39.3701;
        } else if (fromUnit == 'Inches' && toUnit == 'Meters') {
          convertedValue = value / 39.3701;
        } else if (fromUnit == 'Meters' && toUnit == 'Feet') {
          convertedValue = value * 3.28084;
        } else if (fromUnit == 'Feet' && toUnit == 'Meters') {
          convertedValue = value / 3.28084;
        } else if (fromUnit == 'Inches' && toUnit == 'Feet') {
          convertedValue = value / 12;
        } else if (fromUnit == 'Feet' && toUnit == 'Inches') {
          convertedValue = value * 12;
        } else {
          convertedValue = value;
        }
        break;

      default:
        convertedValue = value;
    }

    setState(() {
      result = convertedValue.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: selectedUnit,
              onChanged: (value) {
                setState(() {
                  selectedUnit = value!;
                  fromUnit = subUnits[selectedUnit]!.first;
                  toUnit = subUnits[selectedUnit]!.last;
                });
              },
              items: units.map((unit) {
                return DropdownMenuItem(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: fromUnit,
                    onChanged: (value) {
                      setState(() {
                        fromUnit = value!;
                      });
                    },
                    items: subUnits[selectedUnit]!.map((unit) {
                      return DropdownMenuItem(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: DropdownButton<String>(
                    value: toUnit,
                    onChanged: (value) {
                      setState(() {
                        toUnit = value!;
                      });
                    },
                    items: subUnits[selectedUnit]!.map((unit) {
                      return DropdownMenuItem(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Value',
              ),
              onChanged: (value) {
                input = value;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Result: $result',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
