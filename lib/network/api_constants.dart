class ApiConstants {

  static const String baseUrl = 'https://timon.pw/api/';
  static const String baseUrlNOAPI = 'https://timon.pw/';
  static const String register = 'register';
  static const String login = 'login';
  static const String animal = 'animal';
  static const String addAnimal = 'animal/create';
  static const String buy = 'buy';
  static const String storeToken = 'store-token';
  static const String myProfile = 'profile';
  static const String getNotifications = 'user/orderstoreply';
  static const String requests = 'user/order';
  static const String accept = 'order/accept';
  static const String refuse = 'order/refuse';
  static const String sendNotification = 'send-web-notification';
  static const String whatsAppVerificationBaseUrl = 'https://whatsauth.me/api/v1/';
  static const String verify = 'verification_code';
  static  String userToken = '';
  static  String userId = '';
  static  String? deviceToken;
}



  class PaymentApiConstants {
  static const String appID = 'APP_ID_1123453311';
  static const String secretKey = '0662abb5-13c7-38ab-cd12-236e58f43766';
  static const String paymentBaseUrl = 'https://restpilot.paylink.sa/api';
  static const String getAuthToken = '/auth';
  static const String addInvoice = '/addInvoice';
  static  String firstToken = '';
  static const String transactionNo = '';
  static  String orderId = '';
}