import 'package:bond_cli/core/utils.dart';

String widgetStub(String name, String type) {
  switch (type) {
    case 'stateful':
      return _statefulWidgetStub(name);

    case 'consumer':
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
  const ${name.toTitleCase()}({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
'''
      .trim();
}

String _statefulWidgetStub(String name) {
  return '''
import 'package:flutter/material.dart';

class ${name.toTitleCase()} extends StatefulWidget {
  const ${name.toTitleCase()}({super.key});
  
  @override
  State<${name.toTitleCase()}> createState() => _${name.toTitleCase()}State();
}

class _${name.toTitleCase()}State extends State<${name.toTitleCase()}> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
'''
      .trim();
}

String _consumerWidgetStub(String name) {
  return '''
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ${name.toTitleCase()} extends ConsumerWidget {
  const ${name.toTitleCase()}({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Placeholder();
  }
}
   '''
      .trim();
}
