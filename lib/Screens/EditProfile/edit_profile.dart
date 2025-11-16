import 'package:ekvi/Providers/EditProfile/edit_profile_provider.dart';
import 'package:ekvi/Providers/SideNavManager/side_nav_manager_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/CustomWidgets/curved_white_content_box.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_icon_bulder.dart';
import 'package:ekvi/Widgets/CustomWidgets/ekvi_empower.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:ekvi/Widgets/TextFields/custom_text_form_field.dart';
import 'package:ekvi/Widgets/TextFormatters/norwegian_phone_formatter.dart';
import 'package:ekvi/Core/di/user_singleton.dart';
import 'package:flutter/material.dart';
import 'package:ekvi/l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../generated/assets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var provider = Provider.of<EditProfileProvider>(AppNavigation.currentContext!, listen: false);
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    provider.fetchUserProfile();
  }

  @override
  void dispose() {
    provider.removeListenersFromForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var sideNavManagerProvider = Provider.of<SideNavManagerProvider>(AppNavigation.currentContext!, listen: false);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Consumer<SideNavManagerProvider>(builder: (context, value, child) {
                    return BackNavigation(
                      title: AppLocalizations.of(context)!.profile,
                      callback: () => sideNavManagerProvider.onSelected(MenuItems(AppNavigation.currentContext!).bottomNavManager),
                      endIcon: GestureDetector(
                        onTap: () => AppNavigation.navigateTo(AppRoutes.editProfileSettings),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: SvgPicture.asset("${AppConstant.assetIcons}settings.svg"),
                        ),
                      ),
                    );
                  }),
                  if (!UserManager().isPremium)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: EkviEmpower(),
                    ),
                  Consumer<EditProfileProvider>(
                    builder: (context, value, child) => ContentBox(
                      listView: false,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (UserManager().isPremium)
                              GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Container(
                                    height: 73,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16),
                                    decoration: ShapeDecoration(
                                      color: AppColors.secondaryColor400,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          side: const BorderSide(
                                            color: AppColors.secondaryColor600,
                                          )),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "${AppConstant.assetImages}ekvi.svg",
                                          fit: BoxFit.scaleDown,
                                          width: 32,
                                          alignment: Alignment.center,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 18.0),
                                          child: Text(
                                            'Ekvi Empower',
                                            textAlign: TextAlign.center,
                                            style: textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w400, fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            Text(AppLocalizations.of(context)!.firstName, textAlign: TextAlign.left, style: textTheme.titleSmall),
                            SizedBox(
                              height: 2.h,
                            ),
                            CustomTextFormField(
                              controller: value.firstNameController,
                              prefixWidget: iconBuilder(SvgPicture.asset(Assets.customiconsProfile),  Colors.transparent),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(AppLocalizations.of(context)!.lastName, textAlign: TextAlign.left, style: textTheme.titleSmall),
                            SizedBox(
                              height: 2.h,
                            ),
                            CustomTextFormField(
                              controller: value.lastNameController,
                              prefixWidget: iconBuilder(SvgPicture.asset(Assets.customiconsProfile),  Colors.transparent),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(AppLocalizations.of(context)!.email, textAlign: TextAlign.left, style: textTheme.titleSmall),
                            SizedBox(
                              height: 2.h,
                            ),
                            CustomTextFormField(
                              controller: value.emailController,
                              inputType: TextInputType.text,
                              prefixWidget: iconBuilder(SvgPicture.asset(Assets.customiconsEmail),  Colors.transparent),
                              validator: HelperFunctions.emailValidator,
                              isEnable: false,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(AppLocalizations.of(context)!.phoneNo, textAlign: TextAlign.left, style: textTheme.titleSmall),
                            SizedBox(
                              height: 2.h,
                            ),
                            CustomTextFormField(
                              controller: value.phoneController,
                              inputAction: TextInputAction.done,
                              inputType: TextInputType.text,
                              prefixWidget: iconBuilder(SvgPicture.asset(Assets.customiconsSupport),  Colors.transparent),
                              validator: HelperFunctions.phoneValidator,
                              maxLength: 16,
                              inputFormatters: [NorwegianPhoneFormatter()],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(AppLocalizations.of(context)!.birthday, textAlign: TextAlign.left, style: textTheme.titleSmall),
                            SizedBox(
                              height: 2.h,
                            ),
                            CustomButton(
                              titleAtStart: true,
                              title: DateFormat("dd/MM/yy").format(value.userDateOfBirth),
                              color: AppColors.primaryColor400,
                              fontColor: AppColors.blackColor,
                              tralingIcon: SvgPicture.asset(
                                Assets.customiconsArrowDown,
                                color: AppColors.actionColor600,
                                height: 16,
                                width: 16,
                              ),

                              elevation: 0,
                              onPressed: () => HelperFunctions.showSheet(context,
                                  child: HelperFunctions.buildDatePicker(value.userDateOfBirth, value.setDateOfBirth),
                                  onClicked: (() => Navigator.pop(context))),
                              leadingIcon: const Icon(
                                Icons.calendar_today,
                                size: 20,
                                color: AppColors.actionColor600,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            CustomButton(
                                title: AppLocalizations.of(context)!.save,
                                // minSize: Size(82.w, 6.h),
                                onPressed: value.enableButton
                                    ? () {
                                        if (_formKey.currentState!.validate()) {
                                          value.updateUserProfile();
                                        }
                                      }
                                    : null),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
