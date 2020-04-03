import 'package:dart_week_api/controllers/transactions/dto/transactions_save.dart';
import 'package:dart_week_api/model/category_model.dart';
import 'package:dart_week_api/model/user_model.dart';
import 'package:dart_week_api/services/transactions_service.dart';

import '../../dart_week_api.dart';
import 'package:intl/intl.dart';

class TransactionsController extends ResourceController {

  TransactionsController(this.context) : service = TransactionService(context);
  final TransactionService service;
  final ManagedContext context;

  @Operation.get('yearMonth')
  Future<Response> findAllTransactions() {
    final yearMonth = request.path.variables['yearMonth'];
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final UserModel user = request.attachments['user'] as UserModel;
    return service.findAllTransactions(user, yearMonth).then((data) {
      return data.map((m) => {
        'id': m.id,
        'transactionDate': dateFormat.format(m.transactionDate),
        'description': m.description,
        'value': m.value,
        'category': {'id': m.categories.id, 'name': m.categories.name, 'type': m.categories.categoryType.toString()}
      }).toList();
    }).then((list) => Response.ok(list));
  }

  @Operation.get('totalMonth')
  Future<Response> getTotalMonth(@Bind.path('totalMonth') String yearMonth) async {
    final user = request.attachments['user'] as UserModel;
    final result = await service.getTotalTransactionsType(user, yearMonth);
    return Response.ok(result);
  }

  @Operation.post()
  Future<Response> saveTransactions(@Bind.body() TransactionsSave requestSave) async {
    try {
      final validate = requestSave.validate();
      if(validate.isNotEmpty) {
        return Response.badRequest(body: validate);
      }

      final user = request.attachments['user'] as UserModel;
      await service.saveTransaction(user, requestSave);
      return Response.ok({});
    } catch(e) {
      return Response.serverError(body: {'message': 'Erro ao salvar movimentação.'});
    }
  }
}