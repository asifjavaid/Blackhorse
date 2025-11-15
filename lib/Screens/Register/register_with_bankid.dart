// import 'package:ekvi/Providers/Register/register_provider.dart';
// import 'package:ekvi/Routes/app_navigation.dart';
// import 'package:ekvi/Components/Registration/get_credentials.dart';
// import 'package:ekvi/Widgets/CustomWidgets/custom_register_header.dart';
// import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class RegisterWithBankID extends StatefulWidget {
//   const RegisterWithBankID({super.key});

//   @override
//   RegisterWithBankIDState createState() => RegisterWithBankIDState();
// }

// class RegisterWithBankIDState extends State<RegisterWithBankID> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     var provider = Provider.of<RegisterProvider>(AppNavigation.currentContext!, listen: false);
//     provider.resetform();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<RegisterProvider>(
//         builder: (context, value, child) => Scaffold(
//               body: GradientBackground(
//                 child: SingleChildScrollView(
//                   child: SizedBox(
//                     child: SafeArea(
//                         child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//                       child: Column(
//                         children: [
//                           RegisterHeader(
//                             login: false,
//                             step: value.step,
//                           ),
//                           const SizedBox(
//                             height: 24,
//                           ),
//                           if (value.step == 1) ...[
//                             const GetUserCredentials(),
//                           ],
//                         ],
//                       ),
//                     )),
//                   ),
//                 ),
//               ),
//             ));
//   }
// }
