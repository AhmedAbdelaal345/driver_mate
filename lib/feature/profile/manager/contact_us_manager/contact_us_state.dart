class ContactUsState {}

class ContactUsStateInit extends ContactUsState {}

class ContactUsStateLoading extends ContactUsState {}

class ContactUsStateSuccess extends ContactUsState {
  final String message;
  ContactUsStateSuccess({required this.message});
}

class ContactUsStateFauilor extends ContactUsState {
  final String erorr;
  ContactUsStateFauilor({required this.erorr});
}
