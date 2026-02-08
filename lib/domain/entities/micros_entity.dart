import 'package:equatable/equatable.dart';

class MicronutrientItem {
  final String key;
  final double value;

  MicronutrientItem({required this.key, required this.value});
}

class MicrosEntity extends Equatable {
  final Map<String, double> nutrients;

  const MicrosEntity({required this.nutrients});

  List<MicronutrientItem> get top6 {
    final entries = nutrients.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return entries
        .take(6)
        .map(
          (e) => MicronutrientItem(
            key: _formatNutrientName(e.key),
            value: e.value,
          ),
        )
        .toList();
  }

  String _formatNutrientName(String key) {
    return key
        .replaceAll('_mg', '')
        .replaceAll('_mcg', '')
        .replaceAll('_dfe_mcg', '')
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (word) =>
              word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1),
        )
        .join(' ');
  }

  @override
  List<Object?> get props => [nutrients];
}
