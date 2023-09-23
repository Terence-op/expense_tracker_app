import 'package:firebase_auth/firebase_auth.dart';

import '../constants/constants.dart';

class Auth {
  static Future<void> signUp({
    required String email,
    required String pwd,
    required String name,
    required int phone,
    required String address,
  }) async {
    UserCredential res = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: pwd);

    Map userData = {
      'id': res.user!.uid,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };

    //await userRef.child(res.user!.uid).set(userData);
  }
}
