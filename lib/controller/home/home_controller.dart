// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trade_brains/core/constrains/api_key.dart';
import 'package:trade_brains/core/constrains/api_url.dart';
import 'package:trade_brains/model/company_data_model.dart';

import '../../data_base/hive_model.dart';
import '../../helper/debouncer.dart';

class HomeController extends GetxController implements GetxService {
  @override
  void onInit() {
    log('init called');
    loadData();
    super.onInit();
  }

  TextEditingController searchController = TextEditingController();
  CompanyDetails? companyData;
  bool loading = false;
  Debouncer debouncer = Debouncer(milliseconds: 500);

  Future<void> getCompanies(String? query) async {
    log('search query ******************$query');
    if (query == null || query == '') {
      return;
    }
    loading = !loading;
    update();
    final uri = Uri.parse('$searchUrl$query&apikey=$apiKey');
    try {
      final response = await http.get(uri);
      log('response data ${response.body}');
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        if (data["bestMatches"] != null) {
          companyData = CompanyDetails.fromJson(data);
        } else {
          log('Failed to get data');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
    loading = !loading;
    update();
  }

  Future<void> addToWatchList(int index) async {
    Company company = Company(
      symbol: companyData!.bestMatches[index].the1Symbol,
      name: companyData!.bestMatches[index].the2Name,
      currency: companyData!.bestMatches[index].the8Currency.toString(),
      matchScore: companyData!.bestMatches[index].the9MatchScore,
    );
    var box = CompanyData.getInstance();
    box.add(company);
    update();
  }

  bool isCompanyInStorage(symbol, name) {
    var box = CompanyData.getInstance();
    List<Company> allCompanies = box.values.toList();
    return allCompanies
        .any((company) => company.symbol == symbol && company.name == name);
  }

  void onChanged(String query) {
    getCompanies(query);
    update();
  }

  void loadData() async {
    bool isInternetConnected = await checkInternetConnectivity();
    if (!isInternetConnected) {
      Get.snackbar(
        'No Internet',
        'Please check your network connection.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      Get.dialog(AlertDialog(
        title: const Text('No Internet Connection'),
        content: const Text("Please connect to internet and press 'OK'"),
        actions: [
          Row(
            children: [
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              TextButton(
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  loadData();
                  Get.back();
                },
              ),
            ],
          )
        ],
      ));
      return;
    }

    update();
  }

  Future<bool> checkInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
