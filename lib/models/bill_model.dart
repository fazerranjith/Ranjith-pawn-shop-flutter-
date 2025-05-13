import 'package:hive/hive.dart';

part 'bill_model.g.dart';

@HiveType(typeId: 0)
class BillModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String customerName;

  @HiveField(2)
  String customerPhone;

  @HiveField(3)
  String customerAddress;

  @HiveField(4)
  String? customerPhotoPath;

  @HiveField(5)
  String? customerIdPath;

  @HiveField(6)
  String? goldPhotoPath;

  @HiveField(7)
  List<GoldItem> goldItems;

  @HiveField(8)
  bool recovered;

  @HiveField(9)
  DateTime date;

  BillModel({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    this.customerPhotoPath,
    this.customerIdPath,
    this.goldPhotoPath,
    required this.goldItems,
    required this.recovered,
    required this.date,
  });
}

@HiveType(typeId: 1)
class GoldItem {
  @HiveField(0)
  String desc;

  @HiveField(1)
  String weight;

  @HiveField(2)
  String purity;

  @HiveField(3)
  String loan;

  @HiveField(4)
  String interest;

  @HiveField(5)
  String duration;

  GoldItem({
    required this.desc,
    required this.weight,
    required this.purity,
    required this.loan,
    required this.interest,
    required this.duration,
  });
}
