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

  Future<void> addVehicle({required VechicleModel vehicle}) async {
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
    emit(
      SuccessVehicalState(
        data: data, // list
        message: AppConstants.loadedSuccefully,
      ),
    );
  }
}
