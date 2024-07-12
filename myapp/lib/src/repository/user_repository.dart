import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/src/features/screens/auth/model/user_model.dart';

/*

=============
Todo: Step - 2 Create a user repository image.


 */

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db.collection("Users").add(user.toJson()).whenComplete(() {
      Get.snackbar(
        "Welcome!",
        "Account Created Successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade300.withOpacity(0.1),
        colorText: Colors.green,
      );
    }).catchError((error, stackTrace) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print(error.toString());
    });
  }
}
