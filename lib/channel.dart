import 'package:dart_week_api/router/category_router.dart';
import 'package:dart_week_api/router/transactions_router.dart';
import 'package:dart_week_api/router/user_router.dart';

import 'dart_week_api.dart';
import 'package:dart_week_api/model/user_model.dart';
import 'package:dart_week_api/model/category_model.dart';
import 'package:dart_week_api/model/transactions_model.dart';

class DartWeekApiChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = DartWeekApiConfiguration(options.configurationFilePath);
    context = contextWithConnectionInfo(config.database);
  }

  @override
  Controller get entryPoint {
    final router = Router();
    UsersRouter.configure(router, context);
    CategoryRouter.configure(router, context);
    TransactionRouter.configure(router, context);
    return router;
  }

  ManagedContext contextWithConnectionInfo(DatabaseConfiguration connectionInfo) {
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final psc = PostgreSQLPersistentStore(connectionInfo.username, connectionInfo.password, connectionInfo.host,
        connectionInfo.port, connectionInfo.databaseName);

    return ManagedContext(dataModel, psc);
  }
}

class DartWeekApiConfiguration extends Configuration {
  DartWeekApiConfiguration(String fileName) : super.fromFile(File(fileName));

  DatabaseConfiguration database;
}
