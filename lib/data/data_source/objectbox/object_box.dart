import 'package:expense_tracker/core/store.dart';
import 'package:expense_tracker/data/model/transaction_entity.dart';
import 'package:expense_tracker/domain/repository/expense_repository.dart';
import 'package:flutter/widgets.dart';

class ObjectBoxImpl implements ExpenseRepository {
  @override
  void addExpense(String category, double amount, DateTime date) {
    Objectbox.instance.expensebox
        .put(TransactionEntity(category: category, amount: amount, date: date));
  }

  @override
  void delete(int id) {
    Objectbox.instance.expensebox.remove(id);
  }

  @override
  List<TransactionEntity> getAllexpense() {
    return Objectbox.instance.expensebox.getAll();
  }

  @override
  void updateExpense(BuildContext context, int id, String category,
      double amount, DateTime date) {
    Objectbox.instance.expensebox
        .put(TransactionEntity(id: id,category: category, amount: amount, date: date));
  }
}
