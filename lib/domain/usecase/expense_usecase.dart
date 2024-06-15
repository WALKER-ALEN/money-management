import 'package:expense_tracker/data/model/transaction_entity.dart';
import 'package:expense_tracker/domain/repository/expense_repository.dart';

class GetExpense {
  late final ExpenseRepository repository;
  GetExpense(this.repository);
  List<TransactionEntity> call() {
    return  repository.getAllexpense();
  }
}
