import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ArticleThumbnail extends StatelessWidget {
  final String? imageURL;
  final String? imagePath;

  const ArticleThumbnail({super.key, this.imageURL, this.imagePath});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.maxFinite,
      child: Stack(
        children: [
          imageURL != null
              ? Image.network(
                  imageURL!,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  height: double.infinity,
                )
              : const SizedBox.shrink(),
          imagePath != null
              ? Image.asset(
                  imagePath!,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  height: double.infinity,
                )
              : const SizedBox.shrink(),
          Positioned(
              top: 50,
              left: 20,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: AppNavigation.goBack,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.neutralColor50.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    '${AppConstant.assetIcons}backIcon.svg',
                    width: 18,
                    height: 18,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
