import 'package:meal_logging/domain/entities/micros_entity.dart';

class MicrosModel {
  final Map<String, double> nutrients;

  MicrosModel({required this.nutrients});

  factory MicrosModel.fromJson(Map<String, dynamic> json) {
    final Map<String, double> nutrients = {};
    json.forEach((key, value) {
      if (value is num) {
        nutrients[key] = value.toDouble();
      }
    });

    return MicrosModel(nutrients: nutrients);
  }

  Map<String, dynamic> toJson() {
    return nutrients;
  }

  MicrosEntity toEntity() {
    return MicrosEntity(nutrients: nutrients);
  }
}
