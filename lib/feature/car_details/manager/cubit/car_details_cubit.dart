import 'package:driver_mate/feature/car_details/data/repo/car_details_repo.dart';
import 'package:driver_mate/feature/car_details/manager/state/car_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarDetailsCubit extends Cubit<CarDetailsState> {
  CarDetailsCubit() : super(CarDetailsInitial());
  // ignore: prefer_final_fields
  CarDetailsRepo _carDetailsRepo = CarDetailsRepo();
  static CarDetailsCubit get(context) => BlocProvider.of<CarDetailsCubit>(context);
  Future<void> loadCarDetails() async {
    emit(CarDetailsLoading());
    try {
      // Simulate a network call to fetch car details
      await Future.delayed(const Duration(seconds: 2));
      // For demonstration, we will use dummy data
      final carDetails = _carDetailsRepo.getDetailsCars();
      emit(CarDetailsLoaded(carDetails));
    } catch (e) {
      emit(CarDetailsError('Failed to load car details'));
    }
  }
}
