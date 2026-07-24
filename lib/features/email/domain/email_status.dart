/// Tracks the lifecycle of an outbound email.
enum EmailStatus {
  /// Queued for delivery but not yet dispatched to the provider.
  queued,

  /// Successfully handed off to the email provider.
  sent,

  /// The provider rejected or failed to deliver the message.
  failed,
}
