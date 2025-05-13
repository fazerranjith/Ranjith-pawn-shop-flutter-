import 'package:flutter/material.dart';
import '../utils/storage_service.dart';
import '../models/bill_model.dart';

class OverdueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final allBills = StorageService.getAllBills();
    final oneYearAgo = DateTime.now().subtract(Duration(days: 365));

    final overdueBills = allBills.where((bill) =>
      !bill.recovered && bill.date.isBefore(oneYearAgo)
    ).toList();

    if (overdueBills.isEmpty) {
      return Center(child: Text("No overdue bills found."));
    }

    return ListView.builder(
      itemCount: overdueBills.length,
      itemBuilder: (context, index) {
        final bill = overdueBills[index];
        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            title: Text(bill.customerName),
            subtitle: Text("Phone: ${bill.customerPhone}\nDate: ${bill.date.toLocal().toString().split(' ')[0]}"),
            trailing: Text("Overdue", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}
