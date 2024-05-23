// import 'package:animal_app/network/api_constants.dart';
// import 'package:animal_app/network/dio_helper.dart';
// import 'package:animal_app/network/payment_service/payment_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class PaymentCubit extends Cubit<PaymentState> {
//   PaymentCubit() : super(PaymentInitial());
//
//   static PaymentCubit get(context) => BlocProvider.of(context);
//   Future<void> getAuthToken() async {
//     emit(PaymentLoading());
//       DioHelper.getToken(url: PaymentApiConstants.getAuthToken,data: {
//       "apiId": PaymentApiConstants.appID,
//       "secretKey": PaymentApiConstants.secretKey,
//       "persistToken": false
//     }).then((value) {
//       PaymentApiConstants.firstToken = value.data['id_token'];
//       print("The token is ${PaymentApiConstants.firstToken}");
//       emit(PaymentSuccess());
//     }).catchError((error){
//       emit(PaymentError(error.toString()));
//       print( error.toString());
//     });
//   }
//
//
//
//   Future addInvoice({
//     required String token,
//     required String amount,
//     required String clientMobile,
//     required String clientName,
//     required String orderNumber,
//     required List<Map<String, dynamic>> products,
//   }) async {
//     emit(AddInvoiceLoadingState());
//     DioHelper.postData(
//         url: PaymentApiConstants.addInvoice,
//
//         data: {
//           "token": token,
//           "amount": amount,
//           "clientMobile": clientMobile,
//           "clientName": clientName,
//           "orderNumber": orderNumber,
//           "products": products
//         }).then((value) {
//           emit(AddInvoiceSuccessState());
//           PaymentApiConstants.orderId = value.data['orderNumber'];
//           print(PaymentApiConstants.orderId);
//         }).catchError((error) {
//           emit(AddInvoiceErrorState(error.toString()));
//           print(error.toString());
//         });
//         }
//
//
//   }
//
