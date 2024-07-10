extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ')
      .replaceAll("_", " ");

  String toSnakeCase() =>
      replaceAllMapped(RegExp(r'(?<=[a-z])[A-Z]'), (Match match) {
        return '_${match.group(0)?.toLowerCase()}';
      }).toLowerCase().replaceAll(RegExp(r'\s+'), '_');
}

extension NullableStringExt on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}
