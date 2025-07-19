import 'package:hive_flutter/hive_flutter.dart';

class CartRepo {
  static const String boxName = 'cartBox';
  static Box<Map>? _box;

  static Future<Box<Map>> get box async {
    if (_box == null || !_box!.isOpen) {
      _box = await Hive.openBox<Map>(boxName);
    }
    return _box!;
  }

  static Future<void> addToCart(int productId, int quantity) async {
    final box = await CartRepo.box;
    box.put(productId.toString(), {
      'productId': productId,
      'quantity': quantity,
    });
  }

  static Future<void> updateQuantity(int productId, int quantity) async {
    final box = await CartRepo.box;
    if (quantity > 0) {
      box.put(productId.toString(), {
        'productId': productId,
        'quantity': quantity,
      });
    } else {
      box.delete(productId.toString());
    }
  }

  static Future<int> getQuantity(int productId) async {
    final box = await CartRepo.box;
    final item = box.get(productId.toString());
    return item?['quantity'] ?? 0;
  }

  static Future<void> clearCart() async {
    final box = await CartRepo.box;
    await box.clear();
  }
}
