import 'package:flutter/material.dart';
import '../utils/storage_service.dart';
import '../models/bill_model.dart';

class RecoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final allBills = StorageService.getAllBills();
    final recoveredBills = allBills.where((b) => b.recovered).toList();

    if (recoveredBills.isEmpty) {
      return Center(child: Text("No recovered bills found."));
    }

    return ListView.builder(
      itemCount: recoveredBills.length,
      itemBuilder: (context, index) {
        final bill = recoveredBills[index];
        return Card(
          margin: EdgeInsets.all(10),
          elevation: 2,
          child: ListTile(
            title: Text(bill.customerName),
            subtitle: Text("Phone: ${bill.customerPhone}\nDate: ${bill.date.toLocal().toString().split(' ')[0]}"),
            trailing: Text("Recovered", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}
