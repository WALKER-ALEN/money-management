import 'package:expense_tracker/presentation/providers/expense_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final totalExpenseProvider = Provider.autoDispose<double>((ref) {
  final expenses = ref.watch(expenseProvider);
  return expenses.fold(0, (sum, expense) => sum + expense.amount);
});
