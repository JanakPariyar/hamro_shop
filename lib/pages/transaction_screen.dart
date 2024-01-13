import 'package:flutter/material.dart';
import 'package:hamropasal/pages/pay_dialog_screen.dart';
import 'package:hamropasal/pages/payment_edit_dialog.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../models/customer.dart';
import '../models/transaction.dart';
import '../reusable_widgets/data_colmun.dart';
import '../reusable_widgets/hero_container.dart';
import 'addItemdialog_screen.dart';
import 'editi_item_dialog.dart';

class TransactionPage extends StatefulWidget {
  final Customer customer;

  TransactionPage({required this.customer});

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late Box<Transaction> transactionBox;

  @override
  void initState() {
    super.initState();
    transactionBox = Hive.box<Transaction>('transactions');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.orange[200],
        title: Text('Transaction History - ${widget.customer.name}'),
      ),
      body: _buildTransactionList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[300],
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (context) => AddItemDialog(),
          );

          if (result != null) {
            final newTransaction = Transaction(
              date: DateTime.now(),
              itemName: result['itemName'] ?? '',
              itemQuantity: double.tryParse(result['quantity'] ?? '0.0') ?? 0.0,
              itemRate: double.tryParse(result['rate'] ?? '0.0') ?? 0.0,
              customerId: widget.customer.key as int,
              paidAmount: double.tryParse(result['pay'] ?? '0.0') ?? 0.0,
            );

            transactionBox.add(newTransaction);
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 70,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(42.0),
                border: Border.all(color: Colors.black12, width: 1.0),
              ),
              child: Center(
                child: InkWell(
                  onTap: () async {
                    final result = await showDialog(
                      context: context,
                      builder: (context) => PayItemDialog(),
                    );

                    if (result != null) {
                      final newTransaction = Transaction(
                        date: DateTime.now(),
                        itemName: result['itemName'] ?? '',
                        itemQuantity: double.tryParse(result['quantity'] ?? '0.0') ?? 0.0,
                        itemRate: double.tryParse(result['rate'] ?? '0.0') ?? 0.0,
                        customerId: widget.customer.key as int,
                        paidAmount: double.tryParse(result['pay'] ?? '0.0') ?? 0.0,
                      );

                      transactionBox.add(newTransaction);
                      setState(() {});
                    }
                  },
                  child: Text(
                    'Pay',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                // Add your dummy search functionality here
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    List<Transaction> transactions = transactionBox.values
        .where((transaction) => transaction.customerId == widget.customer.key)
        .toList();

    double totalAmount = 0.0;
    double totalPaidAmount = 0.0;
    double grandTotal = 0;

    // Calculate the total amount
    for (var transaction in transactions) {
      grandTotal += (transaction.itemRate * transaction.itemQuantity);
      totalAmount += (transaction.itemRate * transaction.itemQuantity) - (transaction.paidAmount ?? 0.0);
      if (transaction.paidAmount != 0.0) {
        totalPaidAmount += transaction.paidAmount!;
      }
    }

    // Reverse the order of transactions
    transactions = transactions.reversed.toList();

    List<DataRow> dataRows = transactions.map((Transaction transaction) {
      String formattedDate = DateFormat('MM-dd').format(transaction.date);

      return DataRow(
        selected: false,
        onLongPress: () async {
          if (transaction.paidAmount != 0.0) {
            // Show the PaymentEditDialog
            final editResult = await showDialog(
              context: context,
              builder: (context) => PaymentEditDialog(
                initialItemName: transaction.itemName,
                initialPaidAmount: transaction.paidAmount??0.0,
                transactionBox: transactionBox,
                initialTransaction: transaction,
              ),
            );

            if (editResult != null) {
              // Handle the result from PaymentEditDialog
              // Update the transaction with edited values if needed
              // ...
              transaction.itemName = editResult['itemName'] ?? transaction.itemName;
              transaction.paidAmount = double.tryParse(editResult['paidAmount'] ?? transaction.paidAmount.toString()) ?? 0.0;

              transaction.save();
              setState(() {});
            }
          } else {
            // Show the regular edit dialog
            final editResult = await showDialog(
              context: context,
              builder: (context) =>
                  EditItemDialog(
                    initialItemName: transaction.itemName,
                    initialQuantity: transaction.itemQuantity,
                    initialRate: transaction.itemRate,
                    initialPaidAmount: transaction.paidAmount ?? 0.0,
                    initialTransaction: transaction,
                    transactionBox: transactionBox,
                  ),
            );

            if (editResult != null) {
              // Update the transaction with edited values
              transaction.itemName = editResult['itemName'] ?? transaction.itemName;
              transaction.itemQuantity = double.tryParse(editResult['quantity'] ?? transaction.itemQuantity.toString()) ?? transaction.itemQuantity;
              transaction.itemRate = double.tryParse(editResult['rate'] ?? transaction.itemRate.toString()) ?? transaction.itemRate;
              transaction.paidAmount = double.tryParse(editResult['paidAmount'] ?? transaction.paidAmount.toString()) ?? 0.0;

              // Save the updated transaction
              transaction.save();
              setState(() {});
            }
          }
        },


        cells: [
          dataCell(transaction, formattedDate),
          dataCell(transaction, transaction.itemName),
          DataCell(
            Text(
              '${transaction.itemRate * transaction.itemQuantity}',
              style: TextStyle(
                color: transaction.paidAmount != 0.0 ? Colors.green : Colors.black,
                fontSize: 16.0,
                fontWeight: transaction.paidAmount != 0.0 ? FontWeight.w700 : FontWeight.normal,
              ),
            ),
          ),
          DataCell(
            Text(
              '${transaction.paidAmount != null && transaction.paidAmount != 0.0 ? transaction.paidAmount! : ''}',
              style: TextStyle(
                color: transaction.paidAmount != 0.0 ? Colors.green : Colors.black,
                fontSize: 16.0,
                fontWeight: transaction.paidAmount != 0.0 ? FontWeight.w700 : FontWeight.normal,
              ),
            ),
          ),
        ],
      );
    }).toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.orange[50],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  container(grandTotal, 'Grand Total', Colors.yellowAccent[100]!),
                  container(totalPaidAmount, 'Paid', Colors.green[100]!),
                  container(totalAmount, 'total', Colors.red[100]!),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  dataColumn('Date'),
                  dataColumn('Item'),
                  dataColumn('Total'),
                  dataColumn('Paid')
                ],
                rows: dataRows,
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataCell dataCell(Transaction transaction, String ColumnName) {
    return DataCell(
      Text(
        '$ColumnName',
        style: TextStyle(
          color: transaction.paidAmount != 0.0 ? Colors.green : Colors.black,
          fontSize: 16.0,
          fontWeight: transaction.paidAmount != 0.0 ? FontWeight.w700 : FontWeight.normal,
        ),
      ),
    );
  }
}
