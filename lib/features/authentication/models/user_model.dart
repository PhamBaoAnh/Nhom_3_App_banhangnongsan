import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;

  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;
  final String phoneNo;
  final String? gender;

  UserModel(
      {   required this.id,
        this.gender,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.email,
      required this.password,
      required this.phoneNo});

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'Password': password,
      'PhoneNo': phoneNo,
      'Gender' :gender
    };
  }
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data =doc.data()! ;
    return UserModel(
      firstName: data['FirstName'],
      id :  doc.id,
      lastName: data['LastName'],
      username: data['Username'],
      email: data['Email'],
      password: data['Password'],
      phoneNo: data['PhoneNo'] ?? '',
      gender: data['Gender']??''
    );
  }

}
