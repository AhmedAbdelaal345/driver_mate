import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/feature/profile/data/repo/contact_us_repo.dart';
import 'package:driver_mate/feature/profile/manager/contact_us_manager/contact_us_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  final EmailRepository repo;
  ContactUsCubit({required this.repo}) : super(ContactUsStateInit());
  void sendMessage({required String subject, required String message}) {
    emit(ContactUsStateLoading());
    try {
      repo.sendEmail(
        to: AppConstants.supportEmail,
        subject: subject,
        body: message,
      );
      emit(ContactUsStateSuccess(
        message: "The Message Sent"
      ));
    } on Exception catch (e) {
      emit(ContactUsStateFauilor(erorr: e.toString()));
    }
  }
}
