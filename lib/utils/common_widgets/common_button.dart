import 'package:flutter/material.dart';
import 'package:product_test/utils/constants/app_colors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key, required this.title, required this.onTap,
  });

  final String title;
  final Function() onTap;
  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primary
        ),
        child: Center(child: Text(title,style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white
        ),)),
      ),
    );
  }
}