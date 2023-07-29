extension StringExtension on String {
  /// Converts a string to Title Case.
  String toTitleCase() {
    if (isEmpty) {
      return this;
    }

    return split(' ').map((word) => word.toCapitalized()).join(' ');
  }

  /// Capitalizes the first letter of the string.
  String toCapitalized() {
    if (isEmpty) {
      return this;
    }

    return this[0].toUpperCase() + (length > 1 ? substring(1) : '');
  }

  bool isValidModelName() {
    /// Check if the name is alphanumeric and doesn't start with a number.
    if (!startsWith(RegExp(r'[a-zA-Z_$][a-zA-Z_$0-9]*'))) {
      return false;
    }

    /// Check if the name is not a Dart reserved word.
    if (['do', 'if', 'in', 'for', 'new', 'var'].contains(this)) {
      return false;
    }

    return true;
  }
}
