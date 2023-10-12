import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/models/users.dart';
import 'package:aqua_meal/widgets/build_custom_button.dart';
import 'package:aqua_meal/widgets/build_custom_circular_image_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyDialog extends StatefulWidget {
  const MyDialog({super.key});

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  bool isCompaintSubmitted = false;
  bool isLoading = false;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: isCompaintSubmitted
          ? SizedBox(
              height: getProportionateScreenHeight(70),
              width: getProportionateScreenWidth(70),
              child: SvgPicture.asset(
                "assets/images/tick.svg",
                fit: BoxFit.fitHeight,
                color: Colors.green,
              ),
            )
          : Row(
              children: [
                Icon(
                  Icons.question_mark_rounded,
                  color: Colors.red,
                  size: getProportionateScreenHeight(50),
                ),
                SizedBox(width: getProportionateScreenWidth(5)),
                Flexible(
                  child: Text(
                    "Register your Complaint",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
      content: isCompaintSubmitted
          ? Column(
              children: [
                Text(
                  "Complaint Registered",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: getProportionateScreenWidth(20),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  "Your complaint registered sucessfully, will resolve your issue within 48 working hours. Thank You.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                Column(
                  children: [
                    Form(
                      key: key,
                      child: Column(
                        children: [
                          SizedBox(height: getProportionateScreenHeight(10)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Title",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(15),
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 3,
                                ),
                              ),
                              SizedBox(height: getProportionateScreenHeight(5)),
                              TextFormField(
                                controller: titleController,
                                keyboardType: TextInputType.text,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                enabled: !isLoading,
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(15)),
                                cursorColor: context.isLightMode
                                    ? Theme.of(context).primaryColor
                                    : whiteColor,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your complaint title";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter your complaint title",
                                  errorMaxLines: 2,
                                  border:
                                      buildCustomOutlineInputBorder(context),
                                  enabledBorder:
                                      buildCustomOutlineInputBorder(context),
                                  focusedBorder:
                                      buildCustomOutlineInputBorder(context),
                                  disabledBorder:
                                      buildCustomOutlineInputBorder(context),
                                  isDense: true,
                                  filled: true,
                                  fillColor: context.isLightMode
                                      ? whiteColor.withOpacity(0.35)
                                      : whiteColor.withOpacity(0.3),
                                  contentPadding: EdgeInsets.only(
                                    top: getProportionateScreenHeight(10),
                                    bottom: getProportionateScreenHeight(10),
                                    left: getProportionateScreenWidth(13),
                                    right: getProportionateScreenWidth(13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "DESCRIPTION",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(15),
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 3,
                                ),
                              ),
                              SizedBox(height: getProportionateScreenHeight(5)),
                              TextFormField(
                                controller: descriptionController,
                                keyboardType: TextInputType.text,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                enabled: !isLoading,
                                maxLines: 5,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your complaint description";
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(15)),
                                cursorColor: context.isLightMode
                                    ? Theme.of(context).primaryColor
                                    : whiteColor,
                                decoration: InputDecoration(
                                  hintText: "Enter your complaint description",
                                  errorMaxLines: 2,
                                  border:
                                      buildCustomOutlineInputBorder(context),
                                  enabledBorder:
                                      buildCustomOutlineInputBorder(context),
                                  focusedBorder:
                                      buildCustomOutlineInputBorder(context),
                                  disabledBorder:
                                      buildCustomOutlineInputBorder(context),
                                  isDense: true,
                                  filled: true,
                                  fillColor: context.isLightMode
                                      ? whiteColor.withOpacity(0.35)
                                      : whiteColor.withOpacity(0.3),
                                  contentPadding: EdgeInsets.only(
                                    top: getProportionateScreenHeight(10),
                                    bottom: getProportionateScreenHeight(10),
                                    left: getProportionateScreenWidth(13),
                                    right: getProportionateScreenWidth(13),
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: isCompaintSubmitted,
                                  child: Text("$isCompaintSubmitted")),
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(10)),
                        ],
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: isLoading,
                  child: SizedBox(
                    height: getProportionateScreenHeight(200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        LoadingIcon(),
                      ],
                    ),
                  ),
                )
              ],
            ),
      actions: isCompaintSubmitted
          ? [
              BuildSmallButton(
                text: "Ok",
                backgroundcolor: Colors.green.withOpacity(0.7),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]
          : [
              BuildSmallButton(
                text: "Cancel",
                backgroundcolor: isLoading == true
                    ? Colors.red.withOpacity(0.3)
                    : Colors.red.withOpacity(0.7),
                onPressed: isLoading == true
                    ? () {}
                    : () {
                        Navigator.of(context).pop();
                      },
              ),
              BuildSmallButton(
                text: "Submit",
                backgroundcolor: isLoading == true
                    ? Colors.green.withOpacity(0.3)
                    : Colors.green.withOpacity(0.7),
                onPressed: isLoading == true
                    ? () {}
                    : () async {
                        bool isValidated = key.currentState!.validate();
                        if (isValidated) {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await Future.delayed(const Duration(seconds: 1));
                            FirebaseFirestore.instance
                                .collection("complaints")
                                .add({
                              "title": titleController.text,
                              "description": descriptionController.text,
                              "createdDate": DateTime.now(),
                              "complainerID": Users.getUserId,
                              "from": 0, //0 indicates buyer
                              "status": 0, //0 indicates unresolved
                            });
                            setState(() {
                              isLoading = false;
                            });
                            setState(() {
                              isCompaintSubmitted = true;
                            });
                          } on FirebaseException catch (e) {
                            Navigator.pop(context);
                            GlobalMethods().showErrorMessage(
                              context: context,
                              title: e.code,
                              description: e.message,
                              buttonText: "OK",
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            );
                          } catch (e) {
                            Navigator.pop(context);
                            GlobalMethods().showErrorMessage(
                              context: context,
                              title: "Unexpected Error",
                              description: e.toString(),
                              buttonText: "OK",
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            );
                          }
                        }
                      },
              ),
            ],
      elevation: 0,
      scrollable: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsPadding: EdgeInsets.only(bottom: getProportionateScreenHeight(10)),
      contentPadding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(10),
          horizontal: getProportionateScreenWidth(24)),
    );
  }
}
