import 'package:driver_mate/feature/maintance_history/data/model/maintance_history_model.dart';

abstract class MaintenceHistoryState {}

class MaintenceHistoryInititailState extends MaintenceHistoryState {}

class MaintenceHistoryLoadingState extends MaintenceHistoryState {}

class MaintenceHistorySuccessState extends MaintenceHistoryState {
  List<MaintanceHistoryModel> items = [];
  MaintenceHistorySuccessState({required this.items});
}

class MaintenceHistoryErrorState extends MaintenceHistoryState {
  String message;
  MaintenceHistoryErrorState({required this.message});
}
