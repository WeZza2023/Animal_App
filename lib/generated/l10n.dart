// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Flutter Example App`
  String get title {
    return Intl.message(
      'Flutter Example App',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email-address`
  String get pleaseEnterYourEmail {
    return Intl.message(
      'Please enter your email-address',
      name: 'pleaseEnterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get pleaseEnterYourPassword {
    return Intl.message(
      'Please enter your password',
      name: 'pleaseEnterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Continue with`
  String get continueWith {
    return Intl.message(
      'Continue with',
      name: 'continueWith',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get facebook {
    return Intl.message(
      'Facebook',
      name: 'facebook',
      desc: '',
      args: [],
    );
  }

  /// `Google`
  String get google {
    return Intl.message(
      'Google',
      name: 'google',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get pleaseEnterYourName {
    return Intl.message(
      'Please enter your name',
      name: 'pleaseEnterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get pleaseEnterYourPhone {
    return Intl.message(
      'Please enter your phone number',
      name: 'pleaseEnterYourPhone',
      desc: '',
      args: [],
    );
  }

  /// `Do you have an account?`
  String get doYouHaveAccount {
    return Intl.message(
      'Do you have an account?',
      name: 'doYouHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Search ...`
  String get search {
    return Intl.message(
      'Search ...',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Cats`
  String get cats {
    return Intl.message(
      'Cats',
      name: 'cats',
      desc: '',
      args: [],
    );
  }

  /// `Dogs`
  String get dogs {
    return Intl.message(
      'Dogs',
      name: 'dogs',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get requests {
    return Intl.message(
      'Requests',
      name: 'requests',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Discover`
  String get discover {
    return Intl.message(
      'Discover',
      name: 'discover',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Received`
  String get received {
    return Intl.message(
      'Received',
      name: 'received',
      desc: '',
      args: [],
    );
  }

  /// `Not Received`
  String get notReceived {
    return Intl.message(
      'Not Received',
      name: 'notReceived',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get rejected {
    return Intl.message(
      'Rejected',
      name: 'rejected',
      desc: '',
      args: [],
    );
  }

  /// `My Pets`
  String get myPets {
    return Intl.message(
      'My Pets',
      name: 'myPets',
      desc: '',
      args: [],
    );
  }

  /// `Number of Pets`
  String get numOfPets {
    return Intl.message(
      'Number of Pets',
      name: 'numOfPets',
      desc: '',
      args: [],
    );
  }

  /// `My Adopted Animals`
  String get myAdoptedAnimals {
    return Intl.message(
      'My Adopted Animals',
      name: 'myAdoptedAnimals',
      desc: '',
      args: [],
    );
  }

  /// `Number of Adopted Animals`
  String get numOfAdoptedAnimals {
    return Intl.message(
      'Number of Adopted Animals',
      name: 'numOfAdoptedAnimals',
      desc: '',
      args: [],
    );
  }

  /// `My Ratings`
  String get myRatings {
    return Intl.message(
      'My Ratings',
      name: 'myRatings',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Common Questions`
  String get commonQuestions {
    return Intl.message(
      'Common Questions',
      name: 'commonQuestions',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Animal Name`
  String get animalName {
    return Intl.message(
      'Animal Name',
      name: 'animalName',
      desc: '',
      args: [],
    );
  }

  /// `Animal Type`
  String get animalType {
    return Intl.message(
      'Animal Type',
      name: 'animalType',
      desc: '',
      args: [],
    );
  }

  /// `Animal Gender`
  String get animalGender {
    return Intl.message(
      'Animal Gender',
      name: 'animalGender',
      desc: '',
      args: [],
    );
  }

  /// `Animal Age`
  String get animalAge {
    return Intl.message(
      'Animal Age',
      name: 'animalAge',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Animal Description`
  String get animalDescription {
    return Intl.message(
      'Animal Description',
      name: 'animalDescription',
      desc: '',
      args: [],
    );
  }

  /// `Photos`
  String get photos {
    return Intl.message(
      'Photos',
      name: 'photos',
      desc: '',
      args: [],
    );
  }

  /// `Adoption Reason`
  String get adoptionReason {
    return Intl.message(
      'Adoption Reason',
      name: 'adoptionReason',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Post`
  String get confirmPost {
    return Intl.message(
      'Confirm Post',
      name: 'confirmPost',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Dog`
  String get dog {
    return Intl.message(
      'Dog',
      name: 'dog',
      desc: '',
      args: [],
    );
  }

  /// `Cat`
  String get cat {
    return Intl.message(
      'Cat',
      name: 'cat',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Add Photos`
  String get addPhotos {
    return Intl.message(
      'Add Photos',
      name: 'addPhotos',
      desc: '',
      args: [],
    );
  }

  /// `Account created successfully.`
  String get signupSuccessfully {
    return Intl.message(
      'Account created successfully.',
      name: 'signupSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Account creation failed.`
  String get signupError {
    return Intl.message(
      'Account creation failed.',
      name: 'signupError',
      desc: '',
      args: [],
    );
  }

  /// `Login successfully.`
  String get loginSuccessfully {
    return Intl.message(
      'Login successfully.',
      name: 'loginSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Login failed.`
  String get loginError {
    return Intl.message(
      'Login failed.',
      name: 'loginError',
      desc: '',
      args: [],
    );
  }

  /// `Added animal successfully`
  String get addedAnimalSuccessfully {
    return Intl.message(
      'Added animal successfully',
      name: 'addedAnimalSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, please try again`
  String get processError {
    return Intl.message(
      'Something went wrong, please try again',
      name: 'processError',
      desc: '',
      args: [],
    );
  }

  /// `Select your country code`
  String get selectyourcountrycode {
    return Intl.message(
      'Select your country code',
      name: 'selectyourcountrycode',
      desc: '',
      args: [],
    );
  }

  /// `Please select country code`
  String get pleaseSelectCountryCode {
    return Intl.message(
      'Please select country code',
      name: 'pleaseSelectCountryCode',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Verify your email with whatsapp`
  String get verifyYourEmailWhatsapp {
    return Intl.message(
      'Verify your email with whatsapp',
      name: 'verifyYourEmailWhatsapp',
      desc: '',
      args: [],
    );
  }

  /// `1. Ensure that you enter a valid phone number.`
  String get step1 {
    return Intl.message(
      '1. Ensure that you enter a valid phone number.',
      name: 'step1',
      desc: '',
      args: [],
    );
  }

  /// `2. Click on the link below.`
  String get step2 {
    return Intl.message(
      '2. Click on the link below.',
      name: 'step2',
      desc: '',
      args: [],
    );
  }

  /// `3. Send the code to verify.`
  String get step3 {
    return Intl.message(
      '3. Send the code to verify.',
      name: 'step3',
      desc: '',
      args: [],
    );
  }

  /// `4. Return to the app.`
  String get step4 {
    return Intl.message(
      '4. Return to the app.',
      name: 'step4',
      desc: '',
      args: [],
    );
  }

  /// `5. Click on done.`
  String get step5 {
    return Intl.message(
      '5. Click on done.',
      name: 'step5',
      desc: '',
      args: [],
    );
  }

  /// `Please enter this field`
  String get pleaseEnterThisField {
    return Intl.message(
      'Please enter this field',
      name: 'pleaseEnterThisField',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get id {
    return Intl.message(
      'ID',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Ask for adoption`
  String get askForAdoption {
    return Intl.message(
      'Ask for adoption',
      name: 'askForAdoption',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get reject {
    return Intl.message(
      'Reject',
      name: 'reject',
      desc: '',
      args: [],
    );
  }

  /// `You did not request any animal.`
  String get youdidnotRequestanyAnimal {
    return Intl.message(
      'You did not request any animal.',
      name: 'youdidnotRequestanyAnimal',
      desc: '',
      args: [],
    );
  }

  /// `You did not adopt any animal.`
  String get youdidnotAdoptanyAnimal {
    return Intl.message(
      'You did not adopt any animal.',
      name: 'youdidnotAdoptanyAnimal',
      desc: '',
      args: [],
    );
  }

  /// `No more results`
  String get noMoreResults {
    return Intl.message(
      'No more results',
      name: 'noMoreResults',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
