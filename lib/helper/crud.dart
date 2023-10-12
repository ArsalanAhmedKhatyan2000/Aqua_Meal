import 'dart:io';
import 'package:path/path.dart';
import 'package:aqua_meal/helper/preferences.dart';
import 'package:aqua_meal/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CRUD {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storageInstance = FirebaseStorage.instance;

  FirebaseAuth get getAuthInstance => _auth;
  Future<void> createUserWithUploadData({
    String? email,
    String? name,
    String? confirmPassword,
    String? address,
    String? phoneNumber,
    DateTime? userCreatedDate,
  }) async {
    await _auth
        .createUserWithEmailAndPassword(
            email: email!, password: confirmPassword!)
        .then((value) async {
      String userID = value.user!.uid;
      await _db
          .collection("users")
          .doc("WvamEGwHsbNkF3KImk2V")
          .collection("buyer")
          .doc(userID)
          .set({
        "id": userID,
        "profileImage": "",
        "name": name,
        "email": email,
        "password": confirmPassword,
        "phoneNumber": phoneNumber,
        "address": address,
        "createdDate": userCreatedDate,
        "wishlist": [],
        "cartList": [],
        "status": 0,
      });
    });
  }

  Future<UserCredential> signInUser({
    String? email,
    String? password,
  }) async {
    final UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email!, password: password!);
    return user;
  }

  Future<void> signoutUser() async {
    await SharedPreferencesHelper().removeAuthToken();
    await _auth.signOut();
  }

  fetchUserCredentials({
    String? userID,
  }) async {
    DocumentSnapshot<Map<String, dynamic>> query = await _db
        .collection("users")
        .doc("WvamEGwHsbNkF3KImk2V")
        .collection("buyer")
        .doc(userID)
        .get();
    Map<String, dynamic>? userDataMap = query.data();
    Users.fromMap(map: userDataMap!);
  }

  Future<String?> uploadUserImageToStorage({required String? imagePath}) async {
    File imageFile = File(imagePath!);
    String imageBaseName = basename(imageFile.path);
    Reference imageReference = _storageInstance
        .ref()
        .child("images")
        .child("buyer")
        .child(Users.getUserId!)
        .child("userProfileImage")
        .child(imageBaseName);
    await imageReference.putFile(imageFile);
    String getImageUrl = await imageReference.getDownloadURL();
    return getImageUrl;
  }

  Future<void> updateUserProfileImageDataToFirestore(
      {required String? imageURL}) async {
    await _db
        .collection("users")
        .doc("WvamEGwHsbNkF3KImk2V")
        .collection("buyer")
        .doc(Users.getUserId)
        .update({
      "profileImage": imageURL,
    });
  }

  Future<void> deleteUserProfileImageFromStorage(
      {required String? imageURL}) async {
    String? imageName = imageURL!.split('2F')[4].split('?alt')[0];
    await _storageInstance
        .ref()
        .child("images")
        .child("buyer")
        .child(Users.getUserId!)
        .child("userProfileImage")
        .child(imageName)
        .delete();
  }

  Future<void> updateUserProfileDataFieldToFirestore(
      {required String? fieldName, required String? fieldValue}) async {
    await _db
        .collection("users")
        .doc("WvamEGwHsbNkF3KImk2V")
        .collection("buyer")
        .doc(Users.getUserId)
        .update({
      fieldName!: fieldValue,
    });
  }

  Future<void> updatePasswordToAuth({String? newPassword}) async {
    await _auth.currentUser!.updatePassword(newPassword!);
  }

  Future<void> reAuthenticateCurrentUser() async {
    await _auth.currentUser!.reauthenticateWithCredential(
        EmailAuthProvider.credential(
            email: Users.getEmail!, password: Users.getPassword!));
  }

  Future<void> updateEmailToAuth({String? newEmail}) async {
    await _auth.currentUser!.updateEmail(newEmail!);
  }

  Future<void> emailVerificationSend({String? newEmail}) async {
    await _auth.currentUser!.sendEmailVerification();
  }

  bool isEmailVerified() {
    return _auth.currentUser!.emailVerified;
  }

  Future<void> reloadUser() async {
    return await _auth.currentUser!.reload();
  }
}
