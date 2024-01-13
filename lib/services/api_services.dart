// services/api_service.dart

import 'package:flutter/material.dart';

import '../models/customer.dart';


class ApiService {
  // In-memory list acting as a "database"
  final List<Customer> customers = [];

  // Method to add a customer
  void addCustomer(Customer customer) {
    customers.add(customer);
  }

  // Method to get the list of customers
  List<Customer> getCustomers() {
    return List.from(customers);
  }
}
