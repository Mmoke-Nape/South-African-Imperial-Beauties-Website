import 'package:flutter/foundation.dart';

class Contestant with ChangeNotifier {
  String id;
  final String name;
  final String lastName;
  final String email;
  final String idNumber;
  final String dob;
  final String instaHandle;
  final String address;
  final String category;
  final String hSPhotoUrl;
  final String fLPhotoUrl;

  Contestant({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.idNumber,
    required this.dob,
    required this.instaHandle,
    required this.address,
    required this.category,
    required this.hSPhotoUrl,
    required this.fLPhotoUrl,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastNape': lastName,
        'email': email,
        'idNumber': idNumber,
        'dob': dob,
        'instaHandle': instaHandle,
        'address': address,
        'category': category,
        'hSPhotoUrl': hSPhotoUrl,
        'fLPhotoUrl': fLPhotoUrl,
      };

  static Contestant fromJson(Map<String, dynamic> json) => Contestant(
        id: json['id'],
        name: json['name'],
        lastName: json['lastName'],
        email: json['email'],
        idNumber: json['idName'],
        dob: json['dob'],
        instaHandle: json['instaHandle'],
        address: json['address'],
        category: json['category'],
        hSPhotoUrl: json['hSPhotoUrl'],
        fLPhotoUrl: json['fLPhotoUrl'],
      );
}
