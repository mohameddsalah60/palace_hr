import 'dart:io';

abstract class StorageService {
  Future<String> uploudFile({required File file, required String path});
}
