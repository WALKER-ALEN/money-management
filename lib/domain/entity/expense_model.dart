class TransactionEntity {
  int id;
  String category;
  double amount;
  DateTime date;
  TransactionEntity(
      {required this.id,
      required this.category,
      required this.amount,
      required this.date});
}
