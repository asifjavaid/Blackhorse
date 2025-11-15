import 'package:ekvi/Models/DailyTracker/symptom_categories_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/CustomPainterWidgets/custom_body_parts.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

class ClickableBodyFront extends StatefulWidget {
  const ClickableBodyFront({
    super.key,
  });

  @override
  ClickableBodyFrontState createState() => ClickableBodyFrontState();
}

class ClickableBodyFrontState extends State<ClickableBodyFront> {
  final String imageURL = "${AppConstant.assetImages}body_front.png";

  @override
  Widget build(BuildContext context) {
    return Consumer<DailyTrackerProvider>(
        builder: (context, value, child) => SizedBox(
              height: 550,
              width: 350,
              child: Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      onPanDown: value.categoriesData.bodyPain.editingBodyPartsEnabled
                          ? (details) {
                              BodyPart? bodyPart = frontBodyParts.firstWhereOrNull((part) => part.area!.contains(details.localPosition));
                              value.addSelectedBodyPart(bodyPart);
                            }
                          : null,
                      child: Image.asset(imageURL),
                    ),
                    ...value.categoriesData.bodyPain.selectedBodyParts.map(
                      (selectedPart) => Positioned(
                        left: selectedPart.area!.left,
                        top: selectedPart.area!.top,
                        child: GestureDetector(
                          onTap: value.categoriesData.bodyPain.editingBodyPartsEnabled ? () => value.removeSelectedBodyPart(selectedPart) : null,
                          child: SizedBox(
                            width: selectedPart.area?.width,
                            height: selectedPart.area?.height,
                            child: CustomPaint(
                              painter: returnBodyPart(selectedPart.name!),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}

returnBodyPart(String bodyPartNumber) {
  switch (bodyPartNumber) {
    case "1":
      return PartOne();
    case "2":
      return PartTwo();
    case "3":
      return PartThree();
    case "4":
      return PartFour();
    case "5":
      return PartFive();
    case "6":
      return PartSix();
    case "7":
      return PartSeven();
    case "8":
      return PartEight();
    case "9":
      return PartNine();
    case "10":
      return PartTen();
    case "11":
      return PartEleven();
    case "12":
      return PartTwelve();
    case "13":
      return PartThirteen();
    case "14":
      return PartFourteen();
    case "15":
      return PartFifteen();
    case "16":
      return PartSixteen();
    case "17":
      return PartSeventeen();
    case "18":
      return PartEighteen();
    case "19":
      return PartNineteen();
    case "20":
      return PartTwenty();
    case "21":
      return PartTwentyOne();
    case "22":
      return PartTwentyTwo();
    case "23":
      return PartTwentyThree();
    case "24":
      return PartTwentyFour();
    case "25":
      return PartTwentyFive();
    case "26":
      return PartTwentySix();
    case "27":
      return PartTwentySeven();
    case "28":
      return PartTwentyEight();
    case "29":
      return PartTwentyNine();
    case "30":
      return PartThirty();
    case "31":
      return PartThirtyOne();
    case "33":
      return PartThirtyThree();
    case "34":
      return PartThirtyFour();
    case "35":
      return PartThirtyFive();
    case "36":
      return PartThirtySix();
    case "37":
      return PartThirtySeven();
    case "38":
      return PartThirtyEight();
    case "39":
      return PartThirtyNine();
    case "40":
      return PartFourty();
  }
}

List<BodyPart> frontBodyParts = [
  BodyPart(name: '1', nameForUser: "Left hip", category1: "Pelvic area", area: const Rect.fromLTWH(55, 220, 27, 58), bodySide: BodySide.Front),
  BodyPart(name: '2', nameForUser: "Left inner thigh", category1: "Pelvic area", area: const Rect.fromLTWH(80, 226, 35, 58), bodySide: BodySide.Front),
  BodyPart(name: '3', nameForUser: "Right inner thigh", category1: "Pelvic area", area: const Rect.fromLTWH(118, 226, 35, 58), bodySide: BodySide.Front),
  BodyPart(name: '4', nameForUser: "Right hip", category1: "Pelvic area", area: const Rect.fromLTWH(150, 220, 27, 58), bodySide: BodySide.Front),
  BodyPart(name: '5', nameForUser: "Right upper hip", category1: "Pelvic area", area: const Rect.fromLTWH(147, 196, 26, 30), bodySide: BodySide.Front),
  BodyPart(name: '6', nameForUser: "Right pelvic area", category1: "Pelvic area", area: const Rect.fromLTWH(129, 199, 28, 33), bodySide: BodySide.Front),
  BodyPart(name: '7', nameForUser: "Left pelvic area", category1: "Pelvic area", area: const Rect.fromLTWH(74, 199, 28, 33), bodySide: BodySide.Front),
  BodyPart(name: '8', nameForUser: "Left upper hip", category1: "Pelvic area", area: const Rect.fromLTWH(57, 196, 26, 33), bodySide: BodySide.Front),
  BodyPart(name: '9', nameForUser: "Vulva", category1: "Pelvic area", area: const Rect.fromLTWH(92, 224, 34, 48), bodySide: BodySide.Front),
  BodyPart(name: '10', nameForUser: "Lower pelvis", category1: "Pelvic area", area: const Rect.fromLTWH(100, 205, 32, 20), bodySide: BodySide.Front),
  BodyPart(name: '11', nameForUser: "Left lower abdomen", category1: "Pelvic area", area: const Rect.fromLTWH(65, 184, 33, 20), bodySide: BodySide.Front),
  BodyPart(name: '12', nameForUser: "Middle lower abdomen", category1: "Pelvic area", area: const Rect.fromLTWH(96, 188, 36, 17), bodySide: BodySide.Front),
  BodyPart(name: '13', nameForUser: "Right lower abdomen", category1: "Pelvic area", area: const Rect.fromLTWH(130, 184, 36, 20), bodySide: BodySide.Front),
  BodyPart(name: '14', nameForUser: "Left upper abdomen", category1: "Upper body", area: const Rect.fromLTWH(71, 137, 34, 56), bodySide: BodySide.Front),
  BodyPart(name: '15', nameForUser: "Middle upper abdomen", category1: "Upper body", area: const Rect.fromLTWH(100, 137, 34, 56), bodySide: BodySide.Front),
  BodyPart(name: '16', nameForUser: "Right upper abdomen", category1: "Upper body", area: const Rect.fromLTWH(125, 137, 36, 56), bodySide: BodySide.Front),
  BodyPart(name: '17', nameForUser: "Left breast", category1: "Upper body", area: const Rect.fromLTWH(64, 111, 42, 33), bodySide: BodySide.Front),
  BodyPart(name: '18', nameForUser: "Chest", category1: "Upper body", area: const Rect.fromLTWH(95, 54, 40, 85), bodySide: BodySide.Front),
  BodyPart(name: '19', nameForUser: "Right breast", category1: "Upper body", area: const Rect.fromLTWH(123, 111, 45, 33), bodySide: BodySide.Front),
  BodyPart(name: '20', nameForUser: "Left upper chest", category1: "Upper body", area: const Rect.fromLTWH(63, 66, 46, 48), bodySide: BodySide.Front),
  BodyPart(name: '21', nameForUser: "Right upper chest ", category1: "Upper body", area: const Rect.fromLTWH(121, 66, 46, 48), bodySide: BodySide.Front),
  BodyPart(name: '22', nameForUser: "Right shoulder", category1: "Upper body", area: const Rect.fromLTWH(149, 73, 38, 28), bodySide: BodySide.Front),
  BodyPart(name: '23', nameForUser: "Right upper arm", category1: "Upper body", area: const Rect.fromLTWH(162, 93, 34, 65), bodySide: BodySide.Front),
  BodyPart(name: '24', nameForUser: "Right elbow", category1: "Upper body", area: const Rect.fromLTWH(172, 154, 31, 30), bodySide: BodySide.Front),
  BodyPart(name: '25', nameForUser: "Right lower arm", category1: "Upper body", area: const Rect.fromLTWH(175, 180, 31, 48), bodySide: BodySide.Front),
  BodyPart(name: '26', nameForUser: "Right hand", category1: "Upper body", area: const Rect.fromLTWH(189, 225, 42, 54), bodySide: BodySide.Front),
  BodyPart(name: '27', nameForUser: "Left shoulder", category1: "Upper body", area: const Rect.fromLTWH(45, 73, 38, 28), bodySide: BodySide.Front),
  BodyPart(name: '28', nameForUser: "Left upper arm ", category1: "Upper body", area: const Rect.fromLTWH(35, 93, 34, 65), bodySide: BodySide.Front),
  BodyPart(name: '29', nameForUser: "Left elbow", category1: "Upper body", area: const Rect.fromLTWH(28, 154, 31, 30), bodySide: BodySide.Front),
  BodyPart(name: '30', nameForUser: "Left lower arm", category1: "Upper body", area: const Rect.fromLTWH(25, 180, 31, 48), bodySide: BodySide.Front),
  BodyPart(name: '31', nameForUser: "Left hand", category1: "Upper body", area: const Rect.fromLTWH(0, 225, 42, 54), bodySide: BodySide.Front),
  BodyPart(name: '33', nameForUser: "Left front thigh", category1: "Lower body", area: const Rect.fromLTWH(54, 262, 60, 68), bodySide: BodySide.Front),
  BodyPart(name: '34', nameForUser: "Left front knee", category1: "Lower body", area: const Rect.fromLTWH(68, 330, 45, 60), bodySide: BodySide.Front),
  BodyPart(name: '35', nameForUser: "Left shin", category1: "Lower body", area: const Rect.fromLTWH(73, 389, 40, 60), bodySide: BodySide.Front),
  BodyPart(name: '36', nameForUser: "Left foot", category1: "Lower body", area: const Rect.fromLTWH(73, 448, 41, 49), bodySide: BodySide.Front),
  BodyPart(name: '37', nameForUser: "Right front thigh", category1: "Lower body", area: const Rect.fromLTWH(118, 262, 60, 68), bodySide: BodySide.Front),
  BodyPart(name: '38', nameForUser: "Right front knee", category1: "Lower body", area: const Rect.fromLTWH(120, 329, 42, 60), bodySide: BodySide.Front),
  BodyPart(name: '39', nameForUser: "Right shin", category1: "Lower body", area: const Rect.fromLTWH(119, 388, 39, 60), bodySide: BodySide.Front),
  BodyPart(name: '40', nameForUser: "Right foot", category1: "Lower body", area: const Rect.fromLTWH(119, 447, 41, 51), bodySide: BodySide.Front),
];
