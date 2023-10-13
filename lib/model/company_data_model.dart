// To parse this JSON data, do
//
//     final companyData = companyDataFromJson(jsonString);

import 'dart:convert';

CompanyDetails companyDataFromJson(String str) =>
    CompanyDetails.fromJson(json.decode(str));

String companyDataToJson(CompanyDetails data) => json.encode(data.toJson());

class CompanyDetails {
  List<BestMatch> bestMatches;

  CompanyDetails({
    required this.bestMatches,
  });

  factory CompanyDetails.fromJson(Map<String, dynamic> json) => CompanyDetails(
        bestMatches: List<BestMatch>.from(
            json["bestMatches"].map((x) => BestMatch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bestMatches": List<dynamic>.from(bestMatches.map((x) => x.toJson())),
      };
}

class BestMatch {
  String? the1Symbol;
  String? the2Name;
  The3Type? the3Type;
  The4Region? the4Region;
  The5MarketOpen? the5MarketOpen;
  The6MarketClose? the6MarketClose;
  The7Timezone? the7Timezone;
  The8Currency? the8Currency;
  String? the9MatchScore;

  BestMatch({
    required this.the1Symbol,
    required this.the2Name,
    required this.the3Type,
    required this.the4Region,
    required this.the5MarketOpen,
    required this.the6MarketClose,
    required this.the7Timezone,
    required this.the8Currency,
    required this.the9MatchScore,
  });

  factory BestMatch.fromJson(Map<String, dynamic> json) => BestMatch(
        the1Symbol: json["1. symbol"],
        the2Name: json["2. name"],
        the3Type: the3TypeValues.map[json["3. type"]],
        the4Region: the4RegionValues.map[json["4. region"]],
        the5MarketOpen: the5MarketOpenValues.map[json["5. marketOpen"]],
        the6MarketClose: the6MarketCloseValues.map[json["6. marketClose"]],
        the7Timezone: the7TimezoneValues.map[json["7. timezone"]],
        the8Currency: the8CurrencyValues.map[json["8. currency"]],
        the9MatchScore: json["9. matchScore"],
      );

  Map<String, dynamic> toJson() => {
        "1. symbol": the1Symbol,
        "2. name": the2Name,
        "3. type": the3TypeValues.reverse[the3Type],
        "4. region": the4RegionValues.reverse[the4Region],
        "5. marketOpen": the5MarketOpenValues.reverse[the5MarketOpen],
        "6. marketClose": the6MarketCloseValues.reverse[the6MarketClose],
        "7. timezone": the7TimezoneValues.reverse[the7Timezone],
        "8. currency": the8CurrencyValues.reverse[the8Currency],
        "9. matchScore": the9MatchScore,
      };
}

enum The3Type { EQUITY }

final the3TypeValues = EnumValues({"Equity": The3Type.EQUITY});

enum The4Region { INDIA_BOMBAY }

final the4RegionValues = EnumValues({"India/Bombay": The4Region.INDIA_BOMBAY});

enum The5MarketOpen { THE_0915 }

final the5MarketOpenValues = EnumValues({"09:15": The5MarketOpen.THE_0915});

enum The6MarketClose { THE_1530 }

final the6MarketCloseValues = EnumValues({"15:30": The6MarketClose.THE_1530});

enum The7Timezone { UTC_55 }

final the7TimezoneValues = EnumValues({"UTC+5.5": The7Timezone.UTC_55});

enum The8Currency { INR }

final the8CurrencyValues = EnumValues({"INR": The8Currency.INR});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
