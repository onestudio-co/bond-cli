extension StringExtension on String {
  /// Converts a string to Title Case. e.g. hello world -> Hello World
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
    /// Check if the name is alphanumeric.
    if (!startsWith(RegExp(r'^[a-zA-Z]+$'))) {
      return false;
    }

    /// Check if the name is not a Dart reserved word.
    if (['do', 'if', 'in', 'for', 'new', 'var'].contains(this)) {
      return false;
    }

    return true;
  }

  /// Converts a string to snake_case. e.g. hello world -> hello_world
  String toSnakeCase() {
    if (isEmpty) {
      return this;
    }

    return split(' ').map((word) => word.toLowerCase()).join('_');
  }
}
