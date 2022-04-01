// To parse this JSON data, do
//
//     final modelDataProvince = modelDataProvinceFromJson(jsonString);

import 'dart:convert';

ModelDataProvince modelDataProvinceFromJson(String str) => ModelDataProvince.fromJson(json.decode(str));

String modelDataProvinceToJson(ModelDataProvince data) => json.encode(data.toJson());

class ModelDataProvince {
    ModelDataProvince({
        required this.locations,
    });

    List<Location> locations;

    factory ModelDataProvince.fromJson(Map<String, dynamic> json) => ModelDataProvince(
        locations: List<Location>.from(json["locations"].map((x) => Location.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
    };
}

class Location {
    Location({
        required this.name,
        required this.death,
        required this.cases,
        required this.casesToday,
    });

    String name;
    int death;
    int cases;
    int casesToday;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        death: json["death"],
        cases: json["cases"],
        casesToday: json["casesToday"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "death": death,
        "cases": cases,
        "casesToday": casesToday,
    };
}
