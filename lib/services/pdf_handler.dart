// pdf_builder.dart

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:hive/hive.dart';

class PDFBuilder {
  static pw.Page buildTransactionPage(Box<Transaction> transactionBox) {
    return pw.Page(
      build: (pw.Context context) {
        return pw.Table(
          // ... (rest of the code remains the same)
        );
      },
    );
  }
}
