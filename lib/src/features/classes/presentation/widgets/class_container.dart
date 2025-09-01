import 'dart:math' as math;
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utilities/utilities.dart';
import '../../models/class_models.dart';

class ClassContainer extends StatelessWidget {
  const ClassContainer({super.key, required this.classModel, this.onTap, this.padding = 8});
  final Classes classModel;
  final VoidCallback? onTap;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: CachedNetworkImageProvider(classModel.banner ?? ""), fit: BoxFit.cover),
        ),
        padding: EdgeInsets.all(padding),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
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
                        child: Text(
                          classModel.title ?? "",
                          // softWrap: false,
                          style: AppStyles.getSemiBoldTextStyle(fontSize: 16, color: Colors.white),
                          maxLines: 2,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 25,
                      child: Transform.rotate(angle: math.pi * 3 / 4, child: Icon(Icons.arrow_back, size: 25, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
