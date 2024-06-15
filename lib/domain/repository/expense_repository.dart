import 'package:expense_tracker/data/model/transaction_entity.dart';
import 'package:flutter/widgets.dart';

abstract class ExpenseRepository {
  List<TransactionEntity> getAllexpense();
  void addExpense(String category, double amount, DateTime date);
  void updateExpense(BuildContext context, int id, String category,
      double amount, DateTime date);
  void delete(int id);
  // Future<Objectbox> createObject();
}
