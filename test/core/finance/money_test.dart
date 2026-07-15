import 'package:accounting_app/core/finance/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('money basic arithmetic and equality', () {
    const a = Money(100.0, currency: 'USD');
    const b = Money(50.0, currency: 'USD');
    final c = a + b;
    expect(c.amount, 150.0);
    final d = a - b;
    expect(d.amount, 50.0);
    expect(a == Money(100.0, currency: 'USD'), isTrue);
  });
}
