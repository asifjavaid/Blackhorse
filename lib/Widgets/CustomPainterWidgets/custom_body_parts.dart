import 'dart:math';

import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
// Front body parts

class PartOne extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.1355932);
    path_0.lineTo(size.width * 0.1227288, 0);
    path_0.cubicTo(size.width * -0.005025050, size.height * 0.2984085, size.width * -0.03186650, size.height * 0.4747881, size.width * 0.03672175, size.height * 0.8135593);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width, size.height * 0.1355932);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.7555559);
    path_0.lineTo(0, 0);
    path_0.lineTo(size.width * 0.3837217, size.height * 0.08148147);
    path_0.lineTo(size.width * 0.3604650, size.height * 0.1481485);
    path_0.lineTo(size.width * 0.3604650, size.height * 0.2296294);
    path_0.lineTo(size.width * 0.3953483, size.height * 0.3259265);
    path_0.lineTo(size.width * 0.4418600, size.height * 0.3851853);
    path_0.lineTo(size.width * 0.5232550, size.height * 0.4370368);
    path_0.lineTo(size.width * 0.6511633, size.height * 0.4888882);
    path_0.lineTo(size.width * 0.7790700, size.height * 0.5111118);
    path_0.lineTo(size.width * 0.8488367, size.height * 0.5185191);
    path_0.lineTo(size.width, size.height * 0.5259265);
    path_0.lineTo(size.width * 0.9767433, size.height);
    path_0.lineTo(0, size.height * 0.7555559);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartThree extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.7555559);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width * 0.6333333, size.height * 0.08148147);
    path_0.lineTo(size.width * 0.6555556, size.height * 0.1481485);
    path_0.lineTo(size.width * 0.6555556, size.height * 0.2296294);
    path_0.lineTo(size.width * 0.6222222, size.height * 0.3259265);
    path_0.lineTo(size.width * 0.5777778, size.height * 0.3851853);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.4370368);
    path_0.lineTo(size.width * 0.3777778, size.height * 0.4888882);
    path_0.lineTo(size.width * 0.2555556, size.height * 0.5111118);
    path_0.lineTo(size.width * 0.1888889, size.height * 0.5185191);
    path_0.lineTo(0, size.height * 0.5259265);
    path_0.lineTo(size.width * 0.02222222, size.height);
    path_0.lineTo(size.width, size.height * 0.7555559);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFour extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.1355932);
    path_0.lineTo(size.width * 0.8772707, 0);
    path_0.cubicTo(size.width * 1.005024, size.height * 0.2984085, size.width * 1.031866, size.height * 0.4747881, size.width * 0.9632780, size.height * 0.8135593);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.1355932);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFive extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.8617021);
    path_0.lineTo(size.width * 0.6909103, 0);
    path_0.lineTo(0, size.height * 0.1276596);
    path_0.lineTo(size.width * 0.2909103, size.height);
    path_0.lineTo(size.width, size.height * 0.8617021);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartSix extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.8469388);
    path_0.lineTo(size.width * 0.7631577, 0);
    path_0.lineTo(0, size.height * 0.1836735);
    path_0.lineTo(size.width * 0.06578942, size.height * 0.7551020);
    path_0.lineTo(size.width * 0.1578948, size.height * 0.7959184);
    path_0.lineTo(size.width * 0.2631577, size.height * 0.8469388);
    path_0.lineTo(size.width * 0.3289481, size.height * 0.9183673);
    path_0.lineTo(size.width * 0.3947365, size.height);
    path_0.lineTo(size.width, size.height * 0.8469388);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartSeven extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.8469388);
    path_0.lineTo(size.width * 0.2000000, 0);
    path_0.lineTo(size.width, size.height * 0.1836735);
    path_0.lineTo(size.width * 0.9571429, size.height * 0.7755102);
    path_0.lineTo(size.width * 0.9142857, size.height * 0.7959184);
    path_0.lineTo(size.width * 0.8000000, size.height * 0.8469388);
    path_0.lineTo(size.width * 0.7285714, size.height * 0.9183673);
    path_0.lineTo(size.width * 0.6571429, size.height);
    path_0.lineTo(0, size.height * 0.8469388);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartEight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.8617021);
    path_0.lineTo(size.width * 0.3333343, 0);
    path_0.lineTo(size.width, size.height * 0.1276596);
    path_0.lineTo(size.width * 0.7254914, size.height);
    path_0.lineTo(0, size.height * 0.8617021);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartNine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;

    canvas.save(); // save the canvas state

    // translate the canvas to the top left corner of the rotated rectangle
    // canvas.translate(0, size.width);

    // rotate the canvas by 90 degrees (counter-clockwise)
    canvas.rotate(-90 * pi);

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.height, size.width),
        bottomRight: Radius.circular(size.height * 0.3082927),
        bottomLeft: Radius.circular(size.height * 0.3082927),
        topLeft: Radius.circular(size.height * 0.3082927),
        topRight: Radius.circular(size.height * 0.3082927),
      ),
      paint0Fill,
    );

    canvas.restore(); // restore the canvas state
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTen extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.9482759);
    path_0.lineTo(size.width * 0.9275354, 0);
    path_0.lineTo(size.width * 0.05797104, 0);
    path_0.lineTo(0, size.height);
    path_0.cubicTo(size.width * 0.3604813, size.height * 0.8659897, size.width * 0.5824458, size.height * 0.8661000, size.width, size.height * 0.9482759);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartEleven extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.7211538);
    path_0.cubicTo(size.width * 0.1276595, size.height * 0.3557692, size.width * 0.2039585, size.height * 0.2591250, size.width * 0.2872338, 0);
    path_0.lineTo(size.width, size.height * 0.2115385);
    path_0.lineTo(size.width * 0.9680846, size.height);
    path_0.lineTo(0, size.height * 0.7211538);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwelve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height);
    path_0.cubicTo(size.width * 0.9616116, size.height * 0.5857000, size.width * 0.9535512, size.height * 0.3727786, size.width * 0.9672140, size.height * 0.02409643);
    path_0.lineTo(size.width * 0.7049093, size.height * 0.08433738);
    path_0.lineTo(size.width * 0.3606512, size.height * 0.08433738);
    path_0.lineTo(size.width * 0.04917953, 0);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartThirteen extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.7019231);
    path_0.cubicTo(size.width * 0.8754386, size.height * 0.3274577, size.width * 0.8239414, size.height * 0.2138077, size.width * 0.7300000, 0);
    path_0.lineTo(0, size.height * 0.2211538);
    path_0.lineTo(size.width * 0.02000000, size.height);
    path_0.lineTo(size.width, size.height * 0.7019231);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFourteen extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1139240, size.height * 0.8562092);
    path_0.cubicTo(size.width * 0.1897582, size.height * 0.7099276, size.width * 0.1462755, size.height * 0.5132592, 0, size.height * 0.07189539);
    path_0.cubicTo(size.width * 0.3219764, size.height * 0.1411934, size.width * 0.5452836, size.height * 0.1195814, size.width, 0);
    path_0.lineTo(size.width * 0.8734182, size.height * 0.2091500);
    path_0.cubicTo(size.width * 0.9282382, size.height * 0.4926026, size.width * 0.9500909, size.height * 0.6625092, size.width * 0.9620255, size.height);
    path_0.lineTo(size.width * 0.1139240, size.height * 0.8562092);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFifteen extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9324327, 0);
    path_0.lineTo(size.width * 0.05405404, 0);
    path_0.lineTo(0, size.height * 0.1111111);
    path_0.lineTo(size.width * 0.09459462, size.height * 0.9583333);
    path_0.lineTo(size.width * 0.3648654, size.height);
    path_0.lineTo(size.width * 0.6351346, size.height);
    path_0.lineTo(size.width * 0.8513519, size.height * 0.9583333);
    path_0.lineTo(size.width, size.height * 0.1111111);
    path_0.lineTo(size.width * 0.9324327, 0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartSixteen extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1358025, size.height * 0.2165608);
    path_0.lineTo(size.width * 0.02469140, 0);
    path_0.cubicTo(size.width * 0.5101930, size.height * 0.1183448, size.width * 0.7428158, size.height * 0.1639595, size.width, size.height * 0.08917203);
    path_0.cubicTo(size.width * 0.8791070, size.height * 0.5098532, size.width * 0.8425000, size.height * 0.6998051, size.width * 0.9012351, size.height * 0.8535038);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width * 0.1358025, size.height * 0.2165608);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartSeventeen extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9907459, 0);
    path_0.lineTo(size.width * 0.1132282, size.height * 0.06766173);
    path_0.cubicTo(size.width * 0.03404730, size.height * 0.3249865, size.width * 0.003559851, size.height * 0.4571423, 0, size.height * 0.6476192);
    path_0.cubicTo(size.width * 0.1037924, size.height * 1.092254, size.width * 0.4906554, size.height * 1.063256, size.width * 0.9058257, size.height * 0.8506058);
    path_0.cubicTo(size.width * 0.9952595, size.height * 0.4723615, size.width * 1.014312, size.height * 0.2871038, size.width * 0.9907459, 0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartEighteen extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.7872338, size.height * 0.9377299);
    path_0.cubicTo(size.width * 0.6355246, size.height * 0.6693745, size.width * 0.6692923, size.height * 0.5004263, size.width, size.height * 0.1575095);
    path_0.cubicTo(size.width * 0.9248385, size.height * 0.1126628, size.width * 0.9231892, size.height * 0.07511241, size.width * 0.9468123, 0);
    path_0.lineTo(size.width * 0.7340462, size.height * 0.06959708);
    path_0.lineTo(size.width * 0.6595769, size.height * 0.09157518);
    path_0.lineTo(size.width * 0.5638323, size.height * 0.1025642);
    path_0.lineTo(size.width * 0.4468108, size.height * 0.1025642);
    path_0.lineTo(size.width * 0.3404277, size.height * 0.09157518);
    path_0.lineTo(size.width * 0.2659585, size.height * 0.07325985);
    path_0.lineTo(size.width * 0.05319169, 0);
    path_0.cubicTo(size.width * 0.08757385, size.height * 0.08501533, size.width * 0.1090942, size.height * 0.1256905, 0, size.height * 0.1575095);
    path_0.cubicTo(size.width * 0.3777246, size.height * 0.5294577, size.width * 0.3439431, size.height * 0.7070423, size.width * 0.1489368, size.height);
    path_0.lineTo(size.width * 0.8297923, size.height);
    path_0.lineTo(size.width * 0.7872338, size.height * 0.9377299);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartNineteen extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.01317473, size.height * 0.04902800);
    path_0.lineTo(size.width * 0.8872203, 0);
    path_0.cubicTo(size.width * 0.9660878, size.height * 0.2610420, size.width * 0.9964541, size.height * 0.4735520, size.width, size.height * 0.6667800);
    path_0.cubicTo(size.width * 0.9155986, size.height * 1.078616, size.width * 0.5114703, size.height * 1.068810, size.width * 0.07896311, size.height * 0.8530880);
    path_0.cubicTo(size.width * -0.01011741, size.height * 0.4693800, size.width * -0.01029711, size.height * 0.3402800, size.width * 0.01317473, size.height * 0.04902800);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwenty extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3738324, size.height * 0.1417910);
    path_0.cubicTo(size.width * 0.5798662, size.height * 0.1201201, size.width * 0.6550230, size.height * 0.08531657, size.width * 0.7476635, 0);
    path_0.cubicTo(size.width * 0.8896865, size.height * 0.3781627, size.width * 0.9491162, size.height * 0.5377194, size.width, size.height * 0.9477612);
    path_0.lineTo(size.width * 0.1121495, size.height);
    path_0.cubicTo(size.width * 0.09671459, size.height * 0.8415657, size.width * 0.06989365, size.height * 0.7141642, 0, size.height * 0.5746269);
    path_0.cubicTo(size.width * 0.2550797, size.height * 0.4582522, size.width * 0.3214162, size.height * 0.3560507, size.width * 0.3738324, size.height * 0.1417910);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwentyOne extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6261680, size.height * 0.1407407);
    path_0.cubicTo(size.width * 0.4201333, size.height * 0.1192304, size.width * 0.3449773, size.height * 0.08468456, size.width * 0.2523360, 0);
    path_0.cubicTo(size.width * 0.1103131, size.height * 0.3753603, size.width * 0.05088347, size.height * 0.5929956, 0, size.height);
    path_0.lineTo(size.width * 0.8878507, size.height * 0.9481485);
    path_0.cubicTo(size.width * 0.9032853, size.height * 0.7908868, size.width * 0.9301067, size.height * 0.7088735, size.width, size.height * 0.5703706);
    path_0.cubicTo(size.width * 0.7449213, size.height * 0.4548588, size.width * 0.6785840, size.height * 0.3534132, size.width * 0.6261680, size.height * 0.1407407);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwentyTwo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.cubicTo(size.width * 0.7336627, size.height * 0.01272056, size.width * 0.9415203, size.height * 0.2426678, size.width, size.height * 0.9901125);
    path_0.cubicTo(size.width * 0.5294119, size.height * 1.051994, size.width * 0.1647059, size.height * 0.8354063, 0, 0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwentyThree extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.9468085);
    path_0.cubicTo(size.width * 0.8343309, size.height * 0.6357809, size.width * 0.7974691, size.height * 0.3989362, size.width * 0.7088600, size.height * 0.03191489);
    path_0.cubicTo(size.width * 0.4967091, size.height * 0.04977979, size.width * 0.3739255, size.height * 0.03012064, size.width * 0.1518987, 0);
    path_0.lineTo(0, size.height * 0.1861702);
    path_0.lineTo(size.width * 0.02531655, size.height * 0.3085106);
    path_0.lineTo(size.width * 0.06329109, size.height * 0.3936170);
    path_0.lineTo(size.width * 0.1518987, size.height * 0.5425532);
    path_0.lineTo(size.width * 0.1772153, size.height * 0.6329787);
    path_0.lineTo(size.width * 0.1265822, size.height * 0.7021277);
    path_0.lineTo(size.width * 0.3164564, size.height);
    path_0.lineTo(size.width, size.height * 0.9468085);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwentyFour extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.8921569);
    path_0.cubicTo(size.width * 0.9256863, size.height * 0.5393078, size.width * 0.8698314, size.height * 0.3442863, size.width * 0.7534255, 0);
    path_0.lineTo(0, size.height * 0.08823529);
    path_0.cubicTo(size.width * 0.07094745, size.height * 0.3961353, size.width * 0.06397353, size.height * 0.6310863, size.width * 0.1232876, size.height);
    path_0.lineTo(size.width, size.height * 0.8921569);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwentyFive extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.06000000);
    path_0.lineTo(size.width * 0.9154939, 0);
    path_0.cubicTo(size.width * 0.9577469, size.height * 0.3400000, size.width * 0.9058490, size.height * 0.6275160, size.width, size.height * 0.9466667);
    path_0.lineTo(size.width * 0.4507041, size.height);
    path_0.cubicTo(size.width * 0.3802816, size.height * 0.6666667, size.width * 0.1546280, size.height * 0.4590907, 0, size.height * 0.06000000);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwentySix extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0005494275, size.height * 0.03820897);
    path_0.lineTo(size.width * 0.4043681, 0);
    path_0.cubicTo(size.width * 0.4542928, size.height * 0.1592038, size.width * 0.6466594, size.height * 0.1528359, size.width * 0.7375174, size.height * 0.3184077);
    path_0.cubicTo(size.width * 0.7907217, size.height * 0.4030154, size.width * 0.8788551, size.height * 0.4648756, size.width, size.height * 0.5540308);
    path_0.cubicTo(size.width * 0.9082710, size.height * 0.6085500, size.width * 0.8443725, size.height * 0.5676962, size.width * 0.7274232, size.height * 0.4776128);
    path_0.cubicTo(size.width * 0.6766507, size.height * 0.4331859, size.width * 0.6574174, size.height * 0.4309500, size.width * 0.6466594, size.height * 0.4776128);
    path_0.lineTo(size.width * 0.7173275, size.height * 0.8979115);
    path_0.cubicTo(size.width * 0.6896275, size.height * 0.9354936, size.width * 0.6717638, size.height * 0.9401859, size.width * 0.6365638, size.height * 0.9106474);
    path_0.lineTo(size.width * 0.5457043, size.height * 0.6240808);
    path_0.lineTo(size.width * 0.5255130, size.height * 0.6049756);
    path_0.lineTo(size.width * 0.4952275, size.height * 0.6049756);
    path_0.lineTo(size.width * 0.4750362, size.height * 0.6240808);
    path_0.lineTo(size.width * 0.4851319, size.height * 0.9679615);
    path_0.cubicTo(size.width * 0.4548449, size.height * 1.006171, size.width * 0.4043681, size.height * 1.012538, size.width * 0.3841768, size.height * 0.9743295);
    path_0.cubicTo(size.width * 0.3614058, size.height * 0.8501282, size.width * 0.3575000, size.height * 0.7743013, size.width * 0.3538899, size.height * 0.6368167);
    path_0.lineTo(size.width * 0.3437957, size.height * 0.6240808);
    path_0.lineTo(size.width * 0.3236043, size.height * 0.6177115);
    path_0.lineTo(size.width * 0.3034130, size.height * 0.6304487);
    path_0.lineTo(size.width * 0.3034130, size.height * 0.9106474);
    path_0.cubicTo(size.width * 0.2832217, size.height * 0.9806974, size.width * 0.1923638, size.height * 0.9743295, size.width * 0.1923638, size.height * 0.9106474);
    path_0.lineTo(size.width * 0.1923638, size.height * 0.6304487);
    path_0.cubicTo(size.width * 0.1707087, size.height * 0.5695949, size.width * 0.1573986, size.height * 0.5616013, size.width * 0.1317904, size.height * 0.5795026);
    path_0.lineTo(size.width * 0.1216949, size.height * 0.8023885);
    path_0.cubicTo(size.width * 0.1413338, size.height * 0.9042795, size.width * 0.03950507, size.height * 0.9170154, size.width * 0.03083580, size.height * 0.8023885);
    path_0.cubicTo(size.width * 0.006744609, size.height * 0.4838526, size.width * -0.002453464, size.height * 0.3124282, size.width * 0.0005494275, size.height * 0.03820897);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwentySeven extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, 0);
    path_0.cubicTo(size.width * 0.2663373, size.height * 0.01272056, size.width * 0.05847932, size.height * 0.2426678, 0, size.height * 0.9901125);
    path_0.cubicTo(size.width * 0.4705881, size.height * 1.051994, size.width * 0.8352949, size.height * 0.8354063, size.width, 0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwentyEight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.9473684);
    path_0.cubicTo(size.width * 0.1699726, size.height * 0.6396147, size.width * 0.2077925, size.height * 0.3842105, size.width * 0.2987019, size.height * 0.02105263);
    path_0.cubicTo(size.width * 0.5163642, size.height * 0.03872947, size.width * 0.6423377, size.height * 0.02980358, size.width * 0.8701302, 0);
    path_0.lineTo(size.width, size.height * 0.1736842);
    path_0.lineTo(size.width, size.height * 0.2947368);
    path_0.lineTo(size.width * 0.9610396, size.height * 0.3789474);
    path_0.lineTo(size.width * 0.8701302, size.height * 0.5263158);
    path_0.lineTo(size.width * 0.8441566, size.height * 0.6157895);
    path_0.lineTo(size.width * 0.8961038, size.height * 0.6842105);
    path_0.lineTo(size.width * 0.7012981, size.height);
    path_0.lineTo(0, size.height * 0.9473684);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwentyNine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.8921569);
    path_0.cubicTo(size.width * 0.07431420, size.height * 0.5393078, size.width * 0.1301686, size.height * 0.3442863, size.width * 0.2465760, 0);
    path_0.lineTo(size.width, size.height * 0.08823529);
    path_0.cubicTo(size.width * 0.9290520, size.height * 0.3961353, size.width * 0.9360260, size.height * 0.6310863, size.width * 0.8767120, size.height);
    path_0.lineTo(0, size.height * 0.8921569);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartThirty extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.06164384);
    path_0.lineTo(size.width * 0.08450700, 0);
    path_0.cubicTo(size.width * 0.04225360, size.height * 0.3493151, size.width * 0.09415040, size.height * 0.6173110, 0, size.height * 0.9452055);
    path_0.lineTo(size.width * 0.5492960, size.height);
    path_0.cubicTo(size.width * 0.6197180, size.height * 0.6575342, size.width * 0.8453720, size.height * 0.4716685, size.width, size.height * 0.06164384);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartThirtyOne extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9994507, size.height * 0.03820897);
    path_0.lineTo(size.width * 0.5956319, 0);
    path_0.cubicTo(size.width * 0.5369275, size.height * 0.1847077, size.width * 0.3533406, size.height * 0.1528359, size.width * 0.2624826, size.height * 0.3184077);
    path_0.cubicTo(size.width * 0.2092783, size.height * 0.4030154, size.width * 0.1211455, size.height * 0.4648756, 0, size.height * 0.5540308);
    path_0.cubicTo(size.width * 0.09172841, size.height * 0.6085500, size.width * 0.1556275, size.height * 0.5676962, size.width * 0.2725768, size.height * 0.4776128);
    path_0.cubicTo(size.width * 0.3233493, size.height * 0.4331859, size.width * 0.3425826, size.height * 0.4309500, size.width * 0.3533406, size.height * 0.4776128);
    path_0.lineTo(size.width * 0.2826725, size.height * 0.8979115);
    path_0.cubicTo(size.width * 0.3103725, size.height * 0.9354936, size.width * 0.3282362, size.height * 0.9401859, size.width * 0.3634362, size.height * 0.9106474);
    path_0.lineTo(size.width * 0.4542957, size.height * 0.6240808);
    path_0.lineTo(size.width * 0.4744870, size.height * 0.6049756);
    path_0.lineTo(size.width * 0.5047725, size.height * 0.6049756);
    path_0.lineTo(size.width * 0.5249638, size.height * 0.6240808);
    path_0.lineTo(size.width * 0.5148681, size.height * 0.9679615);
    path_0.cubicTo(size.width * 0.5451551, size.height * 1.006171, size.width * 0.5956319, size.height * 1.012538, size.width * 0.6158232, size.height * 0.9743295);
    path_0.cubicTo(size.width * 0.6385942, size.height * 0.8501282, size.width * 0.6425000, size.height * 0.7743013, size.width * 0.6461101, size.height * 0.6368167);
    path_0.lineTo(size.width * 0.6562043, size.height * 0.6240808);
    path_0.lineTo(size.width * 0.6763957, size.height * 0.6177115);
    path_0.lineTo(size.width * 0.6965870, size.height * 0.6304487);
    path_0.lineTo(size.width * 0.6965870, size.height * 0.9106474);
    path_0.cubicTo(size.width * 0.7167783, size.height * 0.9806974, size.width * 0.8076362, size.height * 0.9743295, size.width * 0.8076362, size.height * 0.9106474);
    path_0.lineTo(size.width * 0.8076362, size.height * 0.6304487);
    path_0.cubicTo(size.width * 0.8292913, size.height * 0.5695949, size.width * 0.8426014, size.height * 0.5616013, size.width * 0.8682101, size.height * 0.5795026);
    path_0.lineTo(size.width * 0.8783058, size.height * 0.8023885);
    path_0.cubicTo(size.width * 0.8783058, size.height * 0.9042795, size.width * 0.9604942, size.height * 0.9170154, size.width * 0.9691638, size.height * 0.8023885);
    path_0.cubicTo(size.width * 0.9932551, size.height * 0.4838526, size.width * 1.002454, size.height * 0.3124282, size.width * 0.9994507, size.height * 0.03820897);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartThirtyThree extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9791670, size.height);
    path_0.lineTo(size.width, size.height * 0.2545455);
    path_0.lineTo(0, 0);
    path_0.lineTo(size.width * 0.2638890, size.height);
    path_0.lineTo(size.width * 0.9791670, size.height);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartThirtyFour extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.cubicTo(size.width, size.height * 0.3540375, size.width * 0.8415843, size.height * 0.5900625, size.width * 0.9702971, size.height * 0.9813662);
    path_0.lineTo(size.width * 0.1089109, size.height);
    path_0.cubicTo(size.width * 0.1494986, size.height * 0.5393950, size.width * 0.1303061, size.height * 0.3170875, 0, 0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartThirtyFive extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.01408453);
    path_0.lineTo(size.width * 0.9572609, 0);
    path_0.cubicTo(size.width * 1.098669, size.height * 0.4507047, size.width * 0.8301234, size.height * 0.6606462, size.width * 0.9898953, size.height);
    path_0.lineTo(size.width * 0.4024844, size.height * 0.9953019);
    path_0.cubicTo(size.width * 0.3480891, size.height * 0.7323943, size.width * 0.06526187, size.height * 0.4741783, 0, size.height * 0.01408453);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartThirtySix extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.02083373, size.height * 0.7585845);
    path_0.cubicTo(size.width * 0.3599776, size.height * 0.3932676, size.width * 0.4446269, size.height * 0.2297521, size.width * 0.4375000, 0);
    path_0.lineTo(size.width * 0.9895836, 0);
    path_0.lineTo(size.width * 0.9479164, size.height * 0.1826225);
    path_0.lineTo(size.width * 0.9687493, size.height * 0.2669085);
    path_0.lineTo(size.width, size.height * 0.3511958);
    path_0.lineTo(size.width * 0.9895836, size.height * 0.4073873);
    path_0.lineTo(size.width * 0.8541672, size.height * 0.5197704);
    path_0.lineTo(size.width * 0.8541672, size.height * 0.6742972);
    path_0.lineTo(size.width * 0.8125000, size.height * 0.7796549);
    path_0.lineTo(size.width * 0.7083328, size.height * 0.8569183);
    path_0.cubicTo(size.width * 0.6820478, size.height * 0.9937225, size.width * 0.6298746, size.height * 1.029835, size.width * 0.4270836, size.height * 0.9763254);
    path_0.lineTo(size.width * 0.3229164, size.height * 0.9833493);
    path_0.lineTo(size.width * 0.2604164, size.height * 0.9552535);
    path_0.lineTo(size.width * 0.1666657, size.height * 0.9341817);
    path_0.lineTo(size.width * 0.1354161, size.height * 0.9060859);
    path_0.lineTo(size.width * 0.08333269, size.height * 0.8850141);
    path_0.lineTo(size.width * 0.06249940, size.height * 0.8569183);
    path_0.lineTo(size.width * 0.02083373, size.height * 0.8569183);
    path_0.lineTo(0, size.height * 0.8147746);
    path_0.lineTo(size.width * 0.02083373, size.height * 0.7585845);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartThirtySeven extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.02083330, size.height);
    path_0.lineTo(0, size.height * 0.2545455);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width * 0.7361110, size.height);
    path_0.lineTo(size.width * 0.02083330, size.height);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartThirtyEight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, 0);
    path_0.lineTo(0, 0);
    path_0.cubicTo(size.width * 0.02857137, size.height * 0.3975150, size.width * 0.1523808, size.height * 0.5900625, size.width * 0.02857137, size.height * 0.9813662);
    path_0.lineTo(size.width * 0.8952384, size.height);
    path_0.cubicTo(size.width * 0.8561973, size.height * 0.5393950, size.width * 0.8746575, size.height * 0.3170875, size.width, 0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartThirtyNine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.01408453);
    path_0.lineTo(size.width * 0.04183091, 0);
    path_0.cubicTo(size.width * -0.09656545, size.height * 0.4507047, size.width * 0.1662621, size.height * 0.6606462, size.width * 0.009891909, size.height);
    path_0.lineTo(size.width * 0.5847939, size.height * 0.9953019);
    path_0.cubicTo(size.width * 0.5847939, size.height * 0.7136151, size.width, size.height * 0.5117368, size.width, size.height * 0.01408453);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFourty extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9791657, size.height * 0.7585845);
    path_0.cubicTo(size.width * 0.6400224, size.height * 0.3932676, size.width * 0.5553731, size.height * 0.2297521, size.width * 0.5625000, 0);
    path_0.lineTo(size.width * 0.01041667, 0);
    path_0.lineTo(size.width * 0.05208343, size.height * 0.1826225);
    path_0.lineTo(size.width * 0.03125000, size.height * 0.2669085);
    path_0.lineTo(0, size.height * 0.3511958);
    path_0.lineTo(size.width * 0.01041667, size.height * 0.4073873);
    path_0.lineTo(size.width * 0.1458334, size.height * 0.5197704);
    path_0.lineTo(size.width * 0.1458334, size.height * 0.6742972);
    path_0.lineTo(size.width * 0.1875000, size.height * 0.7796549);
    path_0.lineTo(size.width * 0.2916672, size.height * 0.8569183);
    path_0.cubicTo(size.width * 0.3179522, size.height * 0.9937225, size.width * 0.3701254, size.height * 1.029835, size.width * 0.5729164, size.height * 0.9763254);
    path_0.lineTo(size.width * 0.6770836, size.height * 0.9833493);
    path_0.lineTo(size.width * 0.7395836, size.height * 0.9552535);
    path_0.lineTo(size.width * 0.8333343, size.height * 0.9341817);
    path_0.lineTo(size.width * 0.8645836, size.height * 0.9060859);
    path_0.lineTo(size.width * 0.9166672, size.height * 0.8850141);
    path_0.lineTo(size.width * 0.9375000, size.height * 0.8569183);
    path_0.lineTo(size.width * 0.9791657, size.height * 0.8569183);
    path_0.lineTo(size.width, size.height * 0.8147746);
    path_0.lineTo(size.width * 0.9791657, size.height * 0.7585845);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Back body parts

class PartFourtyOne extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.02847320, size.height * 0.7620968);
    path_0.cubicTo(size.width * -0.03392049, size.height * 0.5428532, size.width * 0.007526136, size.height * 0.3634210, size.width * 0.1401233, 0);
    path_0.lineTo(size.width * 0.9944951, size.height * 0.1895161);
    path_0.lineTo(size.width * 0.9944951, size.height * 0.4072581);
    path_0.cubicTo(size.width * 0.9989709, size.height * 0.4647065, size.width * 0.9974078, size.height * 0.4975210, size.width * 0.9653660, size.height * 0.5604839);
    path_0.lineTo(size.width * 0.9508029, size.height * 0.9959677);
    path_0.lineTo(size.width * 0.02847320, size.height * 0.7620968);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFourtyTwo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9708728, size.height * 0.7620968);
    path_0.cubicTo(size.width * 1.033262, size.height * 0.5428532, size.width * 0.9918155, size.height * 0.3634210, size.width * 0.8592223, 0);
    path_0.lineTo(size.width * 0.004853165, size.height * 0.1895161);
    path_0.lineTo(size.width * 0.004853165, size.height * 0.4072581);
    path_0.cubicTo(size.width * 0.0003725350, size.height * 0.4647065, size.width * 0.001937757, size.height * 0.4975210, size.width * 0.03397942, size.height * 0.5604839);
    path_0.lineTo(size.width * 0.04854252, size.height * 0.9959677);
    path_0.lineTo(size.width * 0.9708728, size.height * 0.7620968);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFourtyThree extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.1136364);
    path_0.lineTo(size.width * 0.3437500, size.height * 0.007575758);
    path_0.cubicTo(size.width * 0.2812500, size.height * 0.3181818, size.width * 0.1562500, size.height * 0.3257576, size.width * 0.007812500, size.height * 0.8333333);
    path_0.lineTo(size.width * 0.8281250, size.height);
    path_0.lineTo(size.width, size.height * 0.1136364);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFourtyFour extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.006944444, size.height * 0.8731343);
    path_0.lineTo(size.width * 0.1666667, size.height * 0.007462687);
    path_0.lineTo(size.width * 0.8611111, size.height * 0.007462687);
    path_0.lineTo(size.width * 0.9930556, size.height * 0.8582090);
    path_0.lineTo(size.width * 0.5138889, size.height * 0.9925373);
    path_0.lineTo(size.width * 0.006944444, size.height * 0.8731343);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFourtyFive extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1461538, size.height * 0.9923077);
    path_0.cubicTo(size.width * 0.06802123, size.height * 0.5885108, size.width * 0.03141062, size.height * 0.3822508, 0, size.height * 0.1076923);
    path_0.lineTo(size.width * 0.6615385, 0);
    path_0.cubicTo(size.width * 0.6923077, size.height * 0.2000000, size.width * 0.7922385, size.height * 0.2203492, size.width * 0.9923077, size.height * 0.7692308);
    path_0.lineTo(size.width * 0.1461538, size.height * 0.9923077);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFourtySix extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9426279, size.height * 0.9948980);
    path_0.cubicTo(size.width * 1.011857, size.height * 0.5877051, size.width * 1.006964, size.height * 0.3924020, size.width * 0.9426279, size.height * 0.08673469);
    path_0.lineTo(0, size.height * 0.005102041);
    path_0.cubicTo(size.width * 0.01299449, size.height * 0.05145643, size.width * 0.01543433, size.height * 0.08245143, 0, size.height * 0.1581633);
    path_0.cubicTo(size.width * 0.05737705, size.height * 0.5459184, size.width * 0.2435967, size.height * 0.6122418, size.width * 0.2377066, size.height * 0.9234694);
    path_0.lineTo(size.width * 0.9426279, size.height * 0.9948980);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFourtySeven extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9897959, size.height * 0.005617978);
    path_0.lineTo(size.width * 0.01020408, size.height * 0.005617978);
    path_0.cubicTo(size.width * 0.1046439, size.height * 0.4221247, size.width * 0.09481714, size.height * 0.6369146, size.width * 0.01020408, size.height);
    path_0.lineTo(size.width * 0.9897959, size.height);
    path_0.cubicTo(size.width * 0.9225347, size.height * 0.5987854, size.width * 0.9180980, size.height * 0.3802146, size.width * 0.9897959, size.height * 0.005617978);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFourtyEight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.06451097, size.height * 0.9948980);
    path_0.cubicTo(size.width * -0.003600935, size.height * 0.5877051, size.width * 0.001212258, size.height * 0.3924020, size.width * 0.06451097, size.height * 0.08673469);
    path_0.lineTo(size.width * 0.9919355, size.height * 0.005102041);
    path_0.cubicTo(size.width * 0.9791500, size.height * 0.05145643, size.width * 0.9767500, size.height * 0.08245143, size.width * 0.9919355, size.height * 0.1581633);
    path_0.cubicTo(size.width * 0.9354839, size.height * 0.5459184, size.width * 0.7522677, size.height * 0.6122418, size.width * 0.7580629, size.height * 0.9234694);
    path_0.lineTo(size.width * 0.06451097, size.height * 0.9948980);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFourtyNine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9948454, size.height);
    path_0.cubicTo(size.width * 0.9471577, size.height * 0.5653024, size.width * 0.9085577, size.height * 0.3476542, size.width * 0.8195876, 0);
    path_0.cubicTo(size.width * 0.7399835, size.height * 0.04783542, size.width * 0.6054577, size.height * 0.05522133, size.width * 0.3556701, size.height * 0.06626506);
    path_0.cubicTo(size.width * 0.05678021, size.height * 0.1037072, size.width * 0.02577320, size.height * 0.3795181, size.width * 0.005154639, size.height * 0.8493976);
    path_0.lineTo(size.width * 0.9948454, size.height);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFifty extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9934211, size.height * 0.006849315);
    path_0.lineTo(size.width * 0.006578947, size.height * 0.006849315);
    path_0.cubicTo(size.width * 0.09689618, size.height * 0.3501452, size.width * 0.1379000, size.height * 0.5671548, size.width * 0.1907895, size.height);
    path_0.lineTo(size.width * 0.8223684, size.height);
    path_0.cubicTo(size.width * 0.8804711, size.height * 0.5566548, size.width * 0.9186592, size.height * 0.3429110, size.width * 0.9934211, size.height * 0.006849315);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFiftyOne extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height);
    path_0.cubicTo(size.width * 0.04818396, size.height * 0.5653024, size.width * 0.07676990, size.height * 0.3476542, size.width * 0.1666667, 0);
    path_0.cubicTo(size.width * 0.2471000, size.height * 0.04783542, size.width * 0.3934438, size.height * 0.05522133, size.width * 0.6458333, size.height * 0.06626506);
    path_0.cubicTo(size.width * 0.9478365, size.height * 0.1037072, size.width * 0.9791667, size.height * 0.3795181, size.width, size.height * 0.8493976);
    path_0.lineTo(0, size.height);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFiftyTwo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9934211, size.height * 0.006849315);
    path_0.lineTo(size.width * 0.006578947, size.height * 0.006849315);
    path_0.cubicTo(size.width * 0.09689618, size.height * 0.3501452, size.width * 0.1379000, size.height * 0.5671548, size.width * 0.1907895, size.height);
    path_0.lineTo(size.width * 0.8223684, size.height);
    path_0.cubicTo(size.width * 0.8804711, size.height * 0.5566548, size.width * 0.9186592, size.height * 0.3429110, size.width * 0.9934211, size.height * 0.006849315);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFiftyThree extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(size.width, size.height * 0.3072917);
    path_0.lineTo(size.width * 0.9791667, size.height * 0.9947917);
    path_0.lineTo(size.width * 0.2239583, size.height * 0.9947917);
    path_0.lineTo(0, 0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFiftyFour extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1418892, size.height * 0.9812500);
    path_0.cubicTo(size.width * 0.1688635, size.height * 0.3906250, size.width * 0.08107662, size.height * 0.2875000, size.width * 0.006753770, size.height * 0.006250000);
    path_0.lineTo(size.width * 0.9864824, size.height * 0.006250000);
    path_0.cubicTo(size.width * 1.020268, size.height * 0.3750000, size.width * 0.8513514, size.height * 0.5812500, size.width * 0.9324284, size.height);
    path_0.lineTo(size.width * 0.1418892, size.height * 0.9812500);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFiftyFive extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4230631, size.height);
    path_0.cubicTo(size.width * 0.4230631, size.height * 0.6119403, size.width * 0.03075508, size.height * 0.6417910, size.width * 0.007678108, 0);
    path_0.lineTo(size.width * 0.9076785, size.height * 0.01119403);
    path_0.cubicTo(size.width * 1.153846, size.height * 0.4104478, size.width * 0.7615538, size.height * 0.7947761, size.width * 0.9615246, size.height);
    path_0.lineTo(size.width * 0.4230631, size.height);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFiftySix extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9210100, size.height * 0.3773041);
    path_0.cubicTo(size.width * 0.9362040, size.height * 0.2149918, size.width * 0.9330640, size.height * 0.1295396, size.width * 0.9039540, size.height * 0.03897776);
    path_0.cubicTo(size.width * 0.8963020, size.height * 0.01517014, size.width * 0.8739080, 0, size.width * 0.8493540, 0);
    path_0.lineTo(size.width * 0.2507520, 0);
    path_0.cubicTo(size.width * 0.2173240, 0, size.width * 0.1902562, size.height * 0.02793592, size.width * 0.1911860, size.height * 0.06203469);
    path_0.cubicTo(size.width * 0.1950068, size.height * 0.2021473, size.width * 0.2066420, size.height * 0.2976286, size.width * 0.2393280, size.height * 0.4186408);
    path_0.cubicTo(size.width * 0.2518060, size.height * 0.4648388, size.width * 0.2501600, size.height * 0.5140612, size.width * 0.2322040, size.height * 0.5583388);
    path_0.lineTo(size.width * 0.1582508, size.height * 0.7407082);
    path_0.cubicTo(size.width * 0.1464512, size.height * 0.7698061, size.width * 0.1251124, size.height * 0.7938163, size.width * 0.09788280, size.height * 0.8086347);
    path_0.lineTo(size.width * 0.03363160, size.height * 0.8436020);
    path_0.cubicTo(size.width * 0.008957060, size.height * 0.8570306, size.width * -0.001536788, size.height * 0.8874980, size.width * 0.009478980, size.height * 0.9137245);
    path_0.cubicTo(size.width * 0.01610764, size.height * 0.9295082, size.width * 0.02958600, size.height * 0.9412204, size.width * 0.04591120, size.height * 0.9453857);
    path_0.lineTo(size.width * 0.08861400, size.height * 0.9562796);
    path_0.cubicTo(size.width * 0.09619200, size.height * 0.9582122, size.width * 0.1040490, size.height * 0.9595204, size.width * 0.1118354, size.height * 0.9601531);
    path_0.cubicTo(size.width * 0.4137780, size.height * 0.9847020, size.width * 0.5283440, size.height * 0.9793286, size.width * 0.7599920, size.height * 0.9795918);
    path_0.cubicTo(size.width * 1.044938, size.height * 0.9982796, size.width * 1.020428, size.height * 0.8092653, size.width * 0.9224640, size.height * 0.3980143);
    path_0.cubicTo(size.width * 0.9208680, size.height * 0.3913102, size.width * 0.9203680, size.height * 0.3841735, size.width * 0.9210100, size.height * 0.3773041);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFiftySeven extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, 0);
    path_0.lineTo(0, size.height * 0.3072917);
    path_0.lineTo(size.width * 0.02083333, size.height * 0.9947917);
    path_0.lineTo(size.width * 0.7760417, size.height * 0.9947917);
    path_0.lineTo(size.width, 0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFiftyEight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8581108, size.height * 0.9812500);
    path_0.cubicTo(size.width * 0.8311365, size.height * 0.3906250, size.width * 0.9189230, size.height * 0.2875000, size.width * 0.9932459, size.height * 0.006250000);
    path_0.lineTo(size.width * 0.01351797, size.height * 0.006250000);
    path_0.cubicTo(size.width * -0.02026784, size.height * 0.3750000, size.width * 0.1486486, size.height * 0.5812500, size.width * 0.06757203, size.height);
    path_0.lineTo(size.width * 0.8581108, size.height * 0.9812500);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartFiftyNine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5769369, size.height);
    path_0.cubicTo(size.width * 0.5769369, size.height * 0.6119403, size.width * 0.9692446, size.height * 0.6417910, size.width * 0.9923215, 0);
    path_0.lineTo(size.width * 0.09232185, size.height * 0.01119403);
    path_0.cubicTo(size.width * -0.1538462, size.height * 0.4104478, size.width * 0.2384462, size.height * 0.7947761, size.width * 0.03847569, size.height);
    path_0.lineTo(size.width * 0.5769369, size.height);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartSixty extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.07899000, size.height * 0.3773041);
    path_0.cubicTo(size.width * 0.06379520, size.height * 0.2149918, size.width * 0.06693580, size.height * 0.1295396, size.width * 0.09604620, size.height * 0.03897776);
    path_0.cubicTo(size.width * 0.1036990, size.height * 0.01517014, size.width * 0.1260912, 0, size.width * 0.1506456, 0);
    path_0.lineTo(size.width * 0.7492480, 0);
    path_0.cubicTo(size.width * 0.7826760, 0, size.width * 0.8097440, size.height * 0.02793592, size.width * 0.8088140, size.height * 0.06203469);
    path_0.cubicTo(size.width * 0.8049940, size.height * 0.2021473, size.width * 0.7933580, size.height * 0.2976286, size.width * 0.7606720, size.height * 0.4186408);
    path_0.cubicTo(size.width * 0.7481940, size.height * 0.4648388, size.width * 0.7498400, size.height * 0.5140612, size.width * 0.7677960, size.height * 0.5583388);
    path_0.lineTo(size.width * 0.8417500, size.height * 0.7407082);
    path_0.cubicTo(size.width * 0.8535480, size.height * 0.7698061, size.width * 0.8748880, size.height * 0.7938163, size.width * 0.9021180, size.height * 0.8086347);
    path_0.lineTo(size.width * 0.9663680, size.height * 0.8436020);
    path_0.cubicTo(size.width * 0.9910420, size.height * 0.8570306, size.width * 1.001536, size.height * 0.8874980, size.width * 0.9905220, size.height * 0.9137245);
    path_0.cubicTo(size.width * 0.9838920, size.height * 0.9295082, size.width * 0.9704140, size.height * 0.9412204, size.width * 0.9540880, size.height * 0.9453857);
    path_0.lineTo(size.width * 0.9113860, size.height * 0.9562796);
    path_0.cubicTo(size.width * 0.9038080, size.height * 0.9582122, size.width * 0.8959500, size.height * 0.9595204, size.width * 0.8881640, size.height * 0.9601531);
    path_0.cubicTo(size.width * 0.5862220, size.height * 0.9847020, size.width * 0.4716560, size.height * 0.9793286, size.width * 0.2400080, size.height * 0.9795918);
    path_0.cubicTo(size.width * -0.04493860, size.height * 0.9982796, size.width * -0.02042720, size.height * 0.8092653, size.width * 0.07753540, size.height * 0.3980143);
    path_0.cubicTo(size.width * 0.07913240, size.height * 0.3913102, size.width * 0.07963300, size.height * 0.3841735, size.width * 0.07899000, size.height * 0.3773041);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwentyThreeBack extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.006912529, size.height * 0.07894737);
    path_0.lineTo(size.width * 0.7716176, 0);
    path_0.cubicTo(size.width * 0.7893882, size.height * 0.2858719, size.width * 0.9088725, size.height * 0.4824561, size.width * 0.9971078, size.height * 0.9298246);
    path_0.lineTo(size.width * 0.2520098, size.height * 0.9912281);
    path_0.cubicTo(size.width * 0.1833831, size.height * 0.6666667, size.width * -0.04210706, size.height * 0.4122807, size.width * 0.006912529, size.height * 0.07894737);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwentyFourBack extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.01639498, size.height * 0.06034483);
    path_0.lineTo(size.width * 0.7471635, 0);
    path_0.cubicTo(size.width * 0.8255038, size.height * 0.3440655, size.width * 0.9683173, size.height * 0.5000000, size.width * 0.9971635, size.height * 0.8965517);
    path_0.lineTo(size.width * 0.1510104, size.height * 0.9913793);
    path_0.cubicTo(size.width * 0.08370269, size.height * 0.5948276, size.width * 0.09368788, size.height * 0.2887845, size.width * 0.01639498, size.height * 0.06034483);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwentyFiveBack extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.01776123, size.height * 0.07971014);
    path_0.lineTo(size.width * 0.9448437, 0);
    path_0.cubicTo(size.width * 0.9448437, size.height * 0.3333333, size.width * 0.9258896, size.height * 0.5428986, size.width * 0.9969271, size.height * 0.9492754);
    path_0.lineTo(size.width * 0.4448437, size.height * 0.9927536);
    path_0.cubicTo(size.width * 0.2959750, size.height * 0.5818580, size.width * 0.1635946, size.height * 0.4057971, size.width * 0.01776123, size.height * 0.07971014);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwentySixBack extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0005575074, size.height * 0.03465465);
    path_0.lineTo(size.width * 0.3661971, 0);
    path_0.cubicTo(size.width * 0.3970588, size.height * 0.1744186, size.width * 0.6561691, size.height * 0.2200140, size.width * 0.7483632, size.height * 0.3701837);
    path_0.cubicTo(size.width * 0.7978191, size.height * 0.4404826, size.width * 0.8770221, size.height * 0.4934663, size.width * 0.9844721, size.height * 0.5640302);
    path_0.cubicTo(size.width * 0.9995706, size.height * 0.5739453, size.width * 0.9984206, size.height * 0.5928500, size.width * 0.9802397, size.height * 0.5986930);
    path_0.cubicTo(size.width * 0.9041809, size.height * 0.6231384, size.width * 0.8416265, size.height * 0.5858430, size.width * 0.7381206, size.height * 0.5145791);
    path_0.cubicTo(size.width * 0.6866015, size.height * 0.4742849, size.width * 0.6670853, size.height * 0.4722570, size.width * 0.6561691, size.height * 0.5145791);
    path_0.lineTo(size.width * 0.7131706, size.height * 0.8957802);
    path_0.cubicTo(size.width * 0.6850632, size.height * 0.9298663, size.width * 0.6669368, size.height * 0.9341221, size.width * 0.6312191, size.height * 0.9073314);
    path_0.lineTo(size.width * 0.5537294, size.height * 0.6474221);
    path_0.lineTo(size.width * 0.5332412, size.height * 0.6300942);
    path_0.lineTo(size.width * 0.5025103, size.height * 0.6300942);
    path_0.lineTo(size.width * 0.4820221, size.height * 0.6474221);
    path_0.lineTo(size.width * 0.4775603, size.height * 0.9709419);
    path_0.cubicTo(size.width * 0.4468279, size.height * 1.005597, size.width * 0.3956088, size.height * 1.011372, size.width * 0.3751206, size.height * 0.9767174);
    path_0.cubicTo(size.width * 0.3520147, size.height * 0.8640698, size.width * 0.3627574, size.height * 0.7836686, size.width * 0.3590941, size.height * 0.6589733);
    path_0.lineTo(size.width * 0.3488515, size.height * 0.6474221);
    path_0.lineTo(size.width * 0.3283632, size.height * 0.6416453);
    path_0.lineTo(size.width * 0.3078750, size.height * 0.6531977);
    path_0.lineTo(size.width * 0.3078750, size.height * 0.9073314);
    path_0.cubicTo(size.width * 0.2873868, size.height * 0.9708651, size.width * 0.1951926, size.height * 0.9650895, size.width * 0.1951926, size.height * 0.9073314);
    path_0.lineTo(size.width * 0.1951926, size.height * 0.6531977);
    path_0.cubicTo(size.width * 0.1732191, size.height * 0.5980047, size.width * 0.1597132, size.height * 0.5907547, size.width * 0.1337285, size.height * 0.6069907);
    path_0.lineTo(size.width * 0.1234846, size.height * 0.8091430);
    path_0.cubicTo(size.width * 0.1234846, size.height * 0.9015558, size.width * 0.04008603, size.height * 0.9131070, size.width * 0.03128926, size.height * 0.8091430);
    path_0.cubicTo(size.width * 0.006843794, size.height * 0.5202384, size.width * -0.002489544, size.height * 0.2833651, size.width * 0.0005575074, size.height * 0.03465465);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwentyEightBack extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9901961, size.height * 0.07894737);
    path_0.lineTo(size.width * 0.2254902, 0);
    path_0.cubicTo(size.width * 0.2077196, size.height * 0.2858719, size.width * 0.08823529, size.height * 0.4824561, 0, size.height * 0.9298246);
    path_0.lineTo(size.width * 0.7450980, size.height * 0.9912281);
    path_0.cubicTo(size.width * 0.8137255, size.height * 0.6666667, size.width * 1.039216, size.height * 0.4122807, size.width * 0.9901961, size.height * 0.07894737);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartTwentyNineBack extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.06034483);
    path_0.lineTo(size.width * 0.2549020, 0);
    path_0.cubicTo(size.width * 0.1750259, size.height * 0.3440655, size.width * 0.02941176, size.height * 0.5000000, 0, size.height * 0.8965517);
    path_0.lineTo(size.width * 0.8627451, size.height * 0.9913793);
    path_0.cubicTo(size.width * 0.9313725, size.height * 0.5948276, size.width * 0.9211922, size.height * 0.2887845, size.width, size.height * 0.06034483);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartThirtyBack extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.07971014);
    path_0.lineTo(size.width * 0.05319149, 0);
    path_0.cubicTo(size.width * 0.05319149, size.height * 0.3333333, size.width * 0.07255000, size.height * 0.5428986, 0, size.height * 0.9492754);
    path_0.lineTo(size.width * 0.5638298, size.height * 0.9927536);
    path_0.cubicTo(size.width * 0.7158660, size.height * 0.5818580, size.width * 0.8510638, size.height * 0.4057971, size.width, size.height * 0.07971014);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PartThirtyOneBack extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9994426, size.height * 0.03465465);
    path_0.lineTo(size.width * 0.6338029, 0);
    path_0.cubicTo(size.width * 0.6029412, size.height * 0.1744186, size.width * 0.3438309, size.height * 0.2200140, size.width * 0.2516368, size.height * 0.3701837);
    path_0.cubicTo(size.width * 0.2021809, size.height * 0.4404826, size.width * 0.1229787, size.height * 0.4934663, size.width * 0.01552765, size.height * 0.5640302);
    path_0.cubicTo(size.width * 0.0004297809, size.height * 0.5739453, size.width * 0.001579235, size.height * 0.5928500, size.width * 0.01976074, size.height * 0.5986930);
    path_0.cubicTo(size.width * 0.09581956, size.height * 0.6231384, size.width * 0.1583735, size.height * 0.5858430, size.width * 0.2618794, size.height * 0.5145791);
    path_0.cubicTo(size.width * 0.3133985, size.height * 0.4742849, size.width * 0.3329147, size.height * 0.4722570, size.width * 0.3438309, size.height * 0.5145791);
    path_0.lineTo(size.width * 0.2868294, size.height * 0.8957802);
    path_0.cubicTo(size.width * 0.3149368, size.height * 0.9298663, size.width * 0.3330632, size.height * 0.9341221, size.width * 0.3687809, size.height * 0.9073314);
    path_0.lineTo(size.width * 0.4462706, size.height * 0.6474221);
    path_0.lineTo(size.width * 0.4667588, size.height * 0.6300942);
    path_0.lineTo(size.width * 0.4974897, size.height * 0.6300942);
    path_0.lineTo(size.width * 0.5179779, size.height * 0.6474221);
    path_0.lineTo(size.width * 0.5224397, size.height * 0.9709419);
    path_0.cubicTo(size.width * 0.5531721, size.height * 1.005597, size.width * 0.6043912, size.height * 1.011372, size.width * 0.6248794, size.height * 0.9767174);
    path_0.cubicTo(size.width * 0.6479853, size.height * 0.8640698, size.width * 0.6372426, size.height * 0.7836686, size.width * 0.6409059, size.height * 0.6589733);
    path_0.lineTo(size.width * 0.6511485, size.height * 0.6474221);
    path_0.lineTo(size.width * 0.6716368, size.height * 0.6416453);
    path_0.lineTo(size.width * 0.6921250, size.height * 0.6531977);
    path_0.lineTo(size.width * 0.6921250, size.height * 0.9073314);
    path_0.cubicTo(size.width * 0.7126132, size.height * 0.9708651, size.width * 0.8048074, size.height * 0.9650895, size.width * 0.8048074, size.height * 0.9073314);
    path_0.lineTo(size.width * 0.8048074, size.height * 0.6531977);
    path_0.cubicTo(size.width * 0.8267809, size.height * 0.5980047, size.width * 0.8402868, size.height * 0.5907547, size.width * 0.8662721, size.height * 0.6069907);
    path_0.lineTo(size.width * 0.8765162, size.height * 0.8091430);
    path_0.cubicTo(size.width * 0.8765162, size.height * 0.9015558, size.width * 0.9599132, size.height * 0.9131070, size.width * 0.9687103, size.height * 0.8091430);
    path_0.cubicTo(size.width * 0.9931559, size.height * 0.5202384, size.width * 1.002490, size.height * 0.2833651, size.width * 0.9994426, size.height * 0.03465465);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = AppColors.secondaryColor600;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
