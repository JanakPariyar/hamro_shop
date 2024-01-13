import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  late DateTime date;

  @HiveField(1)
  late String itemName;

  @HiveField(2)
  late double itemQuantity;

  @HiveField(3)
  late double itemRate;

  @HiveField(4)
  late double? paidAmount; // Making paidAmount nullable


  @HiveField(6)
  late int customerId;



  Transaction({
    required this.date,
    required this.itemName,
    required this.itemQuantity,
    required this.itemRate,
    this.paidAmount,
    required this.customerId,

  });
}
