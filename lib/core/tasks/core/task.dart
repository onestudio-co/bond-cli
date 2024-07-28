import 'package:bond_cli/core/utils.dart';
import 'package:interact/interact.dart';
import 'package:meta/meta.dart';

import 'actionable.dart';

abstract class Task<T> with Actionable<T> {
  MultiSpinner? spinners;

  @override
  Future<T> run() async {
    final spinner = Spinner(
      icon: '✅',
      rightPrompt: (done) =>
          done ? ' $actionDescription' : ' $actionDescription ...',
    );

    final SpinnerState? spinnerState;
    if (spinners != null) {
      spinnerState = null;
    } else {
      spinnerState = spinner.interact();
    }
    try {
      final results = await execute();
      spinnerState?.done();
      return results;
    } catch (error) {
      ConsolePrinter.error(error.toString());
      rethrow;
    }
  }

  @protected
  @override
  Future<T> execute();
}
