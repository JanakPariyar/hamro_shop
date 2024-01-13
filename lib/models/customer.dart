import 'package:hive/hive.dart';

part 'customer.g.dart';

@HiveType(typeId: 1)
class Customer extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String email;

  @HiveField(2)
  late String phoneNumber;

  @HiveField(3)
  late String comment;

  // Link transactions to Hive
  @HiveField(4)
  late List<int> transactions;

  Customer({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.comment,
    List<int>? transactions,
  }) : this.transactions = transactions ?? [];
}
