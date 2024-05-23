abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {}

class PaymentError extends PaymentState {
  final String error;
  PaymentError(this.error);
}

class AddInvoiceLoadingState extends PaymentState {}

class AddInvoiceSuccessState extends PaymentState {}

class AddInvoiceErrorState extends PaymentState {
  final String error;
  AddInvoiceErrorState(this.error);
}