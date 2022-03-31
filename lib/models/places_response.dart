import 'dart:convert';

class PlacesResponse {
  PlacesResponse({
    required this.type,
    required this.query,
    required this.features,
    required this.attribution,
  });

  final String type;
  final List<String> query;
  final List<Feature> features;
  final String attribution;

  factory PlacesResponse.fromJson(String str) => PlacesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlacesResponse.fromMap(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
        "attribution": attribution,
      };
}

class Feature {
  Feature({
    required this.id,
    required this.type,
    required this.placeType,
    required this.properties,
    required this.textEs,
    required this.placeNameEs,
    required this.text,
    required this.placeName,
    required this.center,
    required this.geometry,
    required this.context,
  });

  final String id;
  final FeatureType? type;
  final List<PlaceType> placeType;
  final Properties properties;
  final String textEs;
  final String placeNameEs;
  final String text;
  final String placeName;
  final List<double> center;
  final Geometry geometry;
  final List<Context> context;

  factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: featureTypeValues.map[json["type"]],
        placeType: List<PlaceType>.from(json["place_type"].map((x) => placeTypeValues.map[x])),
        properties: Properties.fromMap(json["properties"]),
        textEs: json["text_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromMap(json["geometry"]),
        context: List<Context>.from(json["context"].map((x) => Context.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": featureTypeValues.reverse[type],
        "place_type": List<dynamic>.from(placeType.map((x) => placeTypeValues.reverse[x])),
        "properties": properties.toMap(),
        "text_es": textEs,
        "place_name_es": placeNameEs,
        "text": text,
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toMap(),
        "context": List<dynamic>.from(context.map((x) => x.toMap())),
      };
}

class Context {
  Context({
    required this.id,
    required this.textEs,
    required this.text,
    required this.shortCode,
    required this.wikidata,
  });

  final Id? id;
  final String textEs;
  final String text;
  final ShortCode? shortCode;
  final Wikidata? wikidata;

  factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Context.fromMap(Map<String, dynamic> json) => Context(
        id: idValues.map[json["id"]],
        textEs: json["text_es"],
        text: json["text"],
        shortCode: json["short_code"] == null ? null : shortCodeValues.map[json["short_code"]],
        wikidata: json["wikidata"] == null ? null : wikidataValues.map[json["wikidata"]],
      );

  Map<String, dynamic> toMap() => {
        "id": idValues.reverse[id],
        "text_es": textEs,
        "text": text,
        "short_code": shortCode == null ? null : shortCodeValues.reverse[shortCode],
        "wikidata": wikidata == null ? null : wikidataValues.reverse[wikidata],
      };
}

enum Id {
  POSTCODE_6418527313762310,
  PLACE_6089854572752850,
  COUNTRY_12227578366646840,
  POSTCODE_587773031247480
}

final idValues = EnumValues({
  "country.12227578366646840": Id.COUNTRY_12227578366646840,
  "place.6089854572752850": Id.PLACE_6089854572752850,
  "postcode.587773031247480": Id.POSTCODE_587773031247480,
  "postcode.6418527313762310": Id.POSTCODE_6418527313762310
});

enum ShortCode { CO_DC, CO }

final shortCodeValues = EnumValues({"co": ShortCode.CO, "CO-DC": ShortCode.CO_DC});

enum Wikidata { Q2841, Q739 }

final wikidataValues = EnumValues({"Q2841": Wikidata.Q2841, "Q739": Wikidata.Q739});

class Geometry {
  Geometry({
    required this.coordinates,
    required this.type,
  });

  final List<double> coordinates;
  final GeometryType? type;

  factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        type: geometryTypeValues.map[json["type"]],
      );

  Map<String, dynamic> toMap() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": geometryTypeValues.reverse[type],
      };
}

enum GeometryType { POINT }

final geometryTypeValues = EnumValues({"Point": GeometryType.POINT});

enum PlaceType { POI }

final placeTypeValues = EnumValues({"poi": PlaceType.POI});

class Properties {
  Properties({
    required this.foursquare,
    required this.landmark,
    required this.address,
    required this.category,
    required this.maki,
    required this.wikidata,
  });

  final String foursquare;
  final bool landmark;
  final String address;
  final String category;
  final String maki;
  final String wikidata;

  factory Properties.fromJson(String str) => Properties.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        foursquare: json["foursquare"],
        landmark: json["landmark"],
        address: json["address"],
        category: json["category"],
        maki: json["maki"],
        wikidata: json["wikidata"],
      );

  Map<String, dynamic> toMap() => {
        "foursquare": foursquare,
        "landmark": landmark,
        "address": address,
        "category": category,
        "maki": maki,
        "wikidata": wikidata,
      };
}

enum FeatureType { FEATURE }

final featureTypeValues = EnumValues({"Feature": FeatureType.FEATURE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
