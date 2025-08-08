import 'package:flutter/material.dart';

import '../../../../utilities/utilities.dart';

class TitleBox extends StatelessWidget {
  const TitleBox({super.key, required this.title, this.subtitle});
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top, left: 16, right: 16, bottom: 16),
        decoration: BoxDecoration(color: AppColors.secondaryColor),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: MediaQuery.sizeOf(context).width / 2,
                height: MediaQuery.sizeOf(context).width / 2,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [AppColors.primaryColor.withValues(alpha: 0.2), AppColors.secondaryColor.withValues(alpha: 0.4)],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8,
              children: [
                Text(title, style: AppStyles.getMediumTextStyle(fontSize: 32, color: Colors.white), textAlign: TextAlign.center),
                if (subtitle != null)
                  Text(subtitle!, style: AppStyles.getMediumTextStyle(fontSize: 16, color: Colors.white), textAlign: TextAlign.center),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
