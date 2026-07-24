import '../../../core/errors/app_result.dart';
import '../domain/models/roadmap_item.dart';

abstract class RoadmapRepository {
  Future<AppResult<List<RoadmapItem>>> fetchItems();
  Future<AppResult<RoadmapItem?>> getItemById(String id);
  Future<AppResult<void>> saveItem(RoadmapItem item);
  Future<AppResult<void>> deleteItem(String id);
}

class MockRoadmapRepository implements RoadmapRepository {
  final List<RoadmapItem> _items = [];

  @override
  Future<AppResult<List<RoadmapItem>>> fetchItems() async {
    return AppResult.success(List.unmodifiable(_items));
  }

  @override
  Future<AppResult<RoadmapItem?>> getItemById(String id) async {
    try {
      final item = _items.firstWhere((e) => e.id == id);
      return AppResult.success(item);
    } catch (_) {
      return AppResult.success(null);
    }
  }

  @override
  Future<AppResult<void>> saveItem(RoadmapItem item) async {
    final index = _items.indexWhere((e) => e.id == item.id);
    if (index >= 0) {
      _items[index] = item;
    } else {
      _items.add(item);
    }
    return AppResult.success(null);
  }

  @override
  Future<AppResult<void>> deleteItem(String id) async {
    _items.removeWhere((e) => e.id == id);
    return AppResult.success(null);
  }
}