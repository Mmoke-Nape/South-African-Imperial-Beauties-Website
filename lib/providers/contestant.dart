import 'package:flutter/foundation.dart';

class Contestant with ChangeNotifier {
  String id;
  final String name;
  final String lastName;
  final String email;
  final String contactNumber;
  final String dob;
  final String instaHandle;
  final String address;
  final String category;
  final String hSPhotoUrl;
  final String fLPhotoUrl;
  final String modelingSchoolContact;
  final String tShirtSize;

  final bool? isUnder18;
  final String? gName;
  final String? gSurname;
  final String? gContactNumber;
  final String? gEmail;

  Contestant({
    this.isUnder18,
    this.gName,
    this.gSurname,
    this.gContactNumber,
    this.gEmail,
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    required this.dob,
    required this.instaHandle,
    required this.address,
    required this.category,
    required this.hSPhotoUrl,
    required this.fLPhotoUrl,
    required this.modelingSchoolContact,
    required this.tShirtSize,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastNape': lastName,
        'email': email,
        'contactNumber': contactNumber,
        'dob': dob,
        'instaHandle': instaHandle,
        'address': address,
        'category': category,
        'hSPhotoUrl': hSPhotoUrl,
        'fLPhotoUrl': fLPhotoUrl,
        'isUnder18': isUnder18,
        'gName': gName,
        'gSurname': gSurname,
        'gContactNumber': gContactNumber,
        'gEmail': gEmail,
        'modelingSchoolContact': modelingSchoolContact,
        'tShirtSize': tShirtSize,
      };

  static Contestant fromJson(Map<String, dynamic> json) => Contestant(
        isUnder18: json['isUnder18'],
        gName: json['gName'],
        gSurname: json['gSurname'],
        gContactNumber: json['gContactNumber'],
        gEmail: json['gEmail'],
        id: json['id'],
        name: json['name'],
        lastName: json['lastName'],
        email: json['email'],
        contactNumber: json['contactNumber'],
        dob: json['dob'],
        instaHandle: json['instaHandle'],
        address: json['address'],
        category: json['category'],
        hSPhotoUrl: json['hSPhotoUrl'],
        fLPhotoUrl: json['fLPhotoUrl'],
        modelingSchoolContact: json['modelingSchoolContact'],
        tShirtSize: json['tShirtSize'],
      );
}
