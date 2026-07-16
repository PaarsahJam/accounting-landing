import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/inventory_controller.dart';
import '../domain/product.dart';
import '../domain/product_category.dart';
import 'product_stock_detail_page.dart';
import 'warehouse_management_page.dart';

class InventoryPage extends ConsumerStatefulWidget {
  const InventoryPage({super.key});

  @override
  ConsumerState<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends ConsumerState<InventoryPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  String _selectedCategoryId = '';
  String _selectedUnitId = '';
  String _search = '';
  String _categoryFilter = 'all';
  bool _active = true;
  List<ProductCategory> _categories = const [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final controller = ref.read(inventoryControllerProvider.notifier);
    final categories = await controller.fetchCategories();
    if (!mounted) return;
    setState(() => _categories = categories);
  }

  @override
  void dispose() {
    _skuController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  Future<void> _submitProduct({Product? existingProduct}) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final controller = ref.read(inventoryControllerProvider.notifier);
    final product =
        (existingProduct ??
                const Product(
                  id: '',
                  sku: '',
                  name: '',
                  description: '',
                  categoryId: '',
                  unitId: '',
                  price: 0,
                  stockOnHand: 0,
                  active: true,
                ))
            .copyWith(
              id:
                  existingProduct?.id ??
                  'P-${DateTime.now().millisecondsSinceEpoch}',
              sku: _skuController.text.trim(),
              name: _nameController.text.trim(),
              description: _descriptionController.text.trim(),
              categoryId: _selectedCategoryId,
              unitId: _selectedUnitId,
              price: double.tryParse(_priceController.text.trim()) ?? 0,
              stockOnHand: double.tryParse(_stockController.text.trim()) ?? 0,
              active: _active,
            );

    if (existingProduct == null) {
      await controller.createProduct(product);
    } else {
      await controller.updateProduct(product);
    }

    if (!mounted) return;
    Navigator.of(context).pop();
    await controller.refresh();
  }

  Future<void> _showProductDialog({Product? product}) async {
    final l10n = AppLocalizations.of(context)!;
    final controller = ref.read(inventoryControllerProvider.notifier);
    final categories = await controller.fetchCategories();
    final units = await controller.fetchUnits();

    if (product != null) {
      _skuController.text = product.sku;
      _nameController.text = product.name;
      _descriptionController.text = product.description;
      _priceController.text = product.price.toString();
      _stockController.text = product.stockOnHand.toString();
      _selectedCategoryId = product.categoryId;
      _selectedUnitId = product.unitId;
      _active = product.active;
    } else {
      _skuController.clear();
      _nameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      _stockController.clear();
      _selectedCategoryId = categories.isNotEmpty ? categories.first.id : '';
      _selectedUnitId = units.isNotEmpty ? units.first.id : '';
      _active = true;
    }

    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            product == null
                ? l10n.inventoryAddProduct
                : l10n.inventoryEditProduct,
          ),
          content: SizedBox(
            width: 480,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _skuController,
                      decoration: InputDecoration(labelText: l10n.inventorySku),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: l10n.inventoryName,
                      ),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: l10n.inventoryDescription,
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue:
                          _selectedCategoryId.isEmpty && categories.isNotEmpty
                          ? categories.first.id
                          : _selectedCategoryId,
                      decoration: InputDecoration(
                        labelText: l10n.inventoryCategory,
                      ),
                      items: categories
                          .map(
                            (category) => DropdownMenuItem(
                              value: category.id,
                              child: Text(category.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => _selectedCategoryId = value ?? ''),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedUnitId.isEmpty && units.isNotEmpty
                          ? units.first.id
                          : _selectedUnitId,
                      decoration: InputDecoration(
                        labelText: l10n.inventoryUnit,
                      ),
                      items: units
                          .map(
                            (unit) => DropdownMenuItem(
                              value: unit.id,
                              child: Text(unit.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => _selectedUnitId = value ?? ''),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        labelText: l10n.inventoryPrice,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _stockController,
                      decoration: InputDecoration(
                        labelText: l10n.inventoryStockOnHand,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      value: _active,
                      onChanged: (value) => setState(() => _active = value),
                      title: Text(l10n.inventoryActive),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.invoiceCancel),
            ),
            FilledButton(
              onPressed: () => _submitProduct(existingProduct: product),
              child: Text(
                product == null ? l10n.inventoryCreate : l10n.inventorySave,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final productsAsync = ref.watch(inventoryControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.inventoryPageTitle),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const WarehouseManagementPage(),
              ),
            ),
            icon: const Icon(Icons.warehouse),
            tooltip: l10n.inventoryWarehousesTitle,
          ),
          IconButton(
            onPressed: () => _showProductDialog(),
            icon: const Icon(Icons.add_circle_outline),
            tooltip: l10n.inventoryAddProduct,
          ),
        ],
      ),
      body: productsAsync.when(
        loading: () => const AppLoadingState(message: 'Loading inventory'),
        error: (error, stackTrace) =>
            AppErrorState(message: '${l10n.inventoryLoadError} $error'),
        data: (products) {
          final filteredProducts = products.where((product) {
            final query = _search.toLowerCase();
            final matchesSearch =
                query.isEmpty ||
                product.name.toLowerCase().contains(query) ||
                product.sku.toLowerCase().contains(query);
            final matchesCategory =
                _categoryFilter == 'all' ||
                product.categoryId == _categoryFilter;
            return matchesSearch && matchesCategory;
          }).toList();

          if (filteredProducts.isEmpty) {
            return AppEmptyState(
              title: l10n.inventoryEmptyTitle,
              message: l10n.inventoryEmptyMessage,
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: l10n.inventorySearchHint,
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() => _search = value),
                ),
              ),
              if (_categories.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButtonFormField<String>(
                    initialValue: _categoryFilter,
                    decoration: InputDecoration(
                      labelText: l10n.inventoryCategoryFilter,
                    ),
                    items:
                        [
                              DropdownMenuItem(
                                value: 'all',
                                child: Text(l10n.inventoryAllCategories),
                              ),
                            ]
                            .followedBy(
                              _categories
                                  .map(
                                    (category) => DropdownMenuItem(
                                      value: category.id,
                                      child: Text(category.name),
                                    ),
                                  )
                                  .toList(),
                            )
                            .toList(),
                    onChanged: (value) =>
                        setState(() => _categoryFilter = value ?? 'all'),
                  ),
                ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredProducts.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return Card(
                      child: ListTile(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (context) =>
                                ProductStockDetailPage(product: product),
                          ),
                        ),
                        title: Text(product.name),
                        subtitle: Text(
                          '${product.sku} • ${product.description}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () =>
                                  _showProductDialog(product: product),
                              icon: const Icon(Icons.edit),
                              tooltip: l10n.inventoryEditProduct,
                            ),
                            IconButton(
                              onPressed: () async {
                                await ref
                                    .read(inventoryControllerProvider.notifier)
                                    .deleteProduct(product.id);
                              },
                              icon: const Icon(Icons.delete),
                              tooltip: l10n.inventoryDeleteProduct,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
