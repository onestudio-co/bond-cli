class ConsolePrinter {
  // Escape code for colors
  static const String _redColor = '\x1B[31m';
  static const String _greenColor = '\x1B[32m';
  static const String _yellowColor = '\x1B[33m';
  static const String _defaultColor = '\x1B[0m';
  static const String _infoColor = '\x1B[36m';

  static void error(String message) {
    print('$_redColor$message$_defaultColor');
  }

  static void success(String message) {
    print('$_greenColor$message$_defaultColor');
  }

  static void warning(String message) {
    print('$_yellowColor$message$_defaultColor');
  }

  static void info(String message) {
    print('$_infoColor$message$_defaultColor');
  }
}
