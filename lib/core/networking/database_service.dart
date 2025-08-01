abstract class DatabaseService {
  Future<void> addData({
    String? docId,
    required String path,
    String? subPath,
    String? subPathDocId,
    required Map<String, dynamic> data,
  });
  Future<dynamic> getData({
    required String path,
    String? uId,
    String? subPath,
    String? subPathId,
    Map<String, dynamic>? query,
  });
  Future<dynamic> getCollectionGroup({required String path});
  Stream<dynamic> getStreamData({
    required String path,
    String? uId,
    String? subPath,
    Map<String, dynamic>? query,
  });
  Future<bool> checkIfDataExists({
    required String path,
    required String docId,
    String? subPath,
    String? subPathId,
  });
  Future<void> updateData({
    required String path,
    required String uId,
    required Map<String, dynamic> value,
  });
  Future<void> deleteData({
    required String path,
    String? uId,
    String? subPath,
    String? subPathId,
  });
}
