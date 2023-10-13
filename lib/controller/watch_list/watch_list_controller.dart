import 'dart:developer';

import 'package:get/get.dart';

import '../../data_base/hive_model.dart';

class WatchListController extends GetxController {
  @override
  void onInit() {
    getWatchList();
    super.onInit();
  }

  List<Company> allCompanies = <Company>[];
  void getWatchList() {
    allCompanies.clear();
    var box = CompanyData.getInstance();

    allCompanies = box.values.toList();
    log(allCompanies.toString());
    update();
  }

  void deleteCompany(Company companyToDelete) {
    var box = CompanyData.getInstance();
    int index = allCompanies.indexOf(companyToDelete);
    allCompanies.removeAt(index);
    log("index ***$index");
    try {
      log('${companyToDelete.symbol}');
      box.delete(companyToDelete);
    } catch (e) {
      log('Error deleting from Hive box: $e', error: e);
    }
    print('After deletion: ${box.get(companyToDelete.symbol)}');

    update();
  }
}
