import 'package:bond_cli/core/utils.dart';
import 'package:interact/interact.dart';
import 'package:meta/meta.dart';

import 'actionable.dart';

abstract class Task<T> with Actionable<T> {
  MultiSpinner? spinners;

  @override
  Future<T> run() async {
    final spinner = Spinner(
      icon: '🎉',
      rightPrompt: (done) =>
          done ? ' $actionDescription successfully!' : ' $actionDescription, please wait...',
    );

    final SpinnerState spinnerState;
    if (spinners != null) {
      spinnerState = spinners!.add(spinner);
    } else {
      spinnerState = spinner.interact();
    }
    try {
      final results = await execute();
      spinnerState.done();
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
