
import 'package:dart_week_api/controllers/transactions/dto/transactions_save.dart';
import 'package:dart_week_api/dart_week_api.dart';
import 'package:dart_week_api/model/category_model.dart';
import 'package:dart_week_api/model/transactions_model.dart';
import 'package:dart_week_api/model/user_model.dart';
import 'package:dart_week_api/repository/category_repository.dart';
import 'package:intl/intl.dart';

class TransactionsRepository {
  TransactionsRepository(this.context) : categoryRepository = CategoryRepository(context);

  final ManagedContext context;
  final CategoryRepository categoryRepository;

  Future<List<TransactionModel>> findAllTransactions(UserModel user, String yearMonth) {
    final DateFormat format = DateFormat('yyyy_MM_DD');
    final start = format.parse('${yearMonth.substring(0,4)}_${yearMonth.substring(4)}_01');
    final end = format.parse('${yearMonth.substring(0,4)}_${yearMonth.substring(4)}_31');

    final query = Query<TransactionModel>(context)
    ..join(object: (m) => m.categories)
    ..where((m) => m.users.id).equalTo(user.id)
    ..where((m) => m.transactionDate).between(start, end)
    ..sortBy((m) => m.transactionDate, QuerySortOrder.descending)
    ..sortBy((m) => m.id, QuerySortOrder.descending);

    return query.fetch();
  }

  Future<Map<String, dynamic>> getTotalMonth(UserModel user, String yearMonth, CategoryType typeCategory) async {
    final DateFormat format = DateFormat('yyyy_MM_DD');
    final start = format.parse('${yearMonth.substring(0,4)}_${yearMonth.substring(4)}_01');
    final end = format.parse('${yearMonth.substring(0,4)}_${yearMonth.substring(4)}_31');

    final query = Query<TransactionModel>(context)
    ..join(object: (m) => m.categories)
    ..where((m) => m.users.id).equalTo(user.id)
    ..where((m) => m.transactionDate).between(start, end)
    ..where((m) => m.categories.categoryType).equalTo(typeCategory);

    final List<TransactionModel> result = await query.fetch();
    final num total = result.fold(0.0, (total, m) => total += m.value);

    return {'tipo': typeCategory.toString(), 'total': total};
  }

  Future<void> saveTransaction (UserModel user, TransactionsSave request) async {
    final category = await categoryRepository.findById(request.category);
    final model = TransactionModel();
    model.categories = category;
    model.transactionDate = request.dateTransaction;
    model.description = request.description;
    model.users = user;
    model.value = request.value;

    await context.insertObject(model);
  }
}