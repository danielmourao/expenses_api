

import 'package:dart_week_api/config/jwt_authentication.dart';
import 'package:dart_week_api/controllers/transactions/transactions_controller.dart';
import 'package:dart_week_api/dart_week_api.dart';

class TransactionRouter {
  static void configure(Router router, ManagedContext context){
    router
      .route('/transactions/:yearMonth')
      .link(() => JwtAuth(context))
      .link(() => TransactionsController(context));
    
    router
      .route('/transactions/total/:totalMonth')
      .link(() => JwtAuth(context))
      .link(() => TransactionsController(context));

    router
      .route('/transactions/')
      .link(() => JwtAuth(context))
      .link(() => TransactionsController(context));
  }
}