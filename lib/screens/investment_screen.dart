import 'package:flutter/material.dart';
import '../utils/storage_service.dart';
import '../models/bill_model.dart';

class InvestmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bills = StorageService.getAllBills();

    double totalInvested = 0;
    double totalRecoveredInterest = 0;

    for (var bill in bills) {
      for (var item in bill.goldItems) {
        double loan = double.tryParse(item.loan) ?? 0;
        double interest = double.tryParse(item.interest) ?? 0;

        if (!bill.recovered) {
          totalInvested += loan;
        } else {
          totalRecoveredInterest += (loan * interest / 100);
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Investment Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Divider(),
              Text("Total Invested (Loaned): ₹${totalInvested.toStringAsFixed(2)}"),
              Text("Total Interest Recovered: ₹${totalRecoveredInterest.toStringAsFixed(2)}"),
            ],
          ),
        ),
      ),
    );
  }
}
