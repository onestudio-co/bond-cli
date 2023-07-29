import 'dart:io';

import 'package:bond_cli/utils/print_utils.dart';

class CommandRunnerHelper {
  /// Run the build runner for the given [path].
  static void runBuildRunner(String path) async {
    try {
      var result = await Process.run('dart', [
        'run',
        'build_runner',
        'build',
        '--delete-conflicting-outputs',
        '--build-filter="$path*.dart"'
      ]);

      ConsolePrinter.success(result.stdout);
      ConsolePrinter.error(result.stderr);
    } catch (err) {
      ConsolePrinter.error(err.toString());
      rethrow;
    }
  }
}
