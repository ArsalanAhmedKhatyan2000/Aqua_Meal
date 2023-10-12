import 'dart:async';
import 'dart:io';
import 'package:aqua_meal/helper/crud.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/helper/validations.dart';
import 'package:aqua_meal/models/users.dart';
import 'package:aqua_meal/screens/my_profile/build_custom_tile.dart';
import 'package:aqua_meal/screens/my_profile/components/circular_file_image.dart';
import 'package:aqua_meal/screens/my_profile/components/circular_netword_image.dart';
import 'package:aqua_meal/screens/my_profile/components/circular_no_image_widget.dart';
import 'package:aqua_meal/screens/my_profile/components/custom_bottom_modal_sheet.dart';
import 'package:aqua_meal/widgets/build_custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatefulWidget {
  static const String routeName = "/MyProfile";
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneNumberController;
  TextEditingController? _addressController;
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneNoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _addressFormKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  String? _imagePath = "";
  File? _selectedImageFile;

  String? _currentName,
      _currentEmail,
      _currentPhoneNumber,
      _currentAddress,
      _currentProfileNetworkImageURL,
      _duplicateProfileNetworkImageURL;

  String? currentPassword;
  String? passwordSterric;

  bool? _isEmailVarified = false;
  Timer? timer;

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _currentProfileNetworkImageURL = Users.getProfileImageURL ?? "";
    _duplicateProfileNetworkImageURL = _currentProfileNetworkImageURL;
    _currentName = Users.getName ?? "";
    _currentEmail = Users.getEmail ?? "";
    _currentPhoneNumber = Users.getPhoneNumber ?? "";
    _currentAddress = Users.getAddress ?? "";
    currentPassword = Users.getPassword ?? "";
    _nameController = TextEditingController(text: _currentName);
    _emailController = TextEditingController(text: _currentEmail);
    _phoneNumberController = TextEditingController(text: _currentPhoneNumber);
    _addressController = TextEditingController(text: _currentAddress);
    passwordSterric = createPasswordStaric(password: currentPassword);
    final User? user = CRUD().getAuthInstance.currentUser;
    if (user == null) {
      _isEmailVarified = false;
    } else {
      _isEmailVarified = CRUD().isEmailVerified();
    }
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (user == null) {
      } else {
        checkIsEmailVerified();
      }
    });
  }

  checkIsEmailVerified() async {
    CRUD crud = CRUD();
    await crud.reloadUser();
    setState(() {
      _isEmailVarified = crud.isEmailVerified();
    });
    if (_isEmailVarified!) {
      timer!.cancel();
    }
  }

  String? createPasswordStaric({String? password}) {
    int passwordLength = password!.length;
    String? stars = "";
    for (var i = 0; i < passwordLength; i++) {
      stars = "${stars!}*";
    }
    return stars;
  }

  pickImage({ImageSource? imageSource}) async {
    final imageFile = await _picker.pickImage(source: imageSource!);
    setState(() {
      _selectedImageFile = File(imageFile!.path);
      _imagePath = imageFile.path;
    });
  }

  updateProfileImage() async {
    if (_imagePath != "") {
      GlobalMethods().showIconLoading(context: context);
      try {
        CRUD crud = CRUD();
        String? newProfileImageURL =
            await crud.uploadUserImageToStorage(imagePath: _imagePath);
        await crud.updateUserProfileImageDataToFirestore(
            imageURL: newProfileImageURL);
        if (_currentProfileNetworkImageURL != "" ||
            _currentProfileNetworkImageURL!.isNotEmpty) {
          await crud.deleteUserProfileImageFromStorage(
              imageURL: _currentProfileNetworkImageURL);
        }
        Users.setprofileImage(newProfileImage: newProfileImageURL);
        setState(() {
          _currentProfileNetworkImageURL = newProfileImageURL;
          _duplicateProfileNetworkImageURL = newProfileImageURL;
        });
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } on FirebaseException catch (e) {
        setState(() {
          _currentProfileNetworkImageURL = _duplicateProfileNetworkImageURL;
          _imagePath = "";
          _selectedImageFile = null;
        });
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        GlobalMethods().showErrorMessage(
          context: context,
          title: e.code,
          description: e.message,
          buttonText: "OK",
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      } catch (e) {
        setState(() {
          _currentProfileNetworkImageURL = _duplicateProfileNetworkImageURL;
          _imagePath = "";
          _selectedImageFile = null;
        });
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        GlobalMethods().showErrorMessage(
          context: context,
          title: "Unexpected Error",
          description: e.toString(),
          buttonText: "OK",
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      }
    } else {
      Navigator.pop(context);
    }
  }

  Widget changeProfileImageBottomSheet() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(getProportionateScreenWidth(20)),
          topLeft: Radius.circular(getProportionateScreenWidth(20)),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(getProportionateScreenWidth(20)),
            topLeft: Radius.circular(getProportionateScreenWidth(20)),
          ),
        ),
        padding: EdgeInsets.only(
          right: getProportionateScreenWidth(20),
          left: getProportionateScreenWidth(20),
          top: getProportionateScreenHeight(20),
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: getProportionateScreenHeight(20),
          ),
          child: Wrap(
            runSpacing: getProportionateScreenWidth(10),
            children: [
              Text(
                "Choose Profile Photo",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: getProportionateScreenWidth(17),
                ),
              ),
              Row(
                children: [
                  TextButton.icon(
                    icon: const Icon(
                      Icons.camera,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      pickImage(imageSource: ImageSource.camera);
                    },
                    label: Text(
                      "Camera",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenWidth(15),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    icon: const Icon(
                      Icons.photo,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      pickImage(imageSource: ImageSource.gallery);
                    },
                    label: Text(
                      "Gallery",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenWidth(15),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BuildSmallButton(
                    text: "CANCEL",
                    onPressed: () {
                      setState(() {
                        _imagePath = "";
                        _selectedImageFile = null;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  BuildSmallButton(
                    text: "SAVE",
                    onPressed: () async {
                      updateProfileImage();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileImageWidget() {
    return Center(
      child: Stack(
        children: [
          (_selectedImageFile != null)
              ? CircularFileImage(selectedImageFile: _selectedImageFile)
              : (_currentProfileNetworkImageURL!.isNotEmpty)
                  ? CircularNetworkImage(
                      imageURL: _currentProfileNetworkImageURL)
                  : const CircularNoImageWidget(
                      icon: Icons.person_outline_rounded),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  isDismissible: false,
                  builder: (builder) => changeProfileImageBottomSheet(),
                );
              },
              child: Container(
                width: getProportionateScreenWidth(50),
                height: getProportionateScreenWidth(50),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  updateUserName({required BuildContext? contextt}) async {
    final FormState key = _nameFormKey.currentState!;
    bool isValidated = FieldValidations.validationOnButton(formKey: key);
    String? newName = _nameController!.text.trim();
    if (isValidated == true) {
      if (newName != _currentName) {
        GlobalMethods().showIconLoading(context: context);
        try {
          await CRUD().updateUserProfileDataFieldToFirestore(
            fieldName: "name",
            fieldValue: newName,
          );
          Users.setName(newName: newName);
          setState(() {
            _currentName = newName;
            _nameController!.text = newName;
          });
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } on FirebaseException catch (e) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          GlobalMethods().showErrorMessage(
            context: context,
            title: e.code,
            description: e.message,
            buttonText: "OK",
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        } catch (e) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          GlobalMethods().showErrorMessage(
            context: context,
            title: "Unexpected Error",
            description: e.toString(),
            buttonText: "OK",
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        }
      }
    } else {
      setState(() {
        _nameController!.text = Users.getName!;
      });
    }
  }

  updateEmail({required BuildContext? contextt}) async {
    final FormState? _key = _emailFormKey.currentState!;
    bool isValidated = FieldValidations.validationOnButton(formKey: _key);
    String? _newEmail = _emailController!.text;
    if (isValidated == true) {
      if (_newEmail != _currentEmail) {
        GlobalMethods().showIconLoading(context: context);
        try {
          CRUD crud = CRUD();
          await crud.reAuthenticateCurrentUser();
          await crud.updateEmailToAuth(newEmail: _newEmail);
          await crud.updateUserProfileDataFieldToFirestore(
            fieldName: "email",
            fieldValue: _newEmail,
          );
          Users.setEmail(newEmail: _newEmail);
          setState(() {
            _currentEmail = _newEmail;
            _emailController!.text = _newEmail;
          });
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } on FirebaseException catch (e) {
          Navigator.popUntil(context, (route) => route.isFirst);
          GlobalMethods().showErrorMessage(
            context: context,
            title: e.code,
            description: e.message,
            buttonText: "OK",
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        } catch (e) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          GlobalMethods().showErrorMessage(
            context: context,
            title: "Unexpected Error",
            description: e.toString(),
            buttonText: "OK",
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        }
      } else {}
    } else {
      setState(() {
        _emailController!.text = Users.getEmail!;
      });
    }
  }

  updateUserPassword({required BuildContext? contextt}) async {
    final FormState key = _passwordFormKey.currentState!;
    bool isValidated = FieldValidations.validationOnButton(formKey: key);
    String? oldPassword = _oldPasswordController.text;
    String? newPassword = _newPasswordController.text;
    if (isValidated == true) {
      if (newPassword != currentPassword) {
        GlobalMethods().showIconLoading(context: context);
        try {
          CRUD crud = CRUD();
          await crud.reAuthenticateCurrentUser();
          await crud.updatePasswordToAuth(newPassword: newPassword);
          await crud.updateUserProfileDataFieldToFirestore(
            fieldName: "password",
            fieldValue: newPassword,
          );
          Users.setPassword(newPassword: newPassword);
          setState(() {
            currentPassword = newPassword;
            passwordSterric = createPasswordStaric(password: currentPassword);
            _oldPasswordController.clear();
            _newPasswordController.clear();
          });

          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } on FirebaseException catch (e) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          GlobalMethods().showErrorMessage(
            context: context,
            title: e.code,
            description: e.message,
            buttonText: "OK",
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        } catch (e) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          GlobalMethods().showErrorMessage(
            context: context,
            title: "Unexpected Error",
            description: e.toString(),
            buttonText: "OK",
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        }
      }
    }
  }

  updateUserPhoneNumber({required BuildContext? contextt}) async {
    final FormState key = _phoneNoFormKey.currentState!;
    bool isValidated = FieldValidations.validationOnButton(formKey: key);
    String? newPhoneNumber = _phoneNumberController!.text;
    if (isValidated == true) {
      if (newPhoneNumber != _currentPhoneNumber) {
        GlobalMethods().showIconLoading(context: context);
        try {
          await CRUD().updateUserProfileDataFieldToFirestore(
            fieldName: "phoneNumber",
            fieldValue: newPhoneNumber,
          );
          Users.setPhoneNumber(newPhoneNumber: newPhoneNumber);
          setState(() {
            _currentPhoneNumber = newPhoneNumber;
            _phoneNumberController!.text = newPhoneNumber;
          });
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } on FirebaseException catch (e) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          GlobalMethods().showErrorMessage(
            context: context,
            title: e.code,
            description: e.message,
            buttonText: "OK",
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        } catch (e) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          GlobalMethods().showErrorMessage(
            context: context,
            title: "Unexpected Error",
            description: e.toString(),
            buttonText: "OK",
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        }
      }
    } else {
      setState(() {
        _phoneNumberController!.text = Users.getPhoneNumber!;
      });
    }
  }

  updateUserAddress({required BuildContext? contextt}) async {
    final FormState key = _addressFormKey.currentState!;
    bool isValidated = FieldValidations.validationOnButton(formKey: key);
    String? newAddress = _addressController!.text;
    if (isValidated == true) {
      if (newAddress != _currentAddress) {
        GlobalMethods().showIconLoading(context: context);
        try {
          await CRUD().updateUserProfileDataFieldToFirestore(
            fieldName: "address",
            fieldValue: newAddress,
          );
          Users.setAddress(newAddress: newAddress);
          setState(() {
            _currentAddress = newAddress;
            _addressController!.text = newAddress;
          });
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } on FirebaseException catch (e) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          GlobalMethods().showErrorMessage(
            context: context,
            title: e.code,
            description: e.message,
            buttonText: "OK",
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        } catch (e) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          GlobalMethods().showErrorMessage(
            context: context,
            title: "Unexpected Error",
            description: e.toString(),
            buttonText: "OK",
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        }
      }
    } else {
      setState(() {
        _addressController!.text = Users.getAddress!;
      });
    }
  }

  emailVerification({BuildContext? contextt}) async {
    try {
      await CRUD().emailVerificationSend().then((value) {
        GlobalMethods().showSnackbar(
          context: contextt,
          message:
              "The email verification link has been sent to ${Users.getEmail}",
        );
      });
    } on FirebaseException catch (e) {
      Navigator.popUntil(context, (route) => route.isFirst);
      GlobalMethods().showErrorMessage(
        context: context,
        title: e.code,
        description: e.message,
        buttonText: "OK",
        onPressed: () {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      );
    } catch (e) {
      Navigator.popUntil(context, (route) => route.isFirst);
      GlobalMethods().showErrorMessage(
        context: context,
        title: "Unexpected Error",
        description: e.toString(),
        buttonText: "OK",
        onPressed: () {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      bottom: false,
      top: true,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text(
            "My Profile",
            style: TextStyle(fontSize: getProportionateScreenWidth(20)),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(0)),
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),
                profileImageWidget(),
                SizedBox(height: getProportionateScreenHeight(20)),
                Column(
                  children: [
                    BuildCustomTile(
                      title: "Name",
                      subTitle: _currentName,
                      leadingIcon: Icons.person,
                      trailingIcon: Icons.edit,
                      onTap: () {
                        customBottomModalSheet(
                          context: context,
                          title: "Change Name",
                          controller: _nameController,
                          inputType: TextInputType.name,
                          hintText: "Enter your name",
                          prefixIcon: Icons.person_outline_rounded,
                          formKey: _nameFormKey,
                          validator: (value) {
                            return FieldValidations.isName(
                              value: value,
                              isProfileScreenName: true,
                              currentName: _currentName,
                            );
                          },
                          onCancel: () {
                            Navigator.pop(context);
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) {
                              setState(() {
                                _nameController!.text = _currentName!;
                              });
                            });
                          },
                          onSave: () {
                            updateUserName(contextt: context);
                          },
                        );
                      },
                    ),
                    BuildCustomTile(
                      title: "Email",
                      subTitle: _currentEmail,
                      leadingIcon: Icons.email_rounded,
                      trailingIcon: Icons.edit,
                      isEmail: true,
                      isEmailVerified: _isEmailVarified,
                      emailVerificationOnTap: () {
                        emailVerification(contextt: context);
                      },
                      onTap: () {
                        customBottomModalSheet(
                          context: context,
                          title: "Change Email",
                          controller: _emailController,
                          inputType: TextInputType.emailAddress,
                          hintText: "Enter your email",
                          prefixIcon: Icons.email_outlined,
                          formKey: _emailFormKey,
                          validator: (value) {
                            return FieldValidations.isEmail(
                              value: value,
                              isProfileScreenEmail: true,
                              currentEmail: _currentEmail,
                            );
                          },
                          onCancel: () {
                            Navigator.pop(context);
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) {
                              setState(() {
                                _emailController!.text = _currentEmail!;
                              });
                            });
                          },
                          onSave: () {
                            updateEmail(contextt: context);
                          },
                        );
                      },
                    ),
                    BuildCustomTile(
                      title: "Password",
                      subTitle: passwordSterric,
                      leadingIcon: Icons.lock,
                      trailingIcon: Icons.edit,
                      onTap: () {
                        customBottomModalSheet(
                          context: context,
                          title: "Change Password",
                          controller: _oldPasswordController,
                          controllerSecondPass: _newPasswordController,
                          isPass: true,
                          hight: 325,
                          inputType: TextInputType.text,
                          hintText: "Enter your old password",
                          prefixIcon: Icons.lock_outline_rounded,
                          formKey: _passwordFormKey,
                          validator: (value) {
                            return FieldValidations.isCurrentPassword(
                              value: value,
                              currentPassword: currentPassword,
                            );
                          },
                          validatorSecondPass: (value) {
                            return FieldValidations.isCurrentPassword(
                              value: value,
                              isNewPassword: true,
                              currentPassword: currentPassword,
                            );
                          },
                          onCancel: () {
                            Navigator.pop(context);
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) {
                              setState(() {
                                _oldPasswordController.clear();
                                _newPasswordController.clear();
                              });
                            });
                          },
                          onSave: () {
                            updateUserPassword(contextt: context);
                          },
                        );
                      },
                    ),
                    BuildCustomTile(
                      title: "Phone Number",
                      subTitle: _currentPhoneNumber,
                      leadingIcon: Icons.phone,
                      trailingIcon: Icons.edit,
                      onTap: () {
                        customBottomModalSheet(
                          context: context,
                          title: "Change Phone Number",
                          controller: _phoneNumberController,
                          inputType: TextInputType.number,
                          hintText: "Enter your phone number",
                          prefixIcon: Icons.phone_outlined,
                          formKey: _phoneNoFormKey,
                          validator: (value) {
                            return FieldValidations.isPhoneNumber(
                              value: value,
                              isProfileScreenPhone: true,
                              currentPhoneNumber: _currentPhoneNumber,
                            );
                          },
                          onCancel: () {
                            Navigator.pop(context);
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) {
                              setState(() {
                                _phoneNumberController!.text =
                                    _currentPhoneNumber!;
                              });
                            });
                          },
                          onSave: () {
                            updateUserPhoneNumber(
                              contextt: context,
                            );
                          },
                        );
                      },
                    ),
                    BuildCustomTile(
                      title: "Address",
                      subTitle: _currentAddress,
                      leadingIcon: Icons.person_pin_circle_rounded,
                      trailingIcon: Icons.edit,
                      onTap: () {
                        customBottomModalSheet(
                          context: context,
                          title: "Change Address",
                          controller: _addressController,
                          inputType: TextInputType.text,
                          hintText: "Enter your address",
                          prefixIcon: Icons.person_pin_circle_outlined,
                          formKey: _addressFormKey,
                          validator: (value) {
                            return FieldValidations.isAddress(
                              value: value,
                              isProfileScreenAddress: true,
                              currentAddress: _currentAddress,
                            );
                          },
                          onCancel: () {
                            Navigator.pop(context);
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) {
                              setState(() {
                                _addressController!.text = _currentAddress!;
                              });
                            });
                          },
                          onSave: () {
                            updateUserAddress(contextt: context);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
