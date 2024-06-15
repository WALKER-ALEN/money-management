import 'package:expense_tracker/data/model/transaction_entity.dart';
import 'package:expense_tracker/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class Objectbox {
  late final Store store;
  late Box<TransactionEntity> expensebox;
  Objectbox._create(this.store) {
    expensebox = store.box<TransactionEntity>();
  }
  static Objectbox? _instance;
  static Objectbox get instance {
    return _instance!;
  }

  static Future<Objectbox> create() async {
    final expenseStore = await getApplicationDocumentsDirectory();
    final store = await openStore(
      directory: p.join(expenseStore.path, "expense tracker"),
    );
    final instance = Objectbox._create(store);
    _instance = instance;
    return instance;
  }
}
