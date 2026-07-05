import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';
import 'package:driver_mate/feature/mycars/data/repo/vechicle_repo.dart';
import 'package:driver_mate/feature/mycars/manager/vehical_state.dart';

class VehicalCubit extends Cubit<VehicalState> {
  VehicalCubit({required this.repo}) : super(InitialVehicalState());

  static VehicalCubit get(context) => BlocProvider.of<VehicalCubit>(context);

  final VechicleRepo repo;

  // Form controllers (acceptable to keep here for form-heavy features)
  final TextEditingController modelController = TextEditingController();
  final TextEditingController plateController = TextEditingController();
  final TextEditingController mileageController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  // NO MORE currentVehicles here. The state owns the list.

  void clearControllers() {
    mileageController.clear();
    modelController.clear();
    plateController.clear();
    brandController.clear();
    yearController.clear();
  }

  void disposeControllers() {
    modelController.dispose();
    mileageController.dispose();
    plateController.dispose();
    brandController.dispose();
    yearController.dispose();
  }

  /// Load vehicles from repo (call this in initState)
  Future<void> fetchVehicles() async {
    emit(LoadingVehicalState());
    final result = await repo.getVehicles();
    result.fold(
      (error) => emit(ErrorVehicalState(error: error)),
      (vehicles) => emit(
        SuccessVehicalState(
          data: vehicles,
          message: AppConstants.loadedSuccefully,
        ),
      ),
    );
  }

  Future<void> addVehicle({required VechicleModel vehicle}) async {
  emit(LoadingVehicalState());

  // Check duplicates against repo
  final currentResult = await repo.getVehicles();
  final currentVehicles = currentResult.getOrElse(() => []);

  if (_isDuplicate(vehicle, currentVehicles)) {
    emit(ErrorVehicalState(error: AppConstants.duplicateCarError));
    return;
  }

  final result = await repo.addCar(car: vehicle);
  result.fold(
    (error) => emit(ErrorVehicalState(error: error)),
    (message) {
      emit(AddVehicalSuccessState(vehicle: vehicle, message: message));
      // Refresh the list so MyCars page has latest data
      fetchVehicles();
    },
  );
}
  Future<void> updateVehicle({
    required VechicleModel oldVehicle,
    required VechicleModel updatedVehicle,
  }) async {
    emit(LoadingVehicalState());

    final result = await repo.updateCar(
      oldCar: oldVehicle,
      newCar: updatedVehicle,
    );
    await result.fold(
      (error) async => emit(ErrorVehicalState(error: error)),
      (message) async {
        await fetchVehicles();
        emit(UpdateVehicalSuccessState(message: message));
      },
    );
  }

  Future<void> deleteVehicle({required VechicleModel vehicle}) async {
    emit(LoadingVehicalState());

    final result = await repo.deleteCar(car: vehicle);
    await result.fold(
      (error) async => emit(ErrorVehicalState(error: error)),
      (message) async {
        await fetchVehicles();
        emit(DeleteVehicalSuccessState(message: message));
      },
    );
  }

  // ─── Duplicate Checks ───

  bool _isDuplicate(VechicleModel newVehicle, List<VechicleModel> vehicles) {
    return vehicles.any(
      (existing) =>
          existing.id == newVehicle.id ||
          (existing.brandName.toLowerCase() ==
                  newVehicle.brandName.toLowerCase() &&
              existing.modelName.toLowerCase() ==
                  newVehicle.modelName.toLowerCase() &&
              existing.year == newVehicle.year),
    );
  }

  bool _isDuplicatePlate(
    VechicleModel newVehicle,
    List<VechicleModel> vehicles,
  ) {
    if (newVehicle.plateNumber.isEmpty) return false;
    return vehicles.any(
      (existing) =>
          existing.plateNumber.toLowerCase() ==
          newVehicle.plateNumber.toLowerCase(),
    );
  }
}
