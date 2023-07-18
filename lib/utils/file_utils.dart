import 'dart:async';
import 'dart:io';

import 'package:bond_cli/utils/print_utils.dart';

/// Creates a new file from a [path] and [value].
Future<bool> createNewFile(String path, String value) async {
  final file = File(path);

  try {
    if (!await file.exists()) {
      await file.create(recursive: true);
      await file.writeAsString(value);
      return true;
    }
  } catch (e) {
    ConsolePrinter.error('Failed to create file: $path');
    ConsolePrinter.error(e.toString());
  }

  return false;
}

/// Creates a new directory from a [path].
Future<bool> createNewDirectory(String path) async {
  final directory = Directory(path);

  try {
    if (!await directory.exists()) {
      await directory.create(recursive: true);
      return true;
    }
  } catch (e) {
    ConsolePrinter.error('Failed to create directory: $path');
    ConsolePrinter.error(e.toString());
  }

  return false;
}
