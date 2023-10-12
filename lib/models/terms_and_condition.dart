import 'package:flutter/cupertino.dart';

class TermsAndConditionModel with ChangeNotifier {
  final String? docID;
  final String? title;
  final String? descrition;

  TermsAndConditionModel({
    this.docID,
    this.title,
    this.descrition,
  });

  factory TermsAndConditionModel.fromMap(
      Map<String, dynamic> map, String? docID) {
    return TermsAndConditionModel(
      docID: docID,
      title: map["title"],
      descrition: map["description"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": descrition,
    };
  }
}
