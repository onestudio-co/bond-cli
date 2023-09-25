import 'package:args/command_runner.dart';
import 'package:bond_cli/core/tasks/github_example/github_example_task.dart';


class GithubExampleCommand extends Command<void> {
  @override
  String get name => 'github-example-command';

  @override
  String get description => 'Description of your command.';

  @override
  void run() async {
    final myTask = GithubExampleTask();
    await myTask.run();
  }
}