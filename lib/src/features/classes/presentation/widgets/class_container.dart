import 'dart:math' as math;
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utilities/utilities.dart';
import '../../models/class_models.dart';

class ClassContainer extends StatelessWidget {
  const ClassContainer({super.key, required this.classModel, this.onTap});
  final ClassModel classModel;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: CachedNetworkImageProvider(classModel.banner ?? ""), fit: BoxFit.cover),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withValues(alpha: 0.15),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.15), // Frosted glass border
                    width: 1.5,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(classModel.title ?? "", style: AppStyles.getSemiBoldTextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        radius: 30,
                        child: Transform.rotate(angle: math.pi * 3 / 4, child: Icon(Icons.arrow_back, size: 30, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
