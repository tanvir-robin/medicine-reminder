import 'package:flutter/material.dart';
import 'package:medicine_reminder/pages/medicine_list/medicine_details.dart';

class MedicineListPage extends StatefulWidget {
  @override
  _MedicineListPageState createState() => _MedicineListPageState();
}

class _MedicineListPageState extends State<MedicineListPage> {
  final List<Map<String, String>> medicines = [
    {
      'name': 'Aspirin',
      'description': 'Pain reliever (NSAID)',
      'image':
          'https://medicinaonline.ae/cdn/shop/products/Aspirin-Protect-30_s.jpg'
    },
    {
      'name': 'Paracetamol',
      'description': 'Fever reducer and pain reliever',
      'image':
          'https://phabcart.imgix.net/cdn/scdn/images/uploads/m0459_web.jpg'
    },
    {
      'name': 'Omeprazole',
      'description': 'Reduces stomach acid',
      'image':
          'https://www.adegenpharma.com/wp-content/uploads/2023/02/OMILESS-20-CAPSULE.jpg'
    },
    {
      'name': 'Ibuprofen',
      'description': 'Pain reliever (NSAID)',
      'image':
          'https://i5.walmartimages.com/seo/Equate-Ibuprofen-Mini-Softgel-Capsules-200-mg-160-Count_d2498da5-b4b9-4363-b143-0c6d24ff1286.9e764a0673ce90582406c072c0a0861b.jpeg'
    },
    {
      'name': 'Loratadine',
      'description': 'Antihistamine',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbLlJgKzKNIdSb_VFB0ChHX6PWBZgdEWjizw&s'
    },
    {
      'name': 'Cetirizine',
      'description': 'Antihistamine',
      'image':
          'https://cdn11.bigcommerce.com/s-0hgi7r5fnp/images/stencil/1280x1280/products/113/517/zista_100-2__68276.1698542802.png?c=1'
    },
    {
      'name': 'Diphenhydramine',
      'description': 'Antihistamine',
      'image':
          'https://images.ctfassets.net/za5qny03n4xo/1eMhurqw0cnm90opZD7rUQ/b2ec4b89f1525c034d417d9756f3ec04/ah_side_0.png'
    },
    {
      'name': 'Ranitidine',
      'description': 'Reduces stomach acid',
      'image':
          'https://image.made-in-china.com/2f0j00ryubDWtsgvcT/Ranitidine-Hydrochloride-Injection-50mg-2ml.webp'
    },
    {
      'name': 'Lansoprazole',
      'description': 'Reduces stomach acid',
      'image':
          'https://res.cloudinary.com/zava-www-uk/image/upload/a_exif,f_auto,e_sharpen:100,c_fit,w_800,h_600,fl_lossy/v1706805554/sd/uk/services-setup/acid-reflux/lansoprazole/azwwqs0qjupaekmmqqr8.png'
    },
    {
      'name': 'Fexofenadine',
      'description': 'Antihistamine',
      'image':
          'https://www.albionbd.com/wp-content/uploads/2021/08/Fexofenadine-180-Tablet.jpg'
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredMedicines = medicines
        .where((medicine) =>
            medicine['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Medicines',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                helperText: 'Search by name and tap to view details',
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMedicines.length,
              itemBuilder: (context, index) {
                final medicine = filteredMedicines[index];
                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Image.network(
                      medicine['image']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      medicine['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(medicine['description']!),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MedicineDetailsPage(
                            imageUrl: medicine['image']!,
                            medicineName: medicine['name']!,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
