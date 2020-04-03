import 'package:dart_week_api/model/category_model.dart';
import 'package:dart_week_api/services/category_service.dart';

import '../../dart_week_api.dart';

class CategoryController extends ResourceController {
  CategoryController(this.context) : service = CategoryService(context);
  final ManagedContext context;
  final CategoryService service;
  @Operation.get('type')
  Future<Response> findForTypeCategory() async {
    try {
      final type = request.path.variables['type'];
      final typeCategory = CategoryType.values.firstWhere((t) => t.toString().split('.').last == type);
      return service.findCategoryType(typeCategory)
      .then((res) => res.map((c) => {'id': c.id, 'name': c.name}).toList())
      .then((data) => Response.ok(data));
    } catch(e) {
      print(e);
      return Response.serverError(body: {'message': 'Erro na requisição', 'error': e.toString()});
    }
  }
}