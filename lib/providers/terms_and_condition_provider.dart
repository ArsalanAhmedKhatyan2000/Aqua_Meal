import 'package:aqua_meal/models/terms_and_condition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TermsAndConditionProvider with ChangeNotifier {
  List<TermsAndConditionModel> _termsAndConditionList = [];

  List<TermsAndConditionModel> get getTermsAndConditionList =>
      _termsAndConditionList;

  Future<void> fetchTermsAndCondition() async {
    await FirebaseFirestore.instance
        .collection('terms and condition')
        .doc("A5rdERCoEok9xzFQDMge")
        .collection('buyer')
        .where("status", isEqualTo: 1) //1 indicates active state
        .orderBy('title', descending: true)
        .get()
        .then((QuerySnapshot termsAndConditionSnapshot) {
      _termsAndConditionList = [];
      for (var document in termsAndConditionSnapshot.docs) {
        Map<String, dynamic> dataMap = document.data() as Map<String, dynamic>;
        _termsAndConditionList.insert(
          0,
          TermsAndConditionModel.fromMap(dataMap, document.id),
        );
      }
    });
    notifyListeners();
  }
}
