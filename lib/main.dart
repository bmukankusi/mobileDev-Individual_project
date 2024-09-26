import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TempConverterHome(),
    );
  }
}

class TempConverterHome extends StatefulWidget {
  const TempConverterHome({super.key});

  @override
  _TempConverterHomeState createState() => _TempConverterHomeState();
}

class _TempConverterHomeState extends State<TempConverterHome> {
  final TextEditingController _tempController = TextEditingController();
  bool _isFtoC = true;
  String _result = '';
  final List<String> _history = [];
  String? _inputError; // To show error message if input is invalid

  void _convertTemperature() {
    setState(() {
      _inputError = null;
      double? inputTemp = double.tryParse(_tempController.text);

      if (inputTemp == null) {
        _inputError = 'Please enter a valid number';
        return;
      }

      double convertedTemp;
      if (_isFtoC) {
        // Fahrenheit to Celsius conversion
        convertedTemp = (inputTemp - 32) * 5 / 9;
        _result = "${inputTemp.toStringAsFixed(1)} °F => ${convertedTemp.toStringAsFixed(2)} °C";
      } else {
        // Celsius to Fahrenheit conversion
        convertedTemp = inputTemp * 9 / 5 + 32;
        _result = "${inputTemp.toStringAsFixed(1)} °C => ${convertedTemp.toStringAsFixed(2)} °F";
      }

      // Add the conversion result to history
      _history.insert(0, _result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        )
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: _isFtoC,
                  onChanged: (bool? value) {
                    setState(() {
                      _isFtoC = value!;
                    });
                  },
                ),
                const Text('F to C',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                Radio<bool>(
                  value: false,
                  groupValue: _isFtoC,
                  onChanged: (bool? value) {
                    setState(() {
                      _isFtoC = value!;
                    });
                  },
                ),
                const Text('C to F',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ],
            ),
           
            TextField(
              controller: _tempController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Temperature to convert',
                border: const OutlineInputBorder(),
                errorText: _inputError, // Error message displayed here
              ),
            ),
            const SizedBox(height: 20),
            // Convert button
            ElevatedButton(
              onPressed: _convertTemperature,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
                child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            // Result display
            Text(
              _result,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            // Conversion history display
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _history[index],
                      style: const TextStyle(color: Colors.green),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


