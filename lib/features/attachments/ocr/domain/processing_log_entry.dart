enum ProcessingLogSeverity { info, warning, error }

class ProcessingLogEntry {
  const ProcessingLogEntry({
    required this.timestamp,
    required this.step,
    required this.message,
    this.severity = ProcessingLogSeverity.info,
    this.details,
  });

  final DateTime timestamp;
  final String step;
  final String message;
  final ProcessingLogSeverity severity;
  final Map<String, dynamic>? details;

  String get formattedTimestamp =>
      '${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-'
      '${timestamp.day.toString().padLeft(2, '0')} '
      '${timestamp.hour.toString().padLeft(2, '0')}:'
      '${timestamp.minute.toString().padLeft(2, '0')}:'
      '${timestamp.second.toString().padLeft(2, '0')}';
}
