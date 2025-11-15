import 'package:ekvi/Models/FAQs/faq_model.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:flutter/material.dart';

class FAQsProvider extends ChangeNotifier {
  List<FAQ> faqs = DataInitializations.faqs;
}
