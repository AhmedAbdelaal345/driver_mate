// manager/cubit/notification_settings_cubit.dart
import 'package:driver_mate/core/service/work_manger_service.dart';
import 'package:driver_mate/feature/notification/data/repo/notification_setting_repo.dart';
import 'package:driver_mate/feature/notification/manager/state/notification_setting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  final NotificationSettingsRepo repo;

  NotificationSettingsCubit(this.repo) : super(NotificationSettingsInitial());

  Future<void> loadSettings() async {
    emit(NotificationSettingsLoading());

    try {
      final data = await repo.getSettings();

      emit(
        NotificationSettingsLoaded(
          maintenance: data["maintenance"]!,
          offers: data["offers"]!,
          ai: data["ai"]!,
          emergency: data["emergency"]!,
        ),
      );
    } catch (e) {
      emit(NotificationSettingsError(e.toString()));
    }
  }

  Future<void> toggleMaintenance(bool value) async {
    await repo.updateSetting("maintenance", value);

    if (value) {
      WorkManagerService().registerOnetask(
        uniqueName: "maintenanceTask",
        taskName: "maintenanceReminder",
        duration: const Duration(days: 1),
      );
    } else {
      WorkManagerService().cancelTask("maintenanceTask");
    }

    loadSettings();
  }

  Future<void> toggleOffers(bool value) async {
    await repo.updateSetting("offers", value);
    if (value) {
      WorkManagerService().registerOnetask(
        uniqueName: "offersTask",
        taskName: "offersReminder",
        duration: const Duration(days: 1),
      );
    } else {
      WorkManagerService().cancelTask("offersTask");
    }
    loadSettings();
  }

  Future<void> toggleAI(bool value) async {
    await repo.updateSetting("ai", value);
    if (value) {
      WorkManagerService().registerOnetask(
        uniqueName: "aiTask",
        taskName: "aiReminder",
        duration: const Duration(days: 1),
      );
    } else {
      WorkManagerService().cancelTask("aiTask");
    }
    loadSettings();
  }

  Future<void> toggleEmergency(bool value) async {
    await repo.updateSetting("emergency", value);
    if (value) {
      WorkManagerService().registerOnetask(
        uniqueName: "emergencyTask",
        taskName: "emergencyReminder",
        duration: const Duration(days: 1),
      );
    } else {
      WorkManagerService().cancelTask("emergencyTask");
    }
    loadSettings();
  }
}
