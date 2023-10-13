import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/colors/color.dart';
import '../../../data_base/hive_model.dart';

class WatchlistTile extends StatelessWidget {
  const WatchlistTile({
    Key? key,
    this.onPressed,
    required this.company,
  }) : super(key: key);
  final Company company;

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
              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10).r,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      company.name!,
                      style: const TextStyle(
                          color: kPrimaryTextColor,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  Text(
                    company.matchScore!,
                    style: const TextStyle(color: Colors.green),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  removeButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget removeButton() {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.delete_outline,
        size: 20,
        color: Colors.red,
      ),
    );
  }
}
