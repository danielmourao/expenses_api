import 'package:dart_week_api/dart_week_api.dart';
import 'package:dart_week_api/model/category_model.dart';

class CategoryRepository {
  CategoryRepository(this.context);

  final ManagedContext context;

  Future<List<CategoryModel>> findCategoryType(CategoryType typeCategory) {
    final query = Query<CategoryModel>(context)
    ..where((c) => c.categoryType).equalTo(typeCategory);
    return query.fetch();
  }

  Future<CategoryModel> findById(int id) {
    final query = Query<CategoryModel>(context)
    ..where((c) => c.id).equalTo(id);
    return query.fetchOne();
  }
}