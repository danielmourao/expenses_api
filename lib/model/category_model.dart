import '../dart_week_api.dart';

class CategoryModel extends ManagedObject< _CategoryModel> implements  _CategoryModel {}

enum CategoryType{
  receita,
  despesa
}

@Table(name: 'category')

class  _CategoryModel {

  @Column(primaryKey: true)
  int id;

  @Column()
  String name;

  @Column()
  CategoryType categoryType;

  ManagedSet<CategoryModel> transactions;
}