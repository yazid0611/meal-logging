class MicronutrientFormatter {
  static final Map<String, String> _nutrientDisplayNames = {
    'vitamin_b7_mcg': 'Vitamin B7 (mcg)',
    'vitamin_b3_mg': 'Vitamin B3 (mg)',
    'vitamin_b5_mg': 'Vitamin B5 (mg)',
    'sodium_mg': 'Sodium (mg)',
    'vitamin_b6_mg': 'Vitamin B6 (mg)',
    'vitamin_a_mcg': 'Vitamin A (mcg)',
    'vitamin_b9_dfe_mcg': 'Vitamin B9 DFE (mcg)',
    'chlorine_mg': 'Chlorine (mg)',
    'choline_mg': 'Choline (mg)',
    'vitamin_k_mcg': 'Vitamin K (mcg)',
    'magnesium_mg': 'Magnesium (mg)',
    'vitamin_c_mg': 'Vitamin C (mg)',
    'potassium_mg': 'Potassium (mg)',
    'phosphorus_mg': 'Phosphorus (mg)',
  };

  static String formatNutrientName(String key) {
    return _nutrientDisplayNames[key] ?? _autoFormat(key);
  }

  static String _autoFormat(String key) {
    final parts = key.split('_');
    final unit = parts.length > 1 ? parts.last : '';
    final nameParts = parts.sublist(0, parts.length - (unit.isEmpty ? 0 : 1));
    final formattedName = nameParts
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
    
    return unit.isEmpty ? formattedName : '$formattedName (${unit.toUpperCase()})';
  }
}