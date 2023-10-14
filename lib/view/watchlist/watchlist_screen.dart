import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/watch_list/watch_list_controller.dart';
import '../../core/colors/color.dart';
import 'widgets/watch_list_tile.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WatchListController controller = Get.put(WatchListController());
    controller.getWatchList();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Watchlist',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: GetBuilder<WatchListController>(builder: (value) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Company',
                    style: TextStyle(color: kSecondaryTextColor, fontSize: 18),
                  ),
                  Text(
                    'matchScore',
                    style: TextStyle(color: kSecondaryTextColor, fontSize: 18),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: value.allCompanies.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final data =
                            value.allCompanies.reversed.toList()[index];
                        return WatchlistTile(
                          company: data,
                          onPressed: () {
                            value.deleteCompany(data);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10.h,
                          ),
                      itemCount: value.allCompanies.length)
                  : const Center(
                      child: Text(
                        'Watchlist is empty !.',
                        style:
                            TextStyle(color: kSecondaryTextColor, fontSize: 20),
                      ),
                    ),
            ),
          ]),
        );
      }),
    );
  }
}
