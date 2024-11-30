extension StringExtension on String {
  String get lastChar => isEmpty ? '' : this[length - 1];
}
