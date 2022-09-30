import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../providers/contestant.dart';
import '../../responsive/responsive.dart';
import '../../widgets/custom_button.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dOBController = TextEditingController();
  final emailController = TextEditingController();
  final contactNumController = TextEditingController();
  final iDNumberController = TextEditingController();
  final istaHandelController = TextEditingController();
  final addressController = TextEditingController();
  final provinceController = TextEditingController();
  final categoryController = TextEditingController();

  //contestant is Under 18 years old
  final under18Controller = TextEditingController();
  //g = guardian
  final gNameController = TextEditingController();
  final gSurnameController = TextEditingController();
  final gContactNumberController = TextEditingController();
  final gEmailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  File? hSPhotoMobile;
  Uint8List hSPhotoWeb = Uint8List(8);
  String? hSPhotoUrl;

  File? fLPhotoMobile;
  Uint8List fLPhotoWeb = Uint8List(8);
  String? fLPhotoUrl;
  // XFile? _userImage;

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    dOBController.dispose();
    emailController.dispose();
    contactNumController.dispose();
    iDNumberController.dispose();
    istaHandelController.dispose();
    addressController.dispose();
    provinceController.dispose();
    under18Controller.dispose();
    gNameController.dispose();
    gSurnameController.dispose();
    gContactNumberController.dispose();
    gEmailController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  void _pickedhSPhoto() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        var imageTemp = File(image.path);
        setState(() {
          hSPhotoMobile = imageTemp;
        });
        print('hs photo mobile successfull');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        var imageTemp = await XFile(image.toString()).readAsBytes();
        setState(() {
          hSPhotoWeb = imageTemp;
          hSPhotoMobile = File('a');
        });
        print('hs photoweb successfull');
      }
    } else {
      print('Somthing Went very wrong');
    }
  }

  void _pickedfLPhoto() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        var imageTemp = File(image.path);
        setState(() {
          fLPhotoMobile = imageTemp;
        });
        print('fl photo mobile successfull');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        var imageTemp = await XFile(image.toString()).readAsBytes();
        // var imageTemp = await image.readAsBytes();
        setState(() {
          fLPhotoWeb = imageTemp;
          fLPhotoMobile = File('a');
        });
        print('fl photoweb successfull');
      }
    } else {
      print('Somthing Went very wrong');
    }
  }

  Future uploadHSPhoto() async {
    final ref = FirebaseStorage.instance.ref().child('$categoryValue').child(
        '${nameController.text.trim()} ${lastNameController.text.trim()} HS');

    try {
      UploadTask uploadTask = ref.putData(hSPhotoWeb);
      print('Successfully put hsphoto in storage');
    } on FirebaseException catch (e) {
      print('HERE IS THE PROBLEM with hsPhoto!!! $e');
    }
    var temp = await ref.getDownloadURL();
    setState(() {
      hSPhotoUrl = temp;
    });
  }

  Future uploadFLPhoto() async {
    final ref = FirebaseStorage.instance.ref().child('$categoryValue').child(
        '${nameController.text.trim()} ${lastNameController.text.trim()} FL');

    try {
      UploadTask uploadTask = ref.putData(fLPhotoWeb);
      print('Successfully put FLphoto in storage');
    } on FirebaseException catch (e) {
      print('HERE IS THE PROBLEM with fLPhoto!!! $e');
    }
    var temp = await ref.getDownloadURL();
    setState(() {
      fLPhotoUrl = temp;
    });
  }

  Future submitForm() async {
    final docUser =
        FirebaseFirestore.instance.collection('$categoryValue').doc();

    await uploadHSPhoto();
    await uploadFLPhoto();

    final contestant = Contestant(
      id: docUser.id,
      name: nameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      idNumber: iDNumberController.text.trim(),
      dob: dOBController.text.trim(),
      instaHandle: istaHandelController.text.trim(),
      address: addressController.text.trim(),
      category: categoryValue!,
      hSPhotoUrl: "hSPhotoUrl!",
      fLPhotoUrl: "fLPhotoUrl!",
    );

    final json = contestant.toJson();
    await docUser.set(json);
    print('Successfully uploaded to firebase');
  }
  // var cate;

  // // Upload imagae to firebase storage
  // final ref = FirebaseStorage.instance.ref().child('$categoryValue').child(
  //     '${nameController.text.trim()} ${lastNameController.text.trim()}');

  // try {
  //   UploadTask uploadTask = ref.putData(hSPhotoWeb);
  //   print('Successfully put hsphoto in storage');
  // } on FirebaseException catch (e) {
  //   print('HERE IS THE PROBLEM with hsPhoto!!! $e');
  // }
  // final hSPhotoUrl = await ref.getDownloadURL();
  // // print('HERE IS THE hSPhotoUrl HERE!!!! : $hSPhotoUrl');

  // try {
  //   // await ref.putFile(File(fLPhotoWeb!.path));
  //   UploadTask uploadTask = ref.putData(fLPhotoWeb);
  //   print('Successfully put flphoto in storage');
  // } on FirebaseException catch (e) {
  //   print('HERE IS THE PROBLEM with flPhoto!!! $e');
  // }

  // final fLPhotoUrl = await ref.getDownloadURL();
  // // print('HERE IS THE fLPhotoUrl HERE!!!! : $fLPhotoUrl');
  final categoryItems = [
    '4-6',
    // "Hey everyone. I've been really struggling with this and im in pickle now. I cant 1) upload images onto firebase storage 2) download the link then 3) add the links to firebase database with other information. Obviously this is flutter web. I am in desperate need of help"
    '7-9',
    '10-12',
    '13-15',
    '16-19',
    '20-29',
    '30-49',
    '50+'
  ];

  String? categoryValue;

  @override
  // var direction = Responsive.isMobile(context) ? Axis.vertical : Axis.horizontal;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final MobileForm = Column(
      children: [
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 221, 221, 221),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 221, 221, 221),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Name',
          ),
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: lastNameController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 221, 221, 221),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 221, 221, 221),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Last Name',
          ),
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 221, 221, 221),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 221, 221, 221),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Email',
          ),
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: iDNumberController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 221, 221, 221),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 221, 221, 221),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'ID Number',
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: dOBController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 221, 221, 221),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 221, 221, 221),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Date of birth',
          ),
          keyboardType: TextInputType.name,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1990),
                lastDate: DateTime.now());
            if (pickedDate != null) {
              setState(() {
                dOBController.text =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
              });
            }
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: istaHandelController,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 221, 221, 221),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 221, 221, 221),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              labelText: 'Instagram Handle',
              labelStyle: TextStyle()),
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: addressController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 221, 221, 221),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 221, 221, 221),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Address',
          ),
          keyboardType: TextInputType.streetAddress,
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 221, 221, 221),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: categoryValue,
              items: categoryItems.map(buildMenuCategoryItem).toList(),
              onChanged: (value) => setState(() => categoryValue = value),
              hint: const Text('Category'),
              isExpanded: true,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );

    return Container(
      // height: size.height * .85,
      width: Responsive.isMobile(context) ? null : size.width * .4,
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
      margin: const EdgeInsets.only(top: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              'Imperial Beauties',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontSize: Responsive.isMobile(context) ? 40 : 50),
            ),
            const SizedBox(height: 30),
            if (Responsive.isMobile(context)) MobileForm,
            if (!Responsive.isMobile(context))
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Name',
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: TextFormField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Last Name',
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ],
              ),
            if (!Responsive.isMobile(context)) const SizedBox(height: 30),
            if (!Responsive.isMobile(context))
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: TextFormField(
                      controller: iDNumberController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'ID Number',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            if (!Responsive.isMobile(context)) const SizedBox(height: 30),
            if (!Responsive.isMobile(context))
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: dOBController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Date of birth',
                      ),
                      keyboardType: TextInputType.name,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime.now());
                        if (pickedDate != null) {
                          setState(() {
                            dOBController.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: TextFormField(
                      controller: istaHandelController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Instagram Handle',
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
            if (!Responsive.isMobile(context)) const SizedBox(height: 30),
            if (!Responsive.isMobile(context))
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 221, 221, 221),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Address',
                      ),
                      keyboardType: TextInputType.streetAddress,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 221, 221, 221),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: categoryValue,
                          items:
                              categoryItems.map(buildMenuCategoryItem).toList(),
                          onChanged: (value) =>
                              setState(() => categoryValue = value),
                          hint: const Text('Category'),
                          isExpanded: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 30),
            Text(
              'Photo upload',
              style:
                  Theme.of(context).textTheme.headline2!.copyWith(fontSize: 50),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: Responsive.isMobile(context) ? null : size.width * .8,
              child: Flex(
                direction: Responsive.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Full Length Photo',
                            style: Theme.of(context).textTheme.bodyText1!,
                            // .copyWith(fontSize: 50),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                              title: 'Select photo', press: _pickedfLPhoto),
                          const SizedBox(height: 10),
                          if (fLPhotoMobile != null)
                            const Icon(
                              Icons.thumb_up,
                              color: Colors.green,
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (Responsive.isMobile(context)) const SizedBox(height: 20),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: size.width * .1),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      children: [
                        Text('Head & Shoulder Photo',
                            style: Theme.of(context).textTheme.bodyText1!
                            // .copyWith(fontSize: 50),
                            ),
                        const SizedBox(height: 20),
                        CustomButton(
                            title: 'Select photo', press: _pickedhSPhoto),
                        const SizedBox(height: 10),
                        if (hSPhotoMobile != null)
                          const Icon(
                            Icons.thumb_up,
                            color: Colors.green,
                          ),
                        // Text(hSPhotoWeb)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            if (Responsive.isMobile(context)) const Divider(),
            if (Responsive.isMobile(context)) const SizedBox(height: 30),
            CustomButton(
              title: 'Submit Information',
              press: submitForm,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuCategoryItem(String item) =>
      DropdownMenuItem(value: item, child: Text(item));
}
