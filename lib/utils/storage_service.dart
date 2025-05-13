import 'package:hive/hive.dart';
import '../models/bill_model.dart';

class StorageService {
  static const String boxName = 'billsBox';

  static Future<void> initHive() async {
    Hive.registerAdapter(BillModelAdapter());
    Hive.registerAdapter(GoldItemAdapter());
    await Hive.openBox<BillModel>(boxName);
  }

  static Box<BillModel> getBox() => Hive.box<BillModel>(boxName);

  static Future<void> saveBill(BillModel bill) async {
    final box = getBox();
    await box.put(bill.id, bill);
  }

  static List<BillModel> getAllBills() {
    final box = getBox();
    return box.values.toList();
  }

  static BillModel? getBill(String id) {
    final box = getBox();
    return box.get(id);
  }

  static Future<void> deleteBill(String id) async {
    final box = getBox();
    await box.delete(id);
  }

  static Future<void> markRecovered(String id) async {
    final box = getBox();
    BillModel? bill = box.get(id);
    if (bill != null) {
      bill.recovered = true;
      await bill.save();
    }
  }
}
