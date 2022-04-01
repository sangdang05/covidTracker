import 'dart:convert';
ModelStatsticGeneral modelStatsticGeneralFromJson(String str) => ModelStatsticGeneral.fromJson(json.decode(str));
String modelStatsticGeneralToJson(ModelStatsticGeneral data) => json.encode(data.toJson());
class ModelStatsticGeneral {
    ModelStatsticGeneral({
        required this.total,
        required this.today,
    });
    Today total;
    Today today;
    factory ModelStatsticGeneral.fromJson(Map<String, dynamic> json) => ModelStatsticGeneral(
        total: Today.fromJson(json["total"]),today: Today.fromJson(json["today"]),
    );
    Map<String, dynamic> toJson() => {
        "total": total.toJson(),
        "today": today.toJson(),
    };
}


class Today {
    Today({
        required this.internal,
    });
    Internal internal;
    factory Today.fromJson(Map<String, dynamic> json) => Today(
        internal: Internal.fromJson(json["internal"]),
    );
    Map<String, dynamic> toJson() => {
        "internal": internal.toJson(),
    };
}
class Internal {
    Internal({
        required this.cases,required this.recovered,required this.death,required this.active,
    });
    int cases;int recovered;int death;int active;
    factory Internal.fromJson(Map<String, dynamic> json) => Internal(
        cases: json["cases"],
        recovered: json["recovered"],
        death: json["death"],
        active: json["cases"] - (json["recovered"] + json["death"])
    );
    Map<String, dynamic> toJson() => {
        "cases": cases,
        "recovered": recovered,
        "death": death,
        "active": active
    };
}
