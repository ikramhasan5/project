import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('BMI Calculator'),
        ),
        body: BMICalculatorForm(),
      ),
    );
  }
}

class BMICalculatorForm extends StatefulWidget {
  @override
  _BMICalculatorFormState createState() => _BMICalculatorFormState();
}

class _BMICalculatorFormState extends State<BMICalculatorForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  double _bmi = 0.0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your height';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Height (cm)',
            ),
          ),
          TextFormField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your weight';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Weight (kg)',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                double height = double.parse(_heightController.text);
                double weight = double.parse(_weightController.text);
                double bmi = weight / ((height / 100) * (height / 100));
                setState(() {
                  _bmi = bmi;
                });
              }
            },
            child: Text('Calculate BMI'),
          ),
          SizedBox(height: 20),
          Text(
            _bmi == 0.0
                ? 'Your BMI will appear here'
                : 'Your BMI: ${_bmi.toStringAsFixed(1)}',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Text(
            _bmi == 0.0 ? '' : _getBMIResult(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  String _getBMIResult() {
    if (_bmi < 18.5) {
      return 'Underweight';
    } else if (_bmi >= 18.5 && _bmi < 24.9) {
      return 'Normal weight';
    } else if (_bmi >= 25.0 && _bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }
}
