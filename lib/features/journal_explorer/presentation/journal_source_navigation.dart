import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../customer_payments/data/customer_payments_repository_provider.dart';
import '../../sales_invoices/data/sales_invoices_repository_provider.dart';
import '../../vendor_bills/data/vendor_bills_repository_provider.dart';
import '../../vendor_payments/data/vendor_payments_repository_provider.dart';
import '../domain/journal_entry.dart';

Future<void> navigateToSourceDocument(
  BuildContext context,
  WidgetRef ref,
  JournalEntry entry,
) async {
  switch (entry.sourceDocumentType) {
    case 'purchase_order':
      context.go('/purchase-orders');
    case 'goods_receipt':
      context.go('/purchase-orders');
    case 'vendor_bill':
      final result = await ref
          .read(vendorBillsRepositoryProvider)
          .fetchVendorBills();
      if (!context.mounted || !result.isSuccess) {
        return;
      }
      final matches = (result.data ?? const []).where(
        (item) => item.id == entry.sourceDocumentId,
      );
      if (matches.isNotEmpty) {
        context.push('/vendor-bills/${matches.first.id}', extra: matches.first);
      }
    case 'vendor_payment':
      final result = await ref
          .read(vendorPaymentsRepositoryProvider)
          .fetchVendorPayments();
      if (!context.mounted || !result.isSuccess) {
        return;
      }
      final matches = (result.data ?? const []).where(
        (item) => item.id == entry.sourceDocumentId,
      );
      if (matches.isNotEmpty) {
        context.push(
          '/vendor-payments/${matches.first.id}',
          extra: matches.first,
        );
      }
    case 'sales_invoice':
      final result = await ref
          .read(salesInvoicesRepositoryProvider)
          .fetchSalesInvoices();
      if (!context.mounted || !result.isSuccess) {
        return;
      }
      final matches = (result.data ?? const []).where(
        (item) => item.id == entry.sourceDocumentId,
      );
      if (matches.isNotEmpty) {
        context.push(
          '/sales-invoices/${matches.first.id}',
          extra: matches.first,
        );
      }
    case 'customer_payment':
      final result = await ref
          .read(customerPaymentsRepositoryProvider)
          .fetchCustomerPayments();
      if (!context.mounted || !result.isSuccess) {
        return;
      }
      final matches = (result.data ?? const []).where(
        (item) => item.id == entry.sourceDocumentId,
      );
      if (matches.isNotEmpty) {
        context.push(
          '/customer-payments/${matches.first.id}',
          extra: matches.first,
        );
      }
  }
}
