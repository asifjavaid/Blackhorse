import 'package:ekvi/Widgets/CustomWidgets/custom_info_table.dart';

class AppStrings {
  static const List<String> bowelMovLevels = ["Watery", "Soft", "Normal", "Hard", "Very hard"];
  static const List<String> urinationLevels = ["Mild", "Moderate", "Strong", "Severe", "Intense"];
  ///
  /// DAILY TRACKER PAIN FEATURE
  ///
  static String climaxTitle = "Wait, there's more than one type?";
  static String climaxSubTitle = "Feeling puzzled about the types of orgasms you're experiencing? You're not alone! Let's quickly demystify:";
  static final List<String> climaxDescription = [
    "Clitoral: Often described as a highly concentrated, intense sensation that can feel like a sweet, electric wave focused around the clitoral area.",
    "Vaginal: A deeper, full-body wave of pleasure.",
    "Both: The intense focus of a clitoral orgasm and the deep, full-body sensation of a vaginal orgasm at the same time.",
    "Not sure or No: Totally fine! Pleasure is a personal journey.",
  ];
  static String toolTitle = "What are these toys and tools?";
  static final List<String> toolDescription = [
    "Ohnut: An Ohnut is a wearable, soft ring designed to adjusts the depth of penetration, making the experience more enjoyable and comfortable. Perfect if you want to control how deep things go without compromising pleasure.",
    "External vibrators: External vibrators are fantastic for pleasure without penetration. If you’re experiencing pain or just want some external stimulation, these little wonders can be a delightful addition to your intimate moments. No need to go all in to feel amazing!",
    "Internal vibrators: Internal vibrators are designed to provide gentle yet satisfying internal stimulation. They’re usually flexible and soft, making them perfect for reaching those sensitive spots without causing discomfort. Whether you’re aiming for that elusive G-spot or just exploring what feels good, these vibrators are like a gentle nudge in the right direction, offering you deep, soothing pleasure.",
    "Dilators: These come in sets of different sizes and can help gently stretch and desensitize vaginal tissues. Often used in physical therapy for conditions like vaginismus and dyspareunia, dilators can make intimacy more comfortable over time.",
    "Clitoral stimulator: Designed to focus on the clitoris, these little gadgets provide targeted stimulation. Clitoral stimulators can enhance your pleasure and are perfect for those looking for direct, external stimulation.",
    "Lubricant: Lubricants can make all types of sexual activity more comfortable and enjoyable. They reduce friction and can be especially helpful if you experience dryness or sensitivity. Always choose a lubricant that works best for your body – water-based, silicone-based, or oil-based options are available."
  ];

  static List<PainTypesModel> getPainTypes() {
    return [
      PainTypesModel(title: "None", filled: true),
      PainTypesModel(title: "Mild", filled: false),
      PainTypesModel(title: "Mod", filled: true),
      PainTypesModel(title: "Severe", filled: false), ];
  } 
}
