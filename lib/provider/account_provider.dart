import 'package:flutter/widgets.dart';
import 'package:funchat/models/account.dart';
import 'package:funchat/services/firebase_repository.dart';

class AccountProvider extends ChangeNotifier {
  Account _account;
  FirebaseRepository _firebaseRepository = FirebaseRepository();

  Account get getAccount => _account;

  void refreshUser() async {
    Account account = await _firebaseRepository.getUserDetails();
    _account = account;
    notifyListeners();
  }

}