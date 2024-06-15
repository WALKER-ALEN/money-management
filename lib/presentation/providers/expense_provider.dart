import 'package:expense_tracker/data/data_source/objectbox/object_box.dart';
import 'package:expense_tracker/data/model/transaction_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_provider.g.dart';

@riverpod
class Expense extends _$Expense {
  @override
  List<TransactionEntity> build() {
    final data = ObjectBoxImpl().getAllexpense();

    print(data.length);

    return data;
  }

  void addExpenses(
    String category,
    String amount,
    DateTime date,
  ) {
    if (amount.isNotEmpty || double.tryParse(amount) != null) {
      ObjectBoxImpl().addExpense(category, double.tryParse(amount)!, date);
      state = ObjectBoxImpl().getAllexpense();
    }
  }

  void deleteExpense(BuildContext context, {required int id}) {
    ObjectBoxImpl().delete(id);
  }

  void updateExpenses(BuildContext context, int id, String category,
      String amount, DateTime date) {
    if (amount.isNotEmpty || double.tryParse(amount) != null) {
      ObjectBoxImpl()
          .updateExpense(context, id, category, double.tryParse(amount)!, date);
      state = ObjectBoxImpl().getAllexpense();
    }
  }
}
