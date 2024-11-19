import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MedicineDetailsPage extends StatelessWidget {
  final String medicineName;
  final String imageUrl;

  const MedicineDetailsPage({
    required this.medicineName,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  Future<Map<String, dynamic>?> fetchMedicineDetails() async {
    final url =
        'https://api.fda.gov/drug/label.json?search=active_ingredient:$medicineName';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results']?[0];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicineName),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchMedicineDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data == null) {
            return const Center(
              child: Text('No data found for this medicine.'),
            );
          }

          final data = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSectionTitle('Active Ingredient'),
                _buildSectionContent(
                    data['active_ingredient']?.join('\n') ?? 'N/A'),
                const Divider(height: 20),
                _buildSectionTitle('Purpose'),
                _buildSectionContent(data['purpose']?.join('\n') ?? 'N/A'),
                const Divider(height: 20),
                _buildSectionTitle('Warnings'),
                _buildSectionContent(data['warnings']?.join('\n') ?? 'N/A'),
                const Divider(height: 20),
                _buildSectionTitle('Dosage and Administration'),
                _buildSectionContent(
                    data['dosage_and_administration']?.join('\n') ?? 'N/A'),
                const Divider(height: 20),
                _buildSectionTitle('Inactive Ingredients'),
                _buildSectionContent(
                    data['inactive_ingredient']?.join('\n') ?? 'N/A'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        content,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }
}
