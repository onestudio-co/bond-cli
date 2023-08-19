import 'package:bond_cli/core/utils.dart';

String dtoStub(String name) {
  return '''
class ${name.toTitleCase()}Dto {
  ${name.toTitleCase()}Dto();

  Map<String, dynamic> get body => {};
}
''';
}
