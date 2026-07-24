enum EventPriority {
  low,
  medium,
  high,
  urgent;

  String get label {
    switch (this) {
      case EventPriority.low:
        return 'Low';
      case EventPriority.medium:
        return 'Medium';
      case EventPriority.high:
        return 'High';
      case EventPriority.urgent:
        return 'Urgent';
    }
  }

  int get sortOrder {
    switch (this) {
      case EventPriority.low:
        return 0;
      case EventPriority.medium:
        return 1;
      case EventPriority.high:
        return 2;
      case EventPriority.urgent:
        return 3;
    }
  }
}
