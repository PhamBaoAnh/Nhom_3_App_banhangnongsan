import 'package:get_storage/get_storage.dart';

class TLocalStorage {
  static final TLocalStorage _instance = TLocalStorage._internal();

  factory TLocalStorage() {
    return _instance;
  }

  TLocalStorage._internal();
 final _storage = GetStorage();
  // Lưu trữ một giá trị chuỗi
  Future<void> saveData <T>(String key, T value) async {
    await _storage.write(key, value);
  }

  T? readData<T>(String key){
    return _storage.read<T>(key);
  }


  // Xóa giá trị
  Future<void> remove(String key) async {

    await _storage.remove(key);
  }

  Future<void> clearAll()async {

    await _storage.erase();
  }

}
