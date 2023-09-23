import '../core/task.dart';

class GithubExampleTask extends Task<void> {
  @override
  String get actionDescription => 'Description of your task';

  @override
  Future<void> execute() async {
    print("This task shall just print this words to you as a prove how implementing a new task works ^_^" );
  }
}