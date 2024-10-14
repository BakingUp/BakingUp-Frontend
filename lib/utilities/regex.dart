RegExp removeTrailingZeros = RegExp(r'([.]*0)(?!.*\d)');

String extractUnit(String unitString) {
  final RegExp unitRegExp = RegExp(r'\b(kg|l|ml|g)\b');
  final match = unitRegExp.firstMatch(unitString);
  if (match != null) {
    return match.group(0)!;
  }
  return '';
}
