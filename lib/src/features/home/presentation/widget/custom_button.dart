import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utilities/utilities.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, this.onTap});
  final String title;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: AppStyles.filledButton(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0)),
      onPressed: onTap,
      child: Row(
        children: [
          Transform.translate(
            offset: Offset(0, 1),
            child: Text(title, style: AppStyles.getRegularTextStyle(fontSize: 14, color: Colors.white)),
          ),
          const SizedBox(width: 8),
          CircleAvatar(radius: 12, backgroundColor: Colors.white, child: SvgPicture.asset(AppImages.rightArrowSvg, height: 15, width: 15)),
        ],
      ),
    );
  }
}
