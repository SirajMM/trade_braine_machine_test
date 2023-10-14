import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_brains/controller/home/home_controller.dart';

import '../../../core/colors/color.dart';

class CompanyTile extends StatelessWidget {
  const CompanyTile({
    Key? key,
    required this.text,
    required this.controller,
    required this.symbol,
    this.onPressed,
    required this.name,
    required this.matchScore,
  }) : super(key: key);
  final String text;
  final HomeController controller;
  final String symbol;
  final String name;
  final String matchScore;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10).r,
      child: Container(
        height: 70.h,
        color: kPrimaryColor,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      text,
                      style: const TextStyle(
                          color: kPrimaryTextColor,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/stock price.png',
                        height: 20.h,
                        width: 35.w,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        matchScore,
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            letterSpacing: -0.4),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  price(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget price() {
    return SizedBox(
      width: 70.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !controller.isCompanyInStorage(symbol, name)
              ? IconButton(
                  onPressed: onPressed,
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add,
                        size: 22,
                        color: kSecondaryTextColor,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const Text(
                        '     Start\n Watching',
                        style: TextStyle(
                            fontSize: 12,
                            color: kSecondaryTextColor,
                            letterSpacing: -0.1),
                      )
                    ],
                  ),
                )
              : IconButton(
                  onPressed: null,
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.remove_red_eye,
                        size: 20,
                        color: Colors.green,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const Text(
                        'watching',
                        style: TextStyle(color: kSecondaryTextColor),
                      )
                    ],
                  ),
                ),
          // SizedBox(width: 2),
        ],
      ),
    );
  }
}
