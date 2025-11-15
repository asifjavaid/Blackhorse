class OptionModel {
  String text;
  bool isSelected;
  int? value;
  String? trailingIcon;

  OptionModel({required this.text, this.trailingIcon, this.value, this.isSelected = false});
}
