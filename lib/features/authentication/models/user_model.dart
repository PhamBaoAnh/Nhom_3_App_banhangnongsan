import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;

  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;
  final String phoneNo;
  final String gender;
  final String dateOfBirth;

  UserModel(
      {   required this.id,
        required this.gender,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.email,
      required this.password,
      required this.phoneNo,
        required this.dateOfBirth,});

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'Password': password,
      'PhoneNo': phoneNo,
      'Gender' :gender,
      'DateOfBirth': dateOfBirth
    };
  }
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data =doc.data()! ;
    return UserModel(
      firstName: data['FirstName'],
      id :  doc.id,
      dateOfBirth: data['DateOfBirth'],
      lastName: data['LastName'],
      username: data['Username'],
      email: data['Email'],
      password: data['Password'],
      phoneNo: data['PhoneNo'] ?? '',
      gender: data['Gender']??''
    );
  }
  UserModel copyWith(Map<String, dynamic> updates) {
    return UserModel(
      id: updates['id'] ?? this.id,
      firstName: updates['firstName'] ?? this.firstName,
      lastName: updates['lastName'] ?? this.lastName,
      username: updates['username'] ?? this.username,
      email: updates['email'] ?? this.email,
      password: updates['password'] ?? this.password,
      phoneNo: updates['phoneNo'] ?? this.phoneNo,
      gender: updates['gender'] ?? this.gender,
      dateOfBirth: updates['dateOfBirth'] ?? this.dateOfBirth,
    );
  }

}
