// test/features/document_numbering/document_number_generator_test.dart

import 'package:accounting_app/features/document_numbering/document_number_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DocumentNumberGenerator', () {
    test('generates number with default 6-digit padding', () {
      const gen = DocumentNumberGenerator(
        prefix: 'PO',
        fiscalYear: 2026,
        runningSequence: 1,
      );
      expect(gen.generateDocumentNumber(), 'PO-2026-000001');
    });

    test('generates number with custom padding length', () {
      const gen = DocumentNumberGenerator(
        prefix: 'PO',
        fiscalYear: 2026,
        runningSequence: 1,
        paddingLength: 5,
      );
      expect(gen.generateDocumentNumber(), 'PO-2026-00001');
    });

    test('toString returns the formatted document number', () {
      const gen = DocumentNumberGenerator(
        prefix: 'SI',
        fiscalYear: 2026,
        runningSequence: 42,
      );
      expect(gen.toString(), 'SI-2026-000042');
    });

    test('next() increments the running sequence', () {
      const gen = DocumentNumberGenerator(
        prefix: 'VB',
        fiscalYear: 2026,
        runningSequence: 99,
      );
      expect(gen.next().generateDocumentNumber(), 'VB-2026-000100');
    });

    group('DocumentPrefix constants', () {
      test(
        'purchaseOrder is PO',
        () => expect(DocumentPrefix.purchaseOrder, 'PO'),
      );
      test(
        'goodsReceipt is GR',
        () => expect(DocumentPrefix.goodsReceipt, 'GR'),
      );
      test('vendorBill is VB', () => expect(DocumentPrefix.vendorBill, 'VB'));
      test(
        'vendorPayment is VP',
        () => expect(DocumentPrefix.vendorPayment, 'VP'),
      );
      test(
        'salesInvoice is SI',
        () => expect(DocumentPrefix.salesInvoice, 'SI'),
      );
      test(
        'customerPayment is CP',
        () => expect(DocumentPrefix.customerPayment, 'CP'),
      );
      test(
        'journalVoucher is JV',
        () => expect(DocumentPrefix.journalVoucher, 'JV'),
      );
    });
  });
}
