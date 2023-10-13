import 'package:hive_flutter/hive_flutter.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 1)
class Company {
  @HiveField(0)
  String? symbol;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? currency;
  @HiveField(3)
  String? matchScore;

  Company({
    required this.symbol,
    required this.name,
    required this.currency,
    required this.matchScore,
  });
}

class CompanyData {
  static Box<Company>? _box;
  static Box<Company> getInstance() {
    return _box ??= Hive.box('company_data');
  }
}
