import 'dart:convert';

ModelTimeline ModelTimelineFromJson(String str) => ModelTimeline.fromJson(json.decode(str));

String ModelTimelineToJson(ModelTimeline data) => json.encode(data.toJson());

class ModelTimeline {
    ModelTimeline({
        required this.overview,
    });

    List<Overview> overview;

    factory ModelTimeline.fromJson(Map<String, dynamic> json) => ModelTimeline(
        overview: List<Overview>.from(json["overview"].map((x) => Overview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "overview": List<dynamic>.from(overview.map((x) => x.toJson())),
    };
}

class Overview {
    Overview({
        required this.date,
        required this.death,
        required this.cases,
        required this.recovered,
        required this.avgCases7Day,
        required this.avgRecovered7Day,
        required this.avgDeath7Day,
    });

    String date;
    int death;
    int cases;
    int recovered;
    int avgCases7Day;
    int avgRecovered7Day;
    int avgDeath7Day;

    factory Overview.fromJson(Map<String, dynamic> json) => Overview(
        date: json["date"],
        death: json["death"],
        cases: json["cases"],
        recovered: json["recovered"],
        avgCases7Day: json["avgCases7day"],
        avgRecovered7Day: json["avgRecovered7day"],
        avgDeath7Day: json["avgDeath7day"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "death": death,
        "cases": cases,
        "recovered": recovered,
        "avgCases7day": avgCases7Day,
        "avgRecovered7day": avgRecovered7Day,
        "avgDeath7day": avgDeath7Day,
    };
}
