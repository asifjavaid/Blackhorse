import 'package:flutter/services.dart';

class NorwegianPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9+]'), '');

    String formattedText;

    if (newText.length <= 3) {
      formattedText = newText;
    } else if (newText.length <= 6) {
      final firstPart = newText.substring(0, 3);
      final secondPart = newText.substring(3);
      formattedText = '($firstPart) $secondPart';
    } else if (newText.length <= 8) {
      final firstPart = newText.substring(0, 3);
      final secondPart = newText.substring(3, 6);
      final thirdPart = newText.substring(6);
      formattedText = '($firstPart) $secondPart $thirdPart';
    } else {
      final firstPart = newText.substring(0, 3);
      final secondPart = newText.substring(3, 6);
      final thirdPart = newText.substring(6, 8);
      final fourthPart = newText.substring(8);
      formattedText = '($firstPart) $secondPart $thirdPart $fourthPart';
    }

    return TextEditingValue(
      text: formattedText,
    );
  }
}
