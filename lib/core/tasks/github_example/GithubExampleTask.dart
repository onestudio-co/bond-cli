import '../core/task.dart';

class MySampleTask extends Task<void> {
  @override
  String get actionDescription => 'Description of your task';

  @override
  Future<void> execute() async {
    print("This is task shall just print this words to you as a prove how implementing a new task works ^_^" );
  }
}