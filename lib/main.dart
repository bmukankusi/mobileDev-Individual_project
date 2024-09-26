import 'package:flutter/material.dart';

void main() {
  runApp(const TemperatureConversionApp());
}

class TemperatureConversionApp extends StatelessWidget {
  const TemperatureConversionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // Updated to bodyMedium
        ),
      ),
      home: const TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  _TemperatureConverterScreenState createState() =>
      _TemperatureConverterScreenState();
}

class TemperatureConverterScreenState {
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  String _conversionType = 'F to C'; // Default conversion
  final TextEditingController _temperatureController = TextEditingController();
  String _result = '';
  List<String> _conversionHistory = [];

  void _convertTemperature() {
    double inputTemp = double.tryParse(_temperatureController.text) ?? 0;
    double convertedTemp;

    if (_conversionType == 'F to C') {
      convertedTemp = (inputTemp - 32) * 5 / 9;
      setState(() {
        _result = "${inputTemp.toStringAsFixed(1)} °F => ${convertedTemp.toStringAsFixed(2)} °C";
      });
    } else {
      convertedTemp = inputTemp * 9 / 5 + 32;
      setState(() {
        _result = "${inputTemp.toStringAsFixed(1)} °C => ${convertedTemp.toStringAsFixed(2)} °F";
      });
    }

    // Add to history
    setState(() {
      _conversionHistory.add(_result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter temperature to convert:',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            TextField(
              controller: _temperatureController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Temperature',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'F to C',
                  groupValue: _conversionType,
                  activeColor: Colors.green,
                  onChanged: (String? value) {
                    setState(() {
                      _conversionType = value!;
                    });
                  },
                ),
                const Text(
                  'F to C',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 20),
                Radio<String>(
                  value: 'C to F',
                  groupValue: _conversionType,
                  activeColor: Colors.green,
                  onChanged: (String? value) {
                    setState(() {
                      _conversionType = value!;
                    });
                  },
                ),
                const Text(
                  'C to F',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertTemperature,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Updated backgroundColor
              ),
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Result:',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            Text(
              _result,
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Conversion History:',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _conversionHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _conversionHistory[index],
                      style: const TextStyle(color: Colors.white),
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
