/// Response from a notification permission request.
enum NotificationPermission { granted, denied, notDetermined }

/// Service for checking and requesting notification permissions.
///
/// Replace the stub implementation with a real one (e.g. flutter_local_notifications)
/// when packages are available.
class NotificationService {
  const NotificationService();

  Future<NotificationPermission> checkPermission() async {
    return NotificationPermission.notDetermined;
  }

  Future<bool> requestPermission() async {
    return true;
  }
}
