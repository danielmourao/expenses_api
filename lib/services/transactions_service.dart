import 'dart:math';

import 'package:dart_week_api/controllers/transactions/dto/transactions_save.dart';
import 'package:dart_week_api/dart_week_api.dart';
import 'package:dart_week_api/model/category_model.dart';
import 'package:dart_week_api/model/transactions_model.dart';
import 'package:dart_week_api/model/user_model.dart';
import 'package:dart_week_api/repository/transactions_repository.dart';

class TransactionService {
  TransactionService(this.context) : repository = TransactionsRepository(context);
  final ManagedContext context;
  final TransactionsRepository repository;

  Future<List<TransactionModel>> findAllTransactions(UserModel user, String yearMonth) {
    return repository.findAllTransactions(user, yearMonth);
  }

  Future<Map<String, dynamic>> getTotalTransactionsType(UserModel user, String yearMonth) async {
    final incomes = await repository.getTotalMonth(user, yearMonth, CategoryType.receita);
    final expenses = await repository.getTotalMonth(user, yearMonth, CategoryType.despesa);

    return {
      'incomes': incomes, 
      'expenses': expenses, 
      'total': (incomes['total'] ?? 0) + (expenses['total'] ?? 0),
      'balance': (incomes['total'] ?? 0) + (expenses['total'] * -1 ?? 0)
    };
  }

  Future<void> saveTransaction(UserModel user, TransactionsSave request) async {
    await repository.saveTransaction(user, request);
  }
}