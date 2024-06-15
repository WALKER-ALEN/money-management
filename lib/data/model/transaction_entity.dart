
import 'package:objectbox/objectbox.dart';

@Entity()
class TransactionEntity {
  @Id()
  int id;
  String category;
  double amount;
  DateTime date;
  TransactionEntity(
      {this.id = 0,
      required this.category,
      required this.amount,
      required this.date});
}
