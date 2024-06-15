// import 'package:expense_tracker/core/controller/text_controller.dart';
import 'package:expense_tracker/presentation/providers/calculation_provider.dart';

import 'package:expense_tracker/presentation/providers/expense_provider.dart';
import 'package:expense_tracker/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categorycontroller = TextEditingController();
    final amountcontroller = TextEditingController();
    final DateTime today = DateTime.now();

    // to cache the calculation, so that when ever ui rebuilds without effecting the state in the calculation
    // final total = useMemoized<double>(() {
    //   final expenses = ref.watch(expenseProvider);
    //   return expenses.fold(0, (sum, expense) => sum + expense.amount);
    // }, []);

    void add() {
      ref
          .read(expenseProvider.notifier)
          .addExpenses(categorycontroller.text, amountcontroller.text, today);
      // ref.invalidate(expenseProvider);
      Navigator.pop(context);
      showSnackBar(context);
    }

    void edit(int id) {
      ref.read(expenseProvider.notifier).updateExpenses(
          context, id, categorycontroller.text, amountcontroller.text, today);
      Navigator.pop(context);
    }

    void dialog([bool isEdit = false, int? id]) {
      if (!isEdit) {
        categorycontroller.clear();
        amountcontroller.clear();
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Expenses"),
            content: TextField(
              controller: amountcontroller,
              decoration: InputDecoration(
                  label: const Text("Enter a Amount"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            actions: [
              TextField(
                controller: categorycontroller,
                decoration: InputDecoration(
                    label: const Text("Spent For?"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                  FilledButton(
                      onPressed: () => isEdit ? edit(id!) : add(),
                      child: Text(isEdit ? "Edit Expenses" : "Add Expense"))
                ],
              )
            ],
          );
        },
      );
    }

    final provider = ref.watch(expenseProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
                final day = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now().subtract(const Duration(days: 3)),
                  lastDate: DateTime.now(),
                );
                print(day);
              },
              icon: const Icon(Icons.calendar_month_outlined)),
          backgroundColor: Colors.amberAccent,
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.search_rounded)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Expense Track',
            ),
            Tab(
              text: 'Total Expense',
            )
          ]),
        ),
        body: TabBarView(children: [
          Center(
              child: ListView.builder(
            itemCount: provider.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.attach_money),
                  ),
                  title: Text("${provider[index].amount}"),
                  subtitle:
                      Text(provider[index].category ?? "Something went wrong"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            categorycontroller.text = provider[index].category;
                            amountcontroller.text =
                                provider[index].amount.toString();
                            dialog(true, provider[index].id);
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            ref
                                .read(expenseProvider.notifier)
                                .deleteExpense(context, id: provider[index].id);
                            ref.invalidate(expenseProvider);
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                ),
              );
            },
          )),
          Center(
              child: ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(
                      "Total Expense is:${ref.watch(totalExpenseProvider)}"),
                  leading: const CircleAvatar(
                    child: Icon(Icons.money),
                  ),
                ),
              );
            },
          )),
        ]),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: 'Categories', icon: Icon(Icons.category))
        ]),
        
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              dialog();
            },
            label: const Icon(Icons.add)),
      ),
    );
  }
}
