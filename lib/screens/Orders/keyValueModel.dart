class KeyValueModel {
  String key;
  String value;

  KeyValueModel({required this.key, required this.value});

  @override
  String toString() {
    return this.key;
  }
}