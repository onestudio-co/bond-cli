import 'package:args/command_runner.dart';

import '../GithubExampleTask.dart';

class MySampleCommand extends Command<void> {
  @override
  String get name => 'github-example-command';

  @override
  String get description => 'Description of your command.';

  @override
  void run() async {
    final myTask = MySampleTask();
    await myTask.run();
  }
}