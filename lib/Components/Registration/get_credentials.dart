// import 'package:ekvi/Providers/Register/register_provider.dart';
// import 'package:ekvi/Routes/app_navigation.dart';
// import 'package:ekvi/Routes/app_routes.dart';
// import 'package:ekvi/Utils/constants/app_colors.dart';
// import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
// import 'package:ekvi/Utils/helpers/helper_functions.dart';
// import 'package:ekvi/Widgets/Buttons/custom_button.dart';
// import 'package:ekvi/Widgets/CustomWidgets/custom_icon_bulder.dart';
// import 'package:ekvi/Widgets/TextFields/custom_checkbox_listile.dart';
// import 'package:ekvi/Widgets/TextFields/custom_text_form_field.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// import 'package:ekvi/l10n/app_localizations.dart';
// import 'package:flutter/gestures.dart';

// class GetUserCredentials extends StatefulWidget {
//   const GetUserCredentials({super.key});

//   @override
//   State<GetUserCredentials> createState() => _GetUserCredentialsState();
// }

// class _GetUserCredentialsState extends State<GetUserCredentials> {
//   late TapGestureRecognizer _tapGestureRecognizer;
//   var provider = Provider.of<RegisterProvider>(AppNavigation.currentContext!);
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     _tapGestureRecognizer = TapGestureRecognizer()..onTap = provider.launchTOSUrl;
//   }

//   @override
//   void dispose() {
//     _tapGestureRecognizer.dispose(); // Dispose the gesture recognizer
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     TextTheme textTheme = Theme.of(context).textTheme;

//     return Consumer<RegisterProvider>(
//         builder: (context, value, child) => Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(AppLocalizations.of(context)!.userName, textAlign: TextAlign.left, style: textTheme.titleSmall),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   CustomTextFormField(
//                     controller: value.usernameController,
//                     inputType: TextInputType.text,
//                     prefixWidget: iconBuilder(
//                         const Icon(
//                           AppCustomIcons.profile,
//                           size: 16,
//                         ),
//                         Colors.transparent),
//                     obscureText: false,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your username';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   Text(AppLocalizations.of(context)!.emailAddress, textAlign: TextAlign.left, style: textTheme.titleSmall),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   CustomTextFormField(
//                     controller: value.emailController,
//                     prefixWidget: iconBuilder(
//                         const Icon(
//                           AppCustomIcons.email,
//                           size: 16,
//                         ),
//                         Colors.transparent),
//                     inputType: TextInputType.text,
//                     obscureText: false,
//                     validator: HelperFunctions.emailValidator,
//                   ),
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   Text(AppLocalizations.of(context)!.password, textAlign: TextAlign.left, style: textTheme.titleSmall),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   CustomTextFormField(
//                     controller: value.passwordController,
//                     inputType: TextInputType.text,
//                     prefixWidget: iconBuilder(
//                         const Icon(
//                           AppCustomIcons.locked,
//                           size: 16,
//                         ),
//                         Colors.transparent),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your password';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: 3.h,
//                   ),
//                   FormField<bool>(
//                     initialValue: value.hasAgreedToTOS,
//                     autovalidateMode: AutovalidateMode.onUserInteraction,
//                     validator: (bool? val) {
//                       if (val == null || !val) {
//                         return 'At Ekvi, we value your privacy and trust. To be able to continue, we ask you to agree to our terms & conditions and privacy policy';
//                       }
//                       return null;
//                     },
//                     builder: (FormFieldState<bool> state) {
//                       return CustomCheckboxListTile(
//                         value: value.hasAgreedToTOS,
//                         onChanged: (bool? val) {
//                           // You can update state and provider both here if required
//                           value.setHasAgreedToTOS(val);
//                           state.didChange(val);
//                         },
//                         title: TextSpan(
//                           style: textTheme.labelMedium,
//                           children: [
//                             TextSpan(
//                               text: "By signing up I have read and agree to Ekvi's ",
//                               style: textTheme.labelMedium!.copyWith(color: AppColors.neutralColor500),
//                             ),
//                             TextSpan(
//                                 text: "Terms & Conditions ",
//                                 style: textTheme.labelMedium!.copyWith(
//                                   color: AppColors.actionColor600,
//                                   decoration: TextDecoration.underline,
//                                   decorationColor: AppColors.actionColor600,
//                                 ),
//                                 recognizer: _tapGestureRecognizer),
//                             TextSpan(
//                               text: "and ",
//                               style: textTheme.labelMedium!.copyWith(color: AppColors.neutralColor500),
//                             ),
//                             TextSpan(
//                               text: "Privacy Policy",
//                               style: textTheme.labelMedium!.copyWith(
//                                 color: AppColors.actionColor600,
//                                 decoration: TextDecoration.underline,
//                                 decorationColor: AppColors.actionColor600,
//                               ),
//                             ),
//                           ],
//                         ),
//                         isError: state.hasError, // or whatever condition you're using to determine an error
//                       );
//                     },
//                   ),
//                   CustomCheckboxListTile(
//                     value: value.wantsNewsletter,
//                     onChanged: value.setWantsNewsLetter,
//                     title: TextSpan(
//                       style: textTheme.labelMedium,
//                       children: [
//                         TextSpan(
//                           text: AppLocalizations.of(context)!.newsletterSubscription,
//                           style: textTheme.labelMedium!.copyWith(color: AppColors.neutralColor500),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 1.h,
//                   ),
//                   Column(
//                     children: [
//                       CustomButton(
//                         title: AppLocalizations.of(context)!.signUpButton,
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             value.next();
//                           }
//                         },
//                       ),
//                       SizedBox(
//                         height: 3.h,
//                       ),
//                       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                         Text(AppLocalizations.of(context)!.alreadyHaveAccount, style: textTheme.bodySmall!),
//                         SizedBox(
//                           width: 0.02 * width,
//                         ),
//                         GestureDetector(
//                             onTap: (() {
//                               AppNavigation.pushReplacementTo(AppRoutes.loginWithBankId);
//                             }),
//                             child: Text(AppLocalizations.of(context)!.signUpLoginText,
//                                 style: textTheme.bodySmall!.copyWith(
//                                   color: AppColors.actionColor600,
//                                   decoration: TextDecoration.underline,
//                                   decorationColor: AppColors.actionColor600,
//                                 ))),
//                       ]),
//                     ],
//                   )
//                 ],
//               ),
//             ));
//   }
// }
