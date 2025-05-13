import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/storage_service.dart';
import '../models/bill_model.dart';

class CustomerInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bills = StorageService.getAllBills();

    final Map<String, BillModel> uniqueCustomers = {};
    for (var bill in bills) {
      uniqueCustomers[bill.customerPhone] = bill;
    }

    final customers = uniqueCustomers.values.toList();

    return ListView.builder(
      itemCount: customers.length,
      itemBuilder: (context, index) {
        final bill = customers[index];
        return Card(
          margin: EdgeInsets.all(10),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(bill.customerName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Phone: ${bill.customerPhone}'),
                Text('Address: ${bill.customerAddress}'),
                SizedBox(height: 8),
                Row(
                  children: [
                    if (bill.customerPhotoPath != null && File(bill.customerPhotoPath!).existsSync())
                      Image.file(File(bill.customerPhotoPath!), height: 60),
                    if (bill.customerIdPath != null && File(bill.customerIdPath!).existsSync())
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Image.file(File(bill.customerIdPath!), height: 60),
                      ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
