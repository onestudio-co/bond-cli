extension StringExtension on String {
  /// Converts a string to Title Case.
  String toTitleCase() {
    if (isEmpty) {
      return this;
    }

    return split(' ').map((word) => word._toCapitalized()).join(' ');
  }

  /// Capitalizes the first letter of the string.
  String _toCapitalized() {
    if (isEmpty) {
      return this;
    }

    return this[0].toUpperCase() + (length > 1 ? substring(1) : '');
  }
}
