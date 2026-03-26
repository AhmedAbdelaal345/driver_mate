import 'package:driver_mate/core/service/local_notification_service.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  void registerOnetask({
    required String uniqueName,
    required String taskName,
    required Duration duration,
  }) {
    Workmanager().registerPeriodicTask(
      uniqueName,
      taskName,
      frequency: duration,
    );
  }

  void cancelTask(String id) {
    Workmanager().cancelByUniqueName(id);
  }

  Future<void> init() async {
    await Workmanager().initialize(actionTask, isInDebugMode: true);
  }
}

@pragma('vm:entry-point')
void actionTask() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case "maintenanceReminder":
        await LocalNotificationService.basicNotification(
          notificationId: "maintenance",
          id: 1,
          title: "Maintenance Reminder 🚗",
          body: "Time to check your car",
        );
        break;

      case "offersReminder":
        await LocalNotificationService.basicNotification(
          notificationId: "offers",
          id: 2,
          title: "New Offers 🎁",
          body: "Check latest deals",
        );
        break;

      case "aiReminder":
        await LocalNotificationService.basicNotification(
          notificationId: "ai",
          id: 3,
          title: "AI Alert 🤖",
          body: "New smart recommendation",
        );
        break;

      case "emergencyReminder":
        await LocalNotificationService.basicNotification(
          notificationId: "emergency",
          id: 4,
          title: "Emergency Update 🚨",
          body: "Important alert for you",
        );
        break;
    }
    return Future.value(true);
  });
}
