import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BillingScreen extends StatefulWidget {
  @override
  _BillingScreenState createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  List<Map<String, String>> goldItems = [];
  File? customerPhoto, customerIdProof, goldPhoto;

  final picker = ImagePicker();

  Future<void> pickImage(ImageSource source, Function(File) setImage) async {
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      setState(() {
        setImage(File(picked.path));
      });
    }
  }

  void addGoldItem() {
    setState(() {
      goldItems.add({
        'desc': '',
        'weight': '',
        'purity': '',
        'loan': '',
        'interest': '',
        'duration': '',
      });
    });
  }

  void generateBill() {
    if (nameController.text.isEmpty || phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter customer name and phone')),
      );
      return;
    }

    // TODO: Save bill data, generate preview and PDF
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bill generated! (Preview not implemented yet)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Customer Info", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
          TextField(controller: phoneController, decoration: InputDecoration(labelText: 'Phone'), keyboardType: TextInputType.phone),
          TextField(controller: addressController, decoration: InputDecoration(labelText: 'Address')),

          SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => pickImage(ImageSource.gallery, (f) => customerPhoto = f),
                child: Text('Upload Customer Photo'),
              ),
              if (customerPhoto != null)
                Padding(padding: EdgeInsets.only(left: 10), child: Image.file(customerPhoto!, width: 60)),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => pickImage(ImageSource.gallery, (f) => customerIdProof = f),
                child: Text('Upload ID Proof'),
              ),
              if (customerIdProof != null)
                Padding(padding: EdgeInsets.only(left: 10), child: Image.file(customerIdProof!, width: 60)),
            ],
          ),

          SizedBox(height: 20),
          Text("Gold Items", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...goldItems.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, String> item = entry.value;

            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Description'),
                      onChanged: (val) => item['desc'] = val,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Weight (g)'),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => item['weight'] = val,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Purity (%)'),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => item['purity'] = val,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Loan Amount'),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => item['loan'] = val,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Interest (%)'),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => item['interest'] = val,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Duration (months)'),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => item['duration'] = val,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            goldItems.removeAt(index);
                          });
                        },
                        child: Text('Remove', style: TextStyle(color: Colors.red)),
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
          SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: addGoldItem,
            icon: Icon(Icons.add),
            label: Text('Add Gold Item'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: generateBill,
            child: Text('Generate Bill'),
            style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 40)),
          ),
        ],
      ),
    );
  }
}
