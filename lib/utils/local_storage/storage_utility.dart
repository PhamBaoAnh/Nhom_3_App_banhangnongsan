import 'package:get_storage/get_storage.dart';

class TLocalStorage {
  late final GetStorage _storage;

  static TLocalStorage? _instance;

  // Private constructor
  TLocalStorage._internal();

  // Factory method for singleton
  factory TLocalStorage.instance() {
    if (_instance == null) {
      throw Exception('TLocalStorage is not initialized. Call init() first.');
    }
    return _instance!;
  }

  // Static method to initialize the storage
  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = TLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  // Save a value
  Future<void> saveData(String key, dynamic value) async {
    await _storage.write(key, value);
  }

  // Read a value
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  // Remove a value
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  // Clear all data
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
