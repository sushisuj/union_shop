import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/cart_state.dart';

void main() {
  group('CartState', () {
    late CartState cartState;

    setUp(() {
      cartState = CartState();
    });

    test('should start with an empty cart', () {
      expect(cartState.items.value, isEmpty);
    });

    test('should add an item to the cart', () {
      final item = CartItem(
        title: 'Test Product',
        size: 'M',
        price: '£10.00',
        quantity: 1,
      );
      cartState.addItem(item);
      expect(cartState.items.value.length, 1);
      expect(cartState.items.value.first.title, 'Test Product');
    });

    test('should increment quantity of an item', () {
      final item = CartItem(
        title: 'Test Product',
        size: 'M',
        price: '£10.00',
        quantity: 1,
      );
      cartState.addItem(item);
      cartState.incrementQuantity(0);
      expect(cartState.items.value.first.quantity, 2);
    });

    test('should decrement quantity and remove item when quantity is zero', () {
      final item = CartItem(
        title: 'Test Product',
        size: 'M',
        price: '£10.00',
        quantity: 1,
      );
      cartState.addItem(item);
      cartState.decrementQuantity(0);
      expect(cartState.items.value, isEmpty);
    });

    test('should clear the cart by decrementing all items', () {
      final item1 = CartItem(
        title: 'Test Product 1',
        size: 'M',
        price: '£10.00',
        quantity: 1,
      );
      final item2 = CartItem(
        title: 'Test Product 2',
        size: 'L',
        price: '£12.00',
        quantity: 1,
      );
      cartState.addItem(item1);
      cartState.addItem(item2);
      cartState.decrementQuantity(1);
      cartState.decrementQuantity(0);
      expect(cartState.items.value, isEmpty);
    });
  });
}
