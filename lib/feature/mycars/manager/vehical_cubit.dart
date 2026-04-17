import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';
import 'package:driver_mate/feature/mycars/data/repo/vechicle_repo.dart';
import 'package:driver_mate/feature/mycars/manager/vehical_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicalCubit extends Cubit<VehicalState> {
  VehicalCubit({required this.repo}) : super(InitialVehicalState());
  static VehicalCubit get(context) => BlocProvider.of<VehicalCubit>(context);
  final TextEditingController modelController = TextEditingController();
  final TextEditingController plateController = TextEditingController();
  final TextEditingController mileageController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  int count = 0;

  VechicleRepo repo;

  // Store the current list of vehicles for duplicate checking
  List<VechicleModel> _currentVehicles = [];

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

  /// Check if a vehicle already exists in the list
  bool _isDuplicate(VechicleModel newVehicle) {
    return _currentVehicles.any((existingVehicle) {
      // Check if brand, model, and year match (case-insensitive)
      return existingVehicle.brand!.toLowerCase() ==
              newVehicle.brand!.toLowerCase() &&
          existingVehicle.model!.toLowerCase() ==
              newVehicle.model!.toLowerCase() &&
          existingVehicle.year == newVehicle.year;
    });
  }

  /// Check if a vehicle with the same plate number exists
  bool _isDuplicatePlate(VechicleModel newVehicle) {
    // Only check if plate is not empty
    if (newVehicle.plateNumber.isEmpty) return false;

    return _currentVehicles.any((existingVehicle) {
      return existingVehicle.plateNumber.toLowerCase() ==
          newVehicle.plateNumber.toLowerCase();
    });
  }

  Future<void> addVehicle({required VechicleModel vehicle}) async {
    // Check for duplicate before adding
    if (_isDuplicate(vehicle)) {
      emit(ErrorVehicalState(error: AppConstants.duplicateCarError));
      return;
    }

    // Check for duplicate plate number
    if (_isDuplicatePlate(vehicle)) {
      emit(ErrorVehicalState(error: AppConstants.duplicatePlateError));
      return;
    }

    emit(LoadingVehicalState());

    final Either<String, VechicleModel> result = await repo.addCar(
      car: vehicle,
    );

    result.fold((error) => emit(ErrorVehicalState(error: error)), (r) async {
      emit(
        AddVehicalSuccessState(
          vehicle: r,
          message: AppConstants.carAddedSuccefully,
        ),
      );
      clearControllers();
      await loadCar(); // 🔥 reload list after add
    });
  }

  Future<void> loadCar() async {
    emit(LoadingVehicalState());

    final data = await repo.getCar();
    count = data.length;

    // Store the current vehicles list for duplicate checking
    _currentVehicles = data;

    emit(
      SuccessVehicalState(
        data: data, // list
        message: AppConstants.loadedSuccefully,
      ),
    );
  }

  Future<void> updateVehicle({
    required VechicleModel oldVehicle,
    required VechicleModel updatedVehicle,
  }) async {
    /// منع تكرار نفس العربية لو المستخدم غيّر البيانات
    final duplicated = _currentVehicles.any((item) {
      final isSameOld =
          item.brand == oldVehicle.brand &&
          item.model == oldVehicle.model &&
          item.year == oldVehicle.year &&
          item.plateNumber == oldVehicle.plateNumber;

      if (isSameOld) return false;

      return item.brand.toLowerCase() == updatedVehicle.brand.toLowerCase() &&
          item.model.toLowerCase() == updatedVehicle.model.toLowerCase() &&
          item.year == updatedVehicle.year;
    });

    if (duplicated) {
      emit(ErrorVehicalState(error: AppConstants.duplicateCarError));
      return;
    }

    /// منع تكرار اللوحة
    final duplicatedPlate = _currentVehicles.any((item) {
      final isSameOld =
          item.plateNumber == oldVehicle.plateNumber &&
          item.brand == oldVehicle.brand &&
          item.model == oldVehicle.model &&
          item.year == oldVehicle.year;

      if (isSameOld) return false;

      return item.plateNumber.toLowerCase() ==
          updatedVehicle.plateNumber.toLowerCase();
    });

    if (duplicatedPlate) {
      emit(ErrorVehicalState(error: AppConstants.duplicatePlateError));
      return;
    }

    emit(LoadingVehicalState());

    final result = await repo.updateCar(
      oldCar: oldVehicle,
      newCar: updatedVehicle,
    );

    result.fold((error) => emit(ErrorVehicalState(error: error)), (
      vehicle,
    ) async {
      emit(
        AddVehicalSuccessState(
          vehicle: vehicle,
          message: "Vehicle updated successfully",
        ),
      );

      clearControllers();
      await loadCar();
    });
  }

  /// Optional: Method to check if car can be added before navigating to add page
  bool canAddVehicle({
    required String brand,
    required String model,
    required String year,
    required String plateNumber,
    required double millAge,
    required DateTime date,
    File? image,
    VehicleStatus status = VehicleStatus.active,
  }) {
    final tempVehicle = VechicleModel(
      brand: brand,
      model: model,
      status: status,
      year: int.tryParse(year) ?? 0,
      plateNumber: plateNumber, // Empty for this check
      millAge: millAge,
      image: image,
      date: date,
    );
    return !_isDuplicate(tempVehicle);
  }

  Future<void> deleteVehicle({required VechicleModel vehicle}) async {
    emit(LoadingVehicalState());

    final Either<String, bool> result = await repo.deleteCar(car: vehicle);

    result.fold((error) => emit(ErrorVehicalState(error: error)), (
      success,
    ) async {
      emit(
        DeleteVehicalSuccessState(message: AppConstants.carDeletedSuccessfully),
      );
      await loadCar(); // 🔥 reload list after delete
    });
  }
}
