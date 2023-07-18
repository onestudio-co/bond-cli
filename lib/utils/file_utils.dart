import 'dart:async';
import 'dart:io';

/// Creates a new file from a [path] and [value].
Future<void> createNewFile(String path, String value) async {
  final file = File(path);

  if (!await file.exists()) {
    await file.create(recursive: true);
  }

  await file.writeAsString(value);
}

/// Creates a new directory from a [path].
Future<void> createNewDirectory(String path) async {
  final directory = Directory(path);

  if (!await directory.exists()) {
    await directory.create(recursive: true);
  }
}
