import 'package:dart_week_api/model/category_model.dart';
import 'package:dart_week_api/model/user_model.dart';

import '../dart_week_api.dart';

class TransactionModel extends ManagedObject< _TransactionModel> implements  _TransactionModel {}

@Table(name: 'transaction')

class  _TransactionModel {

  @Column(primaryKey: true, autoincrement: true)
  int id;

  @Column()
  String description;

  @Column()
  DateTime transactionDate;

  @Column()
  double value;

  @Relate(#transactions)
  UserModel users;

  @Relate(#transactions)
  CategoryModel categories;


}