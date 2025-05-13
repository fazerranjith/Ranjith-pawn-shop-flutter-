import 'package:flutter/material.dart';
import '../utils/storage_service.dart';
import '../utils/pdf_service.dart';
import '../models/bill_model.dart';

class SavedBillsScreen extends StatefulWidget {
  @override
  _SavedBillsScreenState createState() => _SavedBillsScreenState();
}

class _SavedBillsScreenState extends State<SavedBillsScreen> {
  List<BillModel> bills = [];

  @override
  void initState() {
    super.initState();
    refreshBills();
  }

  void refreshBills() {
    setState(() {
      bills = StorageService.getAllBills();
    });
  }

  void confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Delete Bill"),
        content: Text("Are you sure you want to delete this bill?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              await StorageService.deleteBill(id);
              Navigator.pop(context);
              refreshBills();
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }

  void showBillDetails(BillModel bill) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Bill Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer: ${bill.customerName}'),
              Text('Phone: ${bill.customerPhone}'),
              Text('Date: ${bill.date.toLocal().toString().split(' ')[0]}'),
              ...bill.goldItems.map((g) => Text(
                  '${g.desc}, ${g.weight}g, ${g.purity}%, ₹${g.loan}, ${g.duration}mo')),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Close")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bills.length,
      itemBuilder: (context, index) {
        final bill = bills[index];
        return ListTile(
          leading: Icon(Icons.receipt),
          title: Text(bill.customerName),
          subtitle: Text("₹${bill.goldItems.fold(0, (sum, item) => sum + int.tryParse(item.loan)!)}/-"),
          trailing: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'view') {
                showBillDetails(bill);
              } else if (value == 'print') {
                PdfService.generateAndPrintPDF(bill);
              } else if (value == 'delete') {
                confirmDelete(bill.id);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'view', child: Text('View')),
              PopupMenuItem(value: 'print', child: Text('Print')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        );
      },
    );
  }
}
