import 'package:ekvi/Models/DailyTracker/symptom_categories_model.dart';
import 'package:ekvi/Providers/DailyTracker/daily_tracker_provider.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/CustomPainterWidgets/custom_body_parts.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

class ClickableBodyBack extends StatefulWidget {
  const ClickableBodyBack({
    super.key,
  });

  @override
  ClickableBodyBackState createState() => ClickableBodyBackState();
}

class ClickableBodyBackState extends State<ClickableBodyBack> {
  final String imageURL = "${AppConstant.assetImages}body_back.png";

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
                              BodyPart? bodyPart = backBodyParts.firstWhereOrNull((part) => part.area!.contains(details.localPosition));
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
    case "41":
      return PartFourtyOne();
    case "42":
      return PartFourtyTwo();
    case "43":
      return PartFourtyThree();
    case "44":
      return PartFourtyFour();
    case "45":
      return PartFourtyFive();
    case "46":
      return PartFourtySix();
    case "47":
      return PartFourtySeven();
    case "48":
      return PartFourtyEight();
    case "49":
      return PartFourtyNine();
    case "50":
      return PartFifty();
    case "51":
      return PartFiftyOne();
    case "52":
      return PartFiftyTwo();
    case "53":
      return PartFiftyThree();
    case "54":
      return PartFiftyFour();
    case "55":
      return PartFiftyFive();
    case "56":
      return PartFiftySix();
    case "57":
      return PartFiftySeven();
    case "58":
      return PartFiftyEight();
    case "59":
      return PartFiftyNine();
    case "60":
      return PartSixty();
    case "28b":
      return PartTwentyEightBack();
    case "29b":
      return PartTwentyNineBack();
    case "30b":
      return PartThirtyBack();
    case "31b":
      return PartThirtyOneBack();
    case "23b":
      return PartTwentyThreeBack();
    case "24b":
      return PartTwentyFourBack();
    case "25b":
      return PartTwentyFiveBack();
    case "26b":
      return PartTwentySixBack();
  }
}

List<BodyPart> backBodyParts = [
  BodyPart(name: '41', nameForUser: "Left buttock", category1: "Pelvic area", area: const Rect.fromLTWH(53, 206, 63, 80), bodySide: BodySide.Back),
  BodyPart(name: '42', nameForUser: "Right buttock", category1: "Pelvic area", area: const Rect.fromLTWH(115, 206, 63, 80), bodySide: BodySide.Back),
  BodyPart(name: '43', nameForUser: "Left lower back", category1: "Pelvic area", area: const Rect.fromLTWH(61, 177, 38, 38), bodySide: BodySide.Back),
  BodyPart(name: '44', nameForUser: "Middle lower back", category1: "Pelvic area", area: const Rect.fromLTWH(91, 181, 47, 41), bodySide: BodySide.Back),
  BodyPart(name: '45', nameForUser: "Right lower back", category1: "Pelvic area", area: const Rect.fromLTWH(125, 177, 46, 40), bodySide: BodySide.Back),
  BodyPart(name: '46', nameForUser: "Left back", category1: "Upper body", area: const Rect.fromLTWH(67, 119, 35, 64), bodySide: BodySide.Back),
  BodyPart(name: '47', nameForUser: "Middle back", category1: "Upper body", area: const Rect.fromLTWH(98, 124, 35, 59), bodySide: BodySide.Back),
  BodyPart(name: '48', nameForUser: "Right back", category1: "Upper body", area: const Rect.fromLTWH(130, 119, 35, 64), bodySide: BodySide.Back),
  BodyPart(name: '49', nameForUser: "Left upper back", category1: "Upper body", area: const Rect.fromLTWH(42, 71, 58, 54), bodySide: BodySide.Back),
  BodyPart(name: '50', nameForUser: "Middle upper back", category1: "Upper body", area: const Rect.fromLTWH(89, 70, 53, 55), bodySide: BodySide.Back),
  BodyPart(name: '51', nameForUser: "Right upper back", category1: "Upper body", area: const Rect.fromLTWH(132, 71, 56, 54), bodySide: BodySide.Back),
  BodyPart(name: '53', nameForUser: "Left back thigh", category1: "Lower body", area: const Rect.fromLTWH(53, 265, 60, 56), bodySide: BodySide.Back),
  BodyPart(name: '54', nameForUser: "Left back knee", category1: "Lower body", area: const Rect.fromLTWH(66, 320, 47, 60), bodySide: BodySide.Back),
  BodyPart(name: '55', nameForUser: "Left calf", category1: "Lower body", area: const Rect.fromLTWH(72, 378, 41, 80), bodySide: BodySide.Back),
  BodyPart(name: '56', nameForUser: "Left heel", category1: "Lower body", area: const Rect.fromLTWH(83, 457, 32, 32), bodySide: BodySide.Back),
  BodyPart(name: '57', nameForUser: "Right back thigh", category1: "Lower body", area: const Rect.fromLTWH(118, 265, 60, 56), bodySide: BodySide.Back),
  BodyPart(name: '58', nameForUser: "Right back knee", category1: "Lower body", area: const Rect.fromLTWH(118, 320, 47, 60), bodySide: BodySide.Back),
  BodyPart(name: '59', nameForUser: "Right calf", category1: "Lower body", area: const Rect.fromLTWH(118, 378, 41, 80), bodySide: BodySide.Back),
  BodyPart(name: '60', nameForUser: "Right heel", category1: "Lower body", area: const Rect.fromLTWH(116, 457, 32, 32), bodySide: BodySide.Back),
  BodyPart(name: '28b', nameForUser: "Left upper arm", category1: "Upper body", area: const Rect.fromLTWH(35, 117, 32, 35), bodySide: BodySide.Back),
  BodyPart(name: '29b', nameForUser: "Left elbow", category1: "Upper body", area: const Rect.fromLTWH(28, 149, 31, 35), bodySide: BodySide.Back),
  BodyPart(name: '30b', nameForUser: "Left lower arm", category1: "Upper body", area: const Rect.fromLTWH(25, 180, 30, 42), bodySide: BodySide.Back),
  BodyPart(name: '31b', nameForUser: "Left hand", category1: "Upper body", area: const Rect.fromLTWH(0, 218, 41, 62), bodySide: BodySide.Back),
  BodyPart(name: '23b', nameForUser: "Right upper arm", category1: "Upper body", area: const Rect.fromLTWH(165, 117, 32, 35), bodySide: BodySide.Back),
  BodyPart(name: '24b', nameForUser: "Right elbow", category1: "Upper body", area: const Rect.fromLTWH(172, 149, 31, 35), bodySide: BodySide.Back),
  BodyPart(name: '25b', nameForUser: "Right lower arm", category1: "Upper body", area: const Rect.fromLTWH(176, 180, 30, 42), bodySide: BodySide.Back),
  BodyPart(name: '26b', nameForUser: "Right hand", category1: "Upper body", area: const Rect.fromLTWH(190, 218, 41, 62), bodySide: BodySide.Back),
];
