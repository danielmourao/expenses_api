import 'package:dart_week_api/model/transactions_model.dart';

import '../dart_week_api.dart';

class UserModel extends ManagedObject<_UserModel> implements _UserModel {}

@Table(name: 'userlogin')

class  _UserModel {
  
  @Column(primaryKey: true, autoincrement: true)
  int id;

  @Column(unique: true)
  String username;
  
  @Column()
  String password;

  ManagedSet<TransactionModel> transactions;

}