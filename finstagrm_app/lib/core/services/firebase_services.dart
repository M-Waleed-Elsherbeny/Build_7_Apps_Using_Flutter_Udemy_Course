import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String USER_COLLECTION = 'users';

class FirebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  Map<String, dynamic>? userData = {};
  FirebaseServices();

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        userData = await getUserFromFirebase(userId: userCredential.user!.uid);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<Map<String, dynamic>> getUserFromFirebase({
    required String userId,
  }) async {
    try {
      DocumentSnapshot userSnapshot =
          await db.collection(USER_COLLECTION).doc(userId).get();
      if (userSnapshot.exists) {
        return userSnapshot.data() as Map<String, dynamic>;
      } else {
        return {};
      }
    } catch (e) {
      log(e.toString());
      return {};
    }
  }
}
