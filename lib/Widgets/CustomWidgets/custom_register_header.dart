import 'package:ekvi/Providers/Register/register_provider.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RegisterHeader extends StatelessWidget {
  final bool login;
  final int? step;

  const RegisterHeader({super.key, required this.login, this.step});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer<RegisterProvider>(
        builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 4.h,
                ),
                IconButton(
                  iconSize: 12.h,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "${AppConstant.assetImages}ekvi.svg",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(login ? "Log in" : "Welcome to Ekvi", style: textTheme.displayLarge),
                SizedBox(
                  width: 0.85 * width,
                  child: Text(login ? "Please enter your email to authenticate using bank ID" : "", textAlign: TextAlign.center, style: textTheme.bodySmall),
                ),
              ],
            ));
  }
}
