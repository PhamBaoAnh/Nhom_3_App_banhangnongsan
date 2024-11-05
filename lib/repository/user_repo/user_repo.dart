import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/features/authentication/models/user_model.dart';

class userRepo extends GetxController {
  static userRepo get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  createUser(UserModel user) async => await _db
          .collection('user')
          .add(user.toJson())
          .whenComplete(() => Get.snackbar('Success', "User has been created",
              snackPosition: SnackPosition.BOTTOM, colorText: Colors.green))
          .catchError((error, stackTrace) {
        Get.snackbar('Error', "User has not been created",
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
      });

  getUserDetail(String email) async {
    final snapshot =
        await _db.collection('user').where('Email', isEqualTo: email).get();
if(snapshot.docs.isNotEmpty){
    final userData=snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
  return userData;}
else {
  return null;
}
  }
  getAllUser() async {
    final snapshot = await _db.collection('user').get();

     final userData= snapshot.docs.map((e) => UserModel.fromSnapshot).toList();
    return userData;
  }

  updateUser(UserModel user) async{
    try {
      await _db.collection('user').doc(user.id).update(user.toJson());
    } catch (e) {
      print('Failed to update user: $e');
    }
  }
  deleteUser(UserModel user) async {
    try {
      await _db.collection('user').doc(user.id).delete();
      Get.snackbar('Success', 'Delete success');
    }catch (e) {
      print('Failed to update user: $e');
    }
  }
}


