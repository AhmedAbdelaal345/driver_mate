import 'package:dartz/dartz.dart';
import 'package:driver_mate/core/network/api_helper.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/feature/cartips/data/model/car_tip_list_model.dart';

class CarTipLsitRepo {
  CarTipLsitRepo._sigleTone();
  static CarTipLsitRepo _instance = CarTipLsitRepo._sigleTone();
  factory CarTipLsitRepo() => _instance;
  List<CarTipListModel> carTipListModel = [];
  Future<Either<String, List<CarTipListModel>>> getTip() async {
    try {
      final response = await ApiHelper().getRequest(
        endpoint: "tips",
        isAuthorized: true,
      );
      print("The respone of tips is :\n ${response.data}\n\n");
      if (response.statusCode != 200) {
        return left(response.message);
      }
      carTipListModel.clear();
      final data = response.data;
      if (data != null) {
        for (var item in data) {
          carTipListModel.add(CarTipListModel.fromJson(item));
          carTipListModel.addAll([
            CarTipListModel(
              id: "1",
              title: "Regular Oil Change Schedule",
              content:
                  "Learn when and why you should change your oil regularly...",
              category: "Maintenance",
              authorName: "John Doe",
              imageUrl: AppImagePath.bmwCarImagePath,
              createdAt: DateTime.now(),
            ),
            CarTipListModel(
              id: "2",
              title: "Improving Fuel Efficiency",
              content:
                  "Simple driving habits and maintenance tips to maximize MPG...",
              category: "Fuel Economy",
              authorName: "John Doe",
              imageUrl: AppImagePath.tairImagePath,
              createdAt: DateTime.now(),
            ),
            CarTipListModel(
              id: "3",
              title: "Brake Maintenance Basics",
              content:
                  "Signs your brakes need attention and how to maintain them...",
              category: "Brakes",
              authorName: "John Doe",
              imageUrl: AppImagePath.carImagePath,
              createdAt: DateTime.now(),
            ),
          ]);
        }
      }
      return right(carTipListModel);
    } catch (e) {
      return left(e.toString());
    }
  }
}
