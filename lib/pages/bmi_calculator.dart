import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final TextEditingController _heightFeetController = TextEditingController();
  final TextEditingController _heightInchesController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double _calculateBMI(double heightInInches, double weightInKg) {
    double heightInMeters = heightInInches * 0.0254;
    return weightInKg / (heightInMeters * heightInMeters);
  }

  String _getHealthStatus(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal weight';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'BMI Calculator',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Calculate Your BMI',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            // TextField for Height in Feet
            _buildTextField('Height (feet)', 'Enter your height in feet',
                _heightFeetController),
            SizedBox(height: 16),
            // TextField for Height in Inches
            _buildTextField('Height (inches)', 'Enter your height in inches',
                _heightInchesController),
            SizedBox(height: 16),
            // TextField for Weight
            _buildTextField(
                'Weight (kg)', 'Enter your weight in kg', _weightController),
            SizedBox(height: 20),
            // Calculate Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  double heightFeet =
                      double.tryParse(_heightFeetController.text) ?? 0;
                  double heightInches =
                      double.tryParse(_heightInchesController.text) ?? 0;
                  double weight = double.tryParse(_weightController.text) ?? 0;

                  double totalHeightInInches = (heightFeet * 12) + heightInches;
                  double bmi = _calculateBMI(totalHeightInInches, weight);
                  String healthStatus = _getHealthStatus(bmi);

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('BMI Result'),
                        content: Text(
                            'Your BMI is ${bmi.toStringAsFixed(2)}\nHealth Status: $healthStatus'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Calculate',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[500]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.teal),
            ),
            filled: true,
            fillColor: Colors.grey[100],
          ),
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
