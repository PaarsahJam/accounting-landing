import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../domain/goods_receipt.dart';
import '../domain/goods_receipts_controller.dart';

class GoodsReceiptsPage extends ConsumerWidget {
  const GoodsReceiptsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncReceipts = ref.watch(goodsReceiptsControllerProvider);

    return ResponsivePageScaffold(
      title: 'Goods Receipts',
      child: asyncReceipts.when(
        loading: () => const AppLoadingState(),
        error: (error, _) => AppErrorState(message: '$error'),
        data: (receipts) {
          if (receipts.isEmpty) {
            return const AppEmptyState(
              title: 'No goods receipts',
              message: 'Goods receipts appear when purchase orders are received.',
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(goodsReceiptsControllerProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: receipts.length,
              itemBuilder: (context, index) => _GoodsReceiptCard(
                receipt: receipts[index],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _GoodsReceiptCard extends StatelessWidget {
  const _GoodsReceiptCard({required this.receipt});

  final GoodsReceipt receipt;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(receipt.title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text('Ref: ${receipt.reference}', style: theme.textTheme.bodySmall),
            const SizedBox(height: 8),
            Text('Status: ${receipt.status.label}'),
            Text('Received: ${receipt.receivedAt.toLocal()}'),
            const SizedBox(height: 8),
            Text('${receipt.lines.length} line(s)'),
          ],
        ),
      ),
    );
  }
}
