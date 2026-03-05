import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/feature/cartips/data/model/car_tip_list_model.dart';

class CarTipLsitRepo {
  Future<List<CarTipListModel>> getTip() async {
    // API call or local data
    return [
      CarTipListModel(
        title: "Regular Oil Change Schedule",
        description:
            "Learn when and why you should change your oil regularly...",
        category: "Maintenance",
        minutes: 3,
        image: AppImagePath.bmwCarImagePath,
        isUpdated: true,
      ),
      CarTipListModel(
        title: "Improving Fuel Efficiency",
        description:
            "Simple driving habits and maintenance tips to maximize MPG...",
        category: "Fuel Economy",
        image: AppImagePath.tairImagePath,

        minutes: 4,
        isUpdated: true,
      ),
      CarTipListModel(
        title: "Brake Maintenance Basics",
        description:
            "Signs your brakes need attention and how to maintain them...",
        category: "Brakes",
        minutes: 3,
        image: AppImagePath.carImagePath,
        isUpdated: false,
      ),
    ];
  }
}
