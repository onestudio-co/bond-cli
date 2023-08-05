import 'package:bond_cli/core/utils.dart';

String modelStub(
    String modelName, bool useJsonSerializable, bool useEquatable) {
  return '''
import 'package:bond_network/bond_network.dart';

class ${modelName.toTitleCase()} extends Model {
  const ${modelName.toTitleCase()}({required int id}) : super(id: id);

${useJsonSerializable ? _jsonSerializableCode(modelName) : ""}
${useEquatable ? _equatableCode(modelName) : ""}
}
''';
}

String _jsonSerializableCode(String modelName) => '''
  factory ${modelName.toTitleCase()}.fromJson(Map<String, dynamic> json) => _\$${modelName.toTitleCase()}FromJson(json);

  Map<String, dynamic> toJson() => _\$${modelName.toTitleCase()}ToJson(this);
''';

String _equatableCode(String modelName) => '''
  @override
  List<Object> get props => [id];
  ''';
