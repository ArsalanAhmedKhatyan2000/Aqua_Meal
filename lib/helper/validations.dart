import 'package:flutter/material.dart';

class FieldValidations {
  static bool validationOnButton({FormState? formKey}) {
    if (formKey!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  static String? isEmail({
    String? value,
    bool? isProfileScreenEmail = false,
    String? currentEmail = "",
  }) {
    String fieldValue = value.toString().trim();

    const String regexPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regExp = RegExp(regexPattern);

    if (fieldValue.isEmpty) {
      return "Please enter your email address";
    } else if (!regExp.hasMatch(fieldValue)) {
      return "Invalid Email Address";
    } else if (fieldValue == currentEmail && isProfileScreenEmail == true) {
      return "This email is already exists.";
    }

    return null;
  }

  static String? isPassword({String? value}) {
    String fieldValue = value.toString().trim();
    if (fieldValue.isEmpty) {
      return "Please enter your password";
    } else if (fieldValue.length < 6) {
      return "Password can't be less than 6 characters";
    } else if (fieldValue.length > 15) {
      return "Password can't be greater than 15 characters";
    }
    return null;
  }

  static String? isCurrentPassword({
    String? value,
    String? currentPassword,
    bool? isNewPassword = false,
  }) {
    String fieldValue = value.toString().trim();
    if (fieldValue.isEmpty) {
      return "Please enter your password";
    } else if (fieldValue.length < 6) {
      return "Password can't be less than 6 characters";
    } else if (fieldValue.length > 15) {
      return "Password can't be greater than 15 characters";
    } else if (currentPassword != fieldValue && isNewPassword == false) {
      return "Please enter correct password";
    } else if (isNewPassword == true && currentPassword == fieldValue) {
      return "Please enter new password, old and entered is same.";
    }
    return null;
  }

  static String? isPhoneNumber({
    String? value,
    bool? isProfileScreenPhone = false,
    String? currentPhoneNumber = "",
  }) {
    String fieldValue = value.toString().trim();
    const String regexPattern = r'(^[0][3][0-9]{9}$)';
    final RegExp regExp = RegExp(regexPattern);
    if (fieldValue.isEmpty) {
      return "Please enter your phone number";
    } else if (fieldValue.length > 11 ||
        fieldValue.length < 11 ||
        fieldValue.length != 11) {
      return "Invalid phone number";
    } else if (!regExp.hasMatch(fieldValue)) {
      return "Invalid phone number, please follow 03XXXXXXXXX";
    } else if (fieldValue == currentPhoneNumber &&
        isProfileScreenPhone == true) {
      return "This Phone number is already exists.";
    }
    return null;
  }

  static String? isRegularPrice({String? value}) {
    String fieldValue = value.toString().trim();
    // const String regexPattern = r'(^\d*\.?\d{0,2}?$)';
    const String regexPattern = r'(^\d{1,4}$)';
    final RegExp regExp = RegExp(regexPattern);
    if (fieldValue.isEmpty) {
      return "Empty field";
    } else if (double.parse(fieldValue) <= 0) {
      return "Invalid price";
    } else if (!regExp.hasMatch(fieldValue)) {
      return "Invalid price";
    }
    return null;
  }

  static String? isDiscountedPrice(
      {String? value, required String regularPrice}) {
    String fieldValue = value.toString().trim();
    const String regexPattern = r'(^\d{0,4}$)';
    final RegExp regExp = RegExp(regexPattern);
    if (fieldValue.isEmpty) {
      return null;
    }
    // else
    if (double.parse(regularPrice) <= 0) {
      return "Invalid price";
    } else if (double.parse(fieldValue) >= double.parse(regularPrice)) {
      return "High price";
    } else if (!regExp.hasMatch(fieldValue)) {
      return "Invalid price";
    }
    return null;
  }

  static String? isCNIC({String? value}) {
    String fieldValue = value.toString().trim();
    if (fieldValue.isEmpty) {
      return "Please enter your CNIC number";
    } else if (fieldValue.length > 13 ||
        fieldValue.length < 13 ||
        fieldValue.length != 13) {
      return "Invalid CNIC number";
    }
    return null;
  }

  static String? isName({
    String? value,
    bool? isProfileScreenName = false,
    String? currentName = "",
  }) {
    String fieldValue = value.toString().trim();
    const String regexPattern = r'[a-zA-Z]';
    final RegExp regExp = RegExp(regexPattern);
    if (fieldValue.isEmpty) {
      return "Please enter your name";
    } else if (!regExp.hasMatch(fieldValue)) {
      return "Invalid name";
    } else if (fieldValue == currentName && isProfileScreenName == true) {
      return "This name is already exists.";
    }
    return null;
  }

  static String? isAddress({
    String? value,
    bool? isProfileScreenAddress = false,
    String? currentAddress = "",
  }) {
    String fieldValue = value.toString().trim();
    if (fieldValue.isEmpty) {
      return "Please enter your Address";
    } else if (fieldValue == currentAddress && isProfileScreenAddress == true) {
      return "This address is already exists.";
    }
    return null;
  }
}
