import 'package:bond_cli/utils/string_extensions.dart';

String modelStub({required String modelName, required bool jsonSerializable}) =>
    jsonSerializable
        ? _modelWithJsonSerializable(modelName)
        : _simpleModel(modelName);

String _modelWithJsonSerializable(String modelName) => '''
import 'package:bond_network/bond_network.dart';
import 'package:json_annotation/json_annotation.dart';

part '$modelName.g.dart';

@JsonSerializable(explicitToJson: true)
class ${modelName.toTitleCase()} extends Model {
  const ${modelName.toTitleCase()}({required int id}) : super(id: id);

  factory ${modelName.toTitleCase()}.fromJson(Map<String, dynamic> json) => _\$${modelName.toTitleCase()}FromJson(json);

  Map<String, dynamic> toJson() => _\$${modelName.toTitleCase()}ToJson(this);
}
''';

String _simpleModel(String modelName) => '''
import 'package:bond_network/bond_network.dart';

class ${modelName.toTitleCase()} extends Model {
  const ${modelName.toTitleCase()}({required int id}) : super(id: id);
}
''';
