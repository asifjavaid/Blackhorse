import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppThemes {
  static const BoxShadow shadowDown = BoxShadow(
    offset: Offset(2, 2),
    blurRadius: 6,
    spreadRadius: 0,
    color: Color(0x19F89D87),
  );

  static const BoxShadow shadowUp = BoxShadow(
    offset: Offset(-2, -2),
    blurRadius: 6,
    spreadRadius: 0,
    color: Color(0x19F89D87),
  );
  static const TextTheme _textTheme = TextTheme(
    ///
    /// New Zitter Theme Fonts added
    ///
    // Headings
    displayLarge: TextStyle(fontSize: 30.0, height: 1.4, fontFamily: "Zitter", color: AppColors.neutralColor600, fontWeight: FontWeight.w400),
    displayMedium: TextStyle(fontSize: 24.0, height: 1.6, fontFamily: "Zitter", color: AppColors.neutralColor600, fontWeight: FontWeight.w400),
    displaySmall: TextStyle(fontSize: 18.0, height: 1.8, fontFamily: "Zitter", color: AppColors.neutralColor600, fontWeight: FontWeight.w400),

    // Subheadings
    headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500, height: 1.4, fontFamily: "Poppins"),
    headlineMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, height: 1.4, fontFamily: "Poppins"),
    headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, height: 1.5, fontFamily: "Poppins"),
    titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, height: 1.6, fontFamily: "Poppins"),

    // Body Text
    bodyLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, height: 1.8, fontFamily: "Poppins"),
    bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, height: 1.6, fontFamily: "Poppins"),
    bodySmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, height: 1.5, fontFamily: "Poppins"),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, height: 1.5, fontFamily: "Poppins"),
    // Caps
    labelSmall: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500, height: 1.2, fontFamily: "Poppins"),
  );
  static final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) return AppColors.neutralColor200;
        return AppColors.actionColor600;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) return AppColors.actionColor500;
        return AppColors.whiteColor;
      }),
      minimumSize: WidgetStateProperty.all(Size(30.w, 48)),
      maximumSize: WidgetStateProperty.all(Size(92.w, 48)),
      shape: WidgetStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      )),
      elevation: WidgetStateProperty.all(0),
      textStyle: WidgetStateProperty.all(const TextStyle(
        fontSize: 16,
        color: AppColors.whiteColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500,
      )),
      side: WidgetStateProperty.resolveWith<BorderSide>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) return const BorderSide(color: AppColors.actionColor500, width: 2);
        // if (states.contains(MaterialState.pressed)) return const BorderSide(color: AppColors.actionColor600, width: 2, style: BorderStyle.none);
        return BorderSide.none;
      }),
    ),
  );

  static final OutlinedButtonThemeData _outlinedButtonTheme = OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) return AppColors.neutralColor200;
        return AppColors.actionColor400;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) return AppColors.actionColor500;
        return AppColors.actionColor600;
      }),
      minimumSize: WidgetStateProperty.all(Size(30.w, 48)),
      maximumSize: WidgetStateProperty.all(Size(92.w, 48)),
      shape: WidgetStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      )),
      elevation: WidgetStateProperty.all(0),
      textStyle: WidgetStateProperty.all(const TextStyle(
        fontSize: 16,
        color: AppColors.whiteColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500,
      )),
      side: WidgetStateProperty.resolveWith<BorderSide>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) return const BorderSide(color: AppColors.actionColor500, width: 2);
        // if (states.contains(MaterialState.pressed)) return const BorderSide(color: AppColors.actionColor600, width: 2, style: BorderStyle.none);
        return const BorderSide(color: AppColors.actionColor600, width: 2);
      }),
    ),
  );

  static const BottomSheetThemeData _bottomSheetThemeData = BottomSheetThemeData(
      backgroundColor: AppColors.whiteColor,
      modalBackgroundColor: AppColors.whiteColor,
      surfaceTintColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ));

  static const ListTileThemeData _listTileThemeData = ListTileThemeData(
    iconColor: AppColors.primaryColor600,
    textColor: AppColors.neutralColor600,
    tileColor: Colors.transparent,
    contentPadding: EdgeInsets.only(bottom: 0, top: 0),
    shape: Border(
      bottom: BorderSide(color: AppColors.primaryColor500, width: 1.0),
    ),
    dense: false,
  );

  static final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    fillColor: AppColors.whiteColor,
    filled: true,
    isDense: true,
    alignLabelWithHint: false,
    contentPadding: const EdgeInsets.only(left: 25, right: 15, top: 10, bottom: 15),
    errorStyle: _textTheme.labelMedium!.copyWith(color: AppColors.errorColor500),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(36),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.actionColor500,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(36),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.secondaryColor600,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(36),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.errorColor500,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(36),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.actionColor500,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(36),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.errorColor500,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(36.0),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.actionColor500,
      ),
    ),
  );

  static const IconThemeData _iconTheme = IconThemeData(
    color: AppColors.actionColor600,
    size: 26,
  );
  static final SwitchThemeData _switchTheme = SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white; // Active thumb color
      }
      return Colors.white; // Default thumb color
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return AppColors.actionColor600; // Active track color
      }
      return AppColors.neutralColor300; // Default track color
    }),
    trackOutlineColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return AppColors.actionColor600; // Active track outline color
      }
      return AppColors.neutralColor300; // Default track outline color
    }),
    overlayColor: MaterialStateProperty.all(Colors.transparent),
  );
  static ThemeData defaultTheme = ThemeData(
      colorScheme: const ColorScheme.light(primary: AppColors.primaryColor600),
      bottomSheetTheme: _bottomSheetThemeData,
      textTheme: _textTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      iconTheme: _iconTheme,
      switchTheme: _switchTheme,
      listTileTheme: _listTileThemeData,
      inputDecorationTheme: _inputDecorationTheme);
}
