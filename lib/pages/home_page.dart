import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/customer.dart';
import '../pages/transaction_screen.dart';
import 'add_customer_dialog.dart';
import 'edit_customer_dialog_alert_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box<Customer> customerBox;

  @override
  void initState() {
    super.initState();
    customerBox = Hive.box<Customer>('customers');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text('Customer Management'),
        centerTitle: true,
        backgroundColor: Colors.orange[200],
      ),
      body: _buildCustomerList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[300],
        onPressed: () {
          _showAddCustomerDialog(context);
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
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerList() {
    List<Customer> customers = customerBox.values.toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (customers.isEmpty) const Text('No customers yet.'),
          for (Customer customer in customers)
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 2.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Card(
                    elevation: 0.0,
                    color: Colors.white54,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      onLongPress: () {
                        _showEditCustomerDialog(context, customer);
                      },
                      title: Text(
                        customer.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      ),
                      subtitle: Text(customer.phoneNumber),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TransactionPage(customer: customer),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _showAddCustomerDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AddCustomerDialog(
          onAddCustomer: (name, email, phoneNumber, comment) {
            _addCustomer(name, email, phoneNumber, comment);
          },
        );
      },
    );
  }

  void _addCustomer(
      String name, String email, String phoneNumber, String comment) {
    final newCustomer = Customer(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      comment: comment,
    );

    // Save the customer to Hive
    customerBox.add(newCustomer);

    setState(() {});
  }

  Future<void> _showEditCustomerDialog(
      BuildContext context, Customer customer) async {
    final result = await showDialog<dynamic>(
      context: context,
      builder: (context) => EditCustomerDialog(
        initialName: customer.name,
        initialEmail: customer.email,
        initialPhoneNumber: customer.phoneNumber,
        initialComment: customer.comment,
      ),
    );

    if (result != null) {
      if (result is Map<String, String>) {
        // Handle the edited details
        final editedCustomer = Customer(
          name: result['name'] ?? customer.name,
          email: result['email'] ?? customer.email,
          phoneNumber: result['phoneNumber'] ?? customer.phoneNumber,
          comment: result['comment'] ?? customer.comment,
        );

        // Update the customer in Hive
        customerBox.put(customer.key, editedCustomer);
        setState(() {});
      } else if (result is String && result == 'delete') {
        // Handle deletion
        _deleteCustomer(customer);
      }
    }
  }

  void _deleteCustomer(Customer customer) {
    // Handle deletion logic here, e.g., remove the customer from Hive
    customerBox.delete(customer.key);
    setState(() {});
  }
}
