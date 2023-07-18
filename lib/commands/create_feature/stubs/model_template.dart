import 'package:bond_cli/utils/string_extensions.dart';

String modelStub({required String modelName}) => '''
import 'package:bond_network/bond_network.dart';

class ${modelName.toTitleCase()} extends Model {
  const ${modelName.toTitleCase()}({required int id}) : super(id: id);
}
''';
