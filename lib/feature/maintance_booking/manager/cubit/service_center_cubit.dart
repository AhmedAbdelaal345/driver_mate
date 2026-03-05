import 'package:driver_mate/feature/maintance_booking/data/model/service_center_model.dart';
import 'package:driver_mate/feature/maintance_booking/data/repo/service_center_repo.dart';
import 'package:driver_mate/feature/maintance_booking/manager/state/service_center_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceCenterCubit extends Cubit<ServiceCenterState> {
  ServiceCenterCubit() : super(ServiceCenterInitial());
  ServiceCenterRepo repo = ServiceCenterRepo();
  static ServiceCenterCubit get(context) =>
      BlocProvider.of<ServiceCenterCubit>(context);
  Future<void> loadServiceCenters() async {
    emit(ServiceCenterLoading());
    try {
      final List<ServiceCenterModel> serviceCenters = await repo
          .getServiceCenterData();
      emit(ServiceCenterLoaded(serviceCenters));
    } catch (e) {
      // log(e.toString());
      emit(ServiceCenterError(e.toString()));
    }
  }
}
