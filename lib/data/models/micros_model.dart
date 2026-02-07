import 'package:meal_logging/domain/entities/micros_entity.dart';

class MicrosModel {
  final Map<String, double> nutrients;

  MicrosModel({required this.nutrients});

  factory MicrosModel.fromJson(Map<String, dynamic> json) {
    return MicrosModel(
      nutrients: Map<String, double>.from(json['nutrition'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'nutrition': nutrients};
  }

  MicrosEntity toEntity() {
    return MicrosEntity(nutrients: nutrients);
  }
}