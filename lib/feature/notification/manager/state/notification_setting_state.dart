// manager/state/notification_settings_state.dart

abstract class NotificationSettingsState {}

class NotificationSettingsInitial extends NotificationSettingsState {}

class NotificationSettingsLoading extends NotificationSettingsState {}

class NotificationSettingsLoaded extends NotificationSettingsState {
  final bool maintenance;
  final bool offers;
  final bool ai;
  final bool emergency;

  NotificationSettingsLoaded({
    required this.maintenance,
    required this.offers,
    required this.ai,
    required this.emergency,
  });
}

class NotificationSettingsError extends NotificationSettingsState {
  final String message;
  NotificationSettingsError(this.message);
}