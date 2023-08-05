import 'package:bond_cli/core/utils.dart';
import 'package:interact/interact.dart';
import 'package:meta/meta.dart';

import 'actionable.dart';
import 'task.dart';

abstract class Tasks with Actionable {
  List<Task> get tasks;

  final spinners = MultiSpinner();

  @override
  Future<void> run() async {
    final mainSpinner = spinners.add(Spinner(
      icon: '✅',
      rightPrompt: (done) => done
          ? '$actionDescription successfully!'
          : '$actionDescription, please wait...',
    ));
    try {
      await execute();
      mainSpinner.done();
    } catch (error) {
      ConsolePrinter.error(error.toString());
      rethrow;
    }
  }

  @protected
  @override
  Future<void> execute() async {
    for (var task in tasks) {
      task.spinners = spinners;
      await task.run();
    }
  }
}
