import 'package:bond_cli/core/utils.dart';

String widgetStub(String name, String type) {
  switch (type) {
    case 'stateful':
      return _statefulWidgetStub(name);

    case 'consumer':
      // TODO: Handle this case.
      return _consumerWidgetStub(name);

    case 'stateless':
    default:
      return _statelessWidgetStub(name);
  }
}

String _statelessWidgetStub(String name) {
  return '''
import 'package:flutter/material.dart';

class ${name.toTitleCase()} extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
'''
      .trim();
}

String _consumerWidgetStub(String name) {
  return '''
   '''
      .trim();
}

String _statefulWidgetStub(String name) {
  return '''
import 'package:flutter/material.dart';

class ${name.toTitleCase()} extends StatefulWidget {
  @override
  _${name.toTitleCase()}State createState() => _${name.toTitleCase()}State();
}

class _${name.toTitleCase()}State extends State<$name.toTitleCase()> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
'''
      .trim();
}
