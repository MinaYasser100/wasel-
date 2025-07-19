import 'package:wasel/core/helper_network/model/product_model.dart';

abstract class ProductRepo {
  Future<List<Product>> fetchProducts();
}
