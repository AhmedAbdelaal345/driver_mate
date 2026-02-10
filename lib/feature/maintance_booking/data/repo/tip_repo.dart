import 'package:driver_mate/feature/maintance_booking/data/model/tip_model.dart';

class MaintenanceTipRepo {
  Future<MaintenanceTipModel> getTip() async {
    await Future.delayed(const Duration(seconds: 1));

    return MaintenanceTipModel(
      title: "Check tire pressure before long trips",
      description: "A quick check improves safety and fuel efficiency.",
      whyItMatters: [
        "Improves vehicle safety",
        "Reduces tire wear",
        "Improves fuel efficiency",
      ],
      whatYouNeed: ["Tire gauge", "Air pump", "Owner manual"],
      steps: [
        "Check pressure when tires are cold",
        "Use recommended PSI",
        "Measure all tires",
        "Adjust and re-check",
      ],
      mistakes: [
        "Do not rely only on visual inspection",
        "Do not overinflate tires",
        "Re-check pressure after adjusting",
      ],
    );
  }
}
