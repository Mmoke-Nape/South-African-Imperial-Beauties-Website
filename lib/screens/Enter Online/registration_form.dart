import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mother_international_comp_website/constants/app_colors.dart';
import 'package:mother_international_comp_website/constants/app_routes.dart';

import '../../constants/utils.dart';
import '../../providers/contestant.dart';
import '../../responsive/responsive.dart';
import '../../src/app.dart';
import '../../widgets/custom_button.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({
    Key? key,
    required this.regContext,
  }) : super(key: key);
  final BuildContext regContext;
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dOBController = TextEditingController();
  final emailController = TextEditingController();
  final contactNumController = TextEditingController();
  final contactNumberController = TextEditingController();
  final istaHandelController = TextEditingController();
  final addressController = TextEditingController();

  final modelingSchoolController = TextEditingController();
  final tShirtSizeController = TextEditingController();

  //contestant is Under 18 years old
  final under18Controller = TextEditingController();
  //g = guardian
  final gNameController = TextEditingController();
  final gSurnameController = TextEditingController();
  final gContactNumberController = TextEditingController();
  final gEmailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isUnder18 = false;

  // XFile? _userImage;

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    dOBController.dispose();
    emailController.dispose();
    contactNumController.dispose();
    contactNumberController.dispose();
    istaHandelController.dispose();
    addressController.dispose();

    under18Controller.dispose();
    gNameController.dispose();
    gSurnameController.dispose();
    gContactNumberController.dispose();
    gEmailController.dispose();

    modelingSchoolController.dispose();
    tShirtSizeController.dispose();
    super.dispose();
  }

  File? hSPhotoMobile;
  // Uint8List hSPhotoWeb = Uint8List(8);
  String? hSPhotoWeb;
  String? hSPhotoUrl;

  File? fLPhotoMobile;
  String? fLPhotoWeb;
  // Uint8List fLPhotoWeb = Uint8List(8);
  String? fLPhotoUrl;

  bool loading = false;

  Future uploadHSPhoto() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('$categoryValue')
        .child(
            '${nameController.text.trim()} ${lastNameController.text.trim()}')
        .child('Head & Shoulders');

    final upTask = ref.putData(
      await XFile(hSPhotoWeb!).readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    );
    final url = await upTask.then(
      (snap) => snap.ref.getDownloadURL(),
    );

    return url;
  }

  selectHSImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      XFile selectedImg = pickedFile;

      final path = File(selectedImg.path).path;
      setState(() {
        hSPhotoWeb = path;
      });
      //  setState this path variable//
// This path is String type//
    }
  }

  selectFLImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      XFile selectedImg = pickedFile;

      final path = File(selectedImg.path).path;
      setState(() {
        fLPhotoWeb = path;
      });
      //  setState this path variable//
// This path is String type//
    }
  }

  static Future<String> uploadSingleImg({
    /// Path  where  the  image  will  be  saved  in  storage.
    required String path,
    required String name_last,

    ///Image  File  path
    required String imagePath,

    ///image name
    required String fileName,
  }) async {
    final FirebaseStorage storage = FirebaseStorage.instance;

    final reference =
        storage.ref().child(path).child(name_last).child(fileName);

    final upTask = reference.putData(
      await XFile(imagePath).readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    );
    final url = await upTask.then(
      (snap) => snap.ref.getDownloadURL(),
    );

    return url;
  }

  Future submitForm(context, size) async {
    setState(() {
      loading = true;
    });

    final docUser =
        FirebaseFirestore.instance.collection('$categoryValue').doc();

    // await uploadHSPhoto();
    // await uploadFLPhoto();
    var hsurl = await uploadSingleImg(
      path: categoryValue!,
      name_last:
          '${nameController.text.trim()} ${lastNameController.text.trim()}',
      imagePath: hSPhotoWeb!,
      fileName: 'Head Shoulders',
    );
    var flurl = await uploadSingleImg(
      path: categoryValue!,
      name_last:
          '${nameController.text.trim()} ${lastNameController.text.trim()}',
      imagePath: fLPhotoWeb!,
      fileName: 'Full Length',
    );

    final contestant = Contestant(
      id: docUser.id,
      name: nameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      contactNumber: contactNumberController.text.trim(),
      dob: dOBController.text.trim(),
      instaHandle: istaHandelController.text.trim(),
      address: addressController.text.trim(),
      category: categoryValue!,
      hSPhotoUrl: hsurl,
      fLPhotoUrl: flurl,
      isUnder18: isUnder18,
      gName: isUnder18 ? gNameController.text.trim() : null,
      gSurname: isUnder18 ? gSurnameController.text.trim() : null,
      gContactNumber: isUnder18 ? gContactNumberController.text.trim() : null,
      gEmail: isUnder18 ? gEmailController.text.trim() : null,
      modelingSchoolContact: modelingSchoolController.text.trim(),
      tShirtSize: tShirtSizeController.text.trim(),
    );

    final json = contestant.toJson();
    await docUser.set(json);
    print('Successfully uploaded to firebase');

    setState(() {
      loading = false;
    });

    showCustomDialog(widget.regContext, size);

    // nameController.clear();
    // lastNameController.clear();
    // emailController.clear();
    // contactNumberController.clear();
    // dOBController.clear();
    // istaHandelController.clear();
    // addressController.clear();

    // under18Controller.clear();
    // gNameController.clear();
    // gSurnameController.clear();
    // gContactNumberController.clear();
    // gEmailController.clear();
    // modelingSchoolController.clear();
    // tShirtSizeController.clear();
  }

  final categoryItems = [
    '4-6',
    '7-9',
    '10-12',
    '13-15',
    '16-19',
    '20-29',
    '30-49',
    '50+'
  ];

  String? categoryValue;

  String? fLphotoErr;
  String? hSphotoErr;
  String? categoryValErr;

  @override
  // var direction = Responsive.isMobile(context) ? Axis.vertical : Axis.horizontal;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final MobileForm = Column(
      children: [
        TextFormField(
            enabled: !loading,
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
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
            }),
        const SizedBox(height: 20),
        TextFormField(
            enabled: !loading,
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
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your last name';
              }
            }),
        const SizedBox(height: 20),
        TextFormField(
          enabled: !loading,
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
          keyboardType: TextInputType.emailAddress,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (email) => email != null && !EmailValidator.validate(email)
              ? 'Enter a valid email'
              : null,
        ),
        const SizedBox(height: 20),
        TextFormField(
          enabled: !loading,
          controller: contactNumberController,
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
            labelText: 'Contact Number',
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value != null && value.length != 10) {
              return 'Enter a valid contact number';
            } else {
              return null;
            }
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          enabled: !loading,
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
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your date of birth';
            }
          },
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
            enabled: !loading,
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
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your instagram handle';
              } else {
                return null;
              }
            }),
        const SizedBox(height: 20),
        TextFormField(
            enabled: !loading,
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
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your address';
              } else {
                return null;
              }
            }),
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
        TextFormField(
            enabled: !loading,
            controller: modelingSchoolController,
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
              labelText: 'Modeling School & coach number (N/A if non)',
            ),
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your modeling school';
              } else {
                return null;
              }
            }),
        const SizedBox(height: 20),
        TextFormField(
            enabled: !loading,
            controller: tShirtSizeController,
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
              labelText: 'T-Shirt Size',
            ),
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your t-shirt size';
              } else {
                return null;
              }
            }),
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
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        enabled: !loading,
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          } else {
                            return null;
                          }
                        }),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: TextFormField(
                        controller: lastNameController,
                        enabled: !loading,
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your last name';
                          } else {
                            return null;
                          }
                        }),
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
                      enabled: !loading,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter a valid email'
                              : null,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: TextFormField(
                      controller: contactNumberController,
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
                        labelText: 'Contact number',
                        enabled: !loading,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value != null && value.length != 10) {
                          return 'Enter valid contact number';
                        } else {
                          return null;
                        }
                      },
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your date of birth';
                        } else {
                          return null;
                        }
                      },
                      enabled: !loading,
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
                          // labelText: 'Instagram Handle',
                          hintText: 'Instagram Handle',
                        ),
                        keyboardType: TextInputType.text,
                        enabled: !loading,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your instagram handle';
                          } else {
                            return null;
                          }
                        }),
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
                      enabled: !loading,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your address';
                        } else {
                          return null;
                        }
                      },
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
            if (!Responsive.isMobile(context)) const SizedBox(height: 20),
            if (!Responsive.isMobile(context))
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        enabled: !loading,
                        controller: modelingSchoolController,
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
                          labelText:
                              'Modeling School & coach number (N/A if non)',
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your modeling school';
                          } else {
                            return null;
                          }
                        }),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        enabled: !loading,
                        controller: tShirtSizeController,
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
                          labelText: 'T-Shirt Size',
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your t-shirt size';
                          } else {
                            return null;
                          }
                        }),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            Center(
              child: CheckboxListTile(
                title: const Text('Contestant is under 18'),
                controlAffinity: ListTileControlAffinity.leading,
                value: isUnder18,
                onChanged: (value) {
                  setState(() {
                    isUnder18 = value!;
                  });
                },
                activeColor: AppColors.mainBlue,
                checkColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            if (Responsive.isMobile(context) && isUnder18)
              Column(
                children: [
                  Text(
                    'Guardian Details',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: 40),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                      enabled: !loading,
                      controller: gNameController,
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
                        labelText: 'Guardian Name',
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter guardian name';
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                      enabled: !loading,
                      controller: gSurnameController,
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
                        labelText: 'Guardian Surname',
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter guardian surname';
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                      enabled: !loading,
                      controller: gContactNumberController,
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
                        labelText: 'Guardian Contact Number',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter guardian contact number';
                        } else if (value.length != 10) {
                          return 'Enter valid guardian contact number';
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                    enabled: !loading,
                    controller: gEmailController,
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
                      labelText: 'Guardian Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter a valid email'
                            : null,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            if (!Responsive.isMobile(context) && isUnder18)
              Column(
                children: [
                  Text(
                    'Guardian Details',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: 50),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            enabled: !loading,
                            controller: gNameController,
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
                              labelText: 'Guardian Name',
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter guardian name';
                              } else {
                                return null;
                              }
                            }),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                            enabled: !loading,
                            controller: gSurnameController,
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
                              labelText: 'Guardian Surname',
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter guardian surname';
                              } else {
                                return null;
                              }
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            enabled: !loading,
                            controller: gContactNumberController,
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
                              labelText: 'Guardian Contact Number',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter guardian contact number';
                              } else if (value.length != 10) {
                                return 'Enter valid guardian contact number';
                              } else {
                                return null;
                              }
                            }),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          enabled: !loading,
                          controller: gEmailController,
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
                            labelText: 'Guardian Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                        ),
                      ),
                    ],
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
                          if (fLphotoErr != null)
                            Text(
                              fLphotoErr!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          if (fLphotoErr != null) const SizedBox(height: 10),
                          Text(
                            'Full Length Photo',
                            style: Theme.of(context).textTheme.bodyText1!,
                            // .copyWith(fontSize: 50),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                              title: 'Select photo', press: selectFLImage),
                          const SizedBox(height: 10),
                          if (fLPhotoWeb != null)
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
                        if (hSphotoErr != null)
                          Text(
                            hSphotoErr!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        if (hSphotoErr != null) const SizedBox(height: 10),
                        Text('Head & Shoulder Photo',
                            style: Theme.of(context).textTheme.bodyText1!
                            // .copyWith(fontSize: 50),
                            ),
                        const SizedBox(height: 20),
                        CustomButton(
                            title: 'Select photo', press: selectHSImage),
                        const SizedBox(height: 10),
                        if (hSPhotoWeb != null)
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
            loading
                ? const SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(color: AppColors.mainBlue),
                  )
                : CustomButton(
                    title: 'Submit Information',
                    press: () {
                      final isValid = formKey.currentState!.validate();

                      if (!isValid) {
                        setState(() => loading = false);
                        return;
                      } else if (fLPhotoWeb == null) {
                        setState(() {
                          fLphotoErr =
                              'Please submit a full length picture of the contestant';
                        });
                        return;
                      } else if (hSPhotoWeb == null) {
                        hSphotoErr =
                            'Please submit a head & sholders picture of the contestant';
                        return;
                      } else if (categoryValue == null) {
                        categoryValErr =
                            'Please select an appropriate category';
                        return;
                      } else if (nameController.text.isEmpty ||
                          lastNameController.text.isEmpty ||
                          istaHandelController.text.isEmpty ||
                          addressController.text.isEmpty ||
                          dOBController.text.isEmpty) {
                        return;
                      } else {
                        submitForm(context, size);
                      }
                    },
                  ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuCategoryItem(String item) =>
      DropdownMenuItem(value: item, child: Text(item));

  void showCustomDialog(BuildContext regContext, Size size) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check, size: 70, color: AppColors.mainBlue),
                  const Text(
                    'Thanks for entering!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'You have successfully entered, We will be in contact with you!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                      title: 'Close',
                      press: () {
                        Navigator.of(context).pop();
                        Get.offAllNamed(AppRoutes.homeRoute);
                      }),
                ],
              ),
            ),
          );
        },
      );
}
