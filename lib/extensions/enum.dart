abstract class AppEnum<T> {
  final T _value;

  const AppEnum(this._value);

  T get value => _value;
}
