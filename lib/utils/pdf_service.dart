import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/bill_model.dart';

class PdfService {
  static Future<void> generateAndPrintPDF(BillModel bill) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Header(level: 0, text: 'Ranjith Pawn Shop - Bill'),
          pw.Text('Bill ID: ${bill.id}'),
          pw.Text('Date: ${bill.date.toLocal().toString().split(' ')[0]}'),
          pw.SizedBox(height: 10),
          pw.Text('Customer Name: ${bill.customerName}'),
          pw.Text('Phone: ${bill.customerPhone}'),
          pw.Text('Address: ${bill.customerAddress}'),
          pw.SizedBox(height: 10),
          pw.Text('Gold Items:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Table.fromTextArray(
            headers: ['Description', 'Weight', 'Purity', 'Loan', 'Interest', 'Duration'],
            data: bill.goldItems.map((item) => [
              item.desc,
              item.weight,
              item.purity,
              item.loan,
              item.interest,
              item.duration
            ]).toList(),
          ),
          pw.SizedBox(height: 20),
          pw.Text('Customer Sign: ____________________'),
          pw.Text('Shop Stamp: _______________________'),
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }
}
