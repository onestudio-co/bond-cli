import 'base_validator.dart';

class CompositeValidator<T> implements Validator<T> {
  final List<Validator<T>> validators;

  CompositeValidator(this.validators);

  @override
  bool validate(T value) {
    for (var validator in validators) {
      if (!validator.validate(value)) {
        // This will throw if validation fails
        return false;
      }
    }
    return true;
  }
}
