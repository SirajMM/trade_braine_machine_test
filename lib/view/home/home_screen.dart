import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trade_brains/controller/home/home_controller.dart';
import 'package:trade_brains/core/colors/color.dart';

import 'widgets/company_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: kBackgroundColor,

      body: GetBuilder<HomeController>(builder: (value) {
        return Column(
          children: [
            Expanded(
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  begin: const Alignment(0, 0.8),
                  end: Alignment.bottomCenter,
                  colors: [
                    kBackgroundColor,
                    kBackgroundColor.withOpacity(0),
                  ],
                ).createShader(bounds),
                blendMode: BlendMode.dstATop,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      // padding: const EdgeInsets.only(top: 64, bottom: 24),
                      children: [
                        const Align(
                          child: Text(
                            'Trade Brains',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 40.h,
                          child: SearchBar(
                            hintText: 'Search Companies',
                            controller: value.searchController,
                            leading: const Icon(Icons.search),
                            trailing: [
                              value.searchController.text.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        value.searchController.clear();
                                      },
                                      icon: const Icon(Icons.clear))
                                  : const SizedBox()
                            ],
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 10.h, vertical: 0)),
                            surfaceTintColor: const MaterialStatePropertyAll(
                                Colors.transparent),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10).r)),
                            onChanged: (query) {
                              value.debouncer.run(() {
                                value.getCompanies(query.trim().toUpperCase());
                                log('debouncer called ');
                              });
                            },
                          ),
                        ),
                        value.loading != true
                            ? Padding(
                                padding: EdgeInsets.only(top: 10.h),
                                child: SizedBox(
                                    height: 522.h,
                                    child: value.companyData?.bestMatches
                                                .length !=
                                            0
                                        ? ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              final data = value.companyData
                                                  ?.bestMatches[index];
                                              return CompanyTile(
                                                text: data!.the2Name ?? '',
                                                controller: controller,
                                                symbol: data.the1Symbol ?? '',
                                                name: data.the2Name ?? '',
                                                matchScore:
                                                    data.the9MatchScore ?? '',
                                                onPressed: () {
                                                  log('${value.companyData?.bestMatches[index].the1Symbol}');
                                                  value.addToWatchList(index);
                                                },
                                              );
                                            },
                                            separatorBuilder: (context, _) =>
                                                SizedBox(
                                              height: 10.h,
                                            ),
                                            itemCount: value.companyData
                                                    ?.bestMatches.length ??
                                                0,
                                          )
                                        : const Center(
                                            child: Text(
                                              'No Company found!',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                              )
                            : SizedBox(
                                height: 550.h,
                                child: Center(
                                  child: CupertinoActivityIndicator(
                                    color: Colors.white,
                                    radius: 20.r,
                                  ),
                                ),
                              )
                      ],
                    )),
              ),
            ),
          ],
        );
      }),
    );
  }
}
