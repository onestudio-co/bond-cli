mixin Actionable<T> {
  String get actionDescription;

  Future<T> execute();

  Future<T> run();
}
