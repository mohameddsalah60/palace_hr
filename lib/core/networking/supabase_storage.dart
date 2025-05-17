import 'dart:io';

import 'package:palace_hr/core/errors/exceptions.dart';
import 'package:palace_hr/core/networking/constants_database_path.dart';
import 'package:palace_hr/core/networking/storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as b;

import '../errors/api_error_handler.dart';

class SupabaseStorage implements StorageService {
  static late Supabase supabase;

  static Future<void> initSupabase() async {
    supabase = await Supabase.initialize(
      url: ConstantsDatabasePath.kSupabaseUrl,
      anonKey: ConstantsDatabasePath.kSupabaseKey,
    );
  }

  @override
  Future<String> uploudFile({required File file, required String path}) async {
    String fileName = b.basename(file.path);
    String fileEx = b.extension(file.path);

    try {
      await supabase.client.storage
          .from('usersimages')
          .upload("imagesUser/$fileName.$fileEx", file);

      final String publicUrl = supabase.client.storage
          .from('usersimages')
          .getPublicUrl("imagesUser/$fileName.$fileEx");
      return publicUrl;
    } catch (e) {
      throw CustomException(message: ApiErrorHandler.handleError(e).errMessage);
    }
  }
}
