import 'package:cloud_firestore/cloud_firestore.dart';

import 'database_service.dart';

class FirestoreService implements DatabaseService {
  FirebaseFirestore firestoreService = FirebaseFirestore.instance;

  @override
  Future<void> addData({
    required String path,
    String? docId,
    String? subPath,
    String? subPathDocId,
    required Map<String, dynamic> data,
  }) async {
    if (docId != null && subPath != null && subPathDocId != null) {
      await firestoreService
          .collection(path)
          .doc(docId)
          .collection(subPath)
          .doc(subPathDocId)
          .set(data);
    } else if (docId != null && subPath != null) {
      await firestoreService
          .collection(path)
          .doc(docId)
          .collection(subPath)
          .add(data);
    } else if (docId != null) {
      await firestoreService.collection(path).doc(docId).set(data);
    } else {
      await firestoreService.collection(path).add(data);
    }
  }

  @override
  Future<dynamic> getData({
    required String path,
    String? uId,
    String? subPath,
    String? subPathId,
    Map<String, dynamic>? query,
  }) async {
    if (uId == null && subPath == null) {
      var data = await firestoreService.collection(path).get();
      return data.docs.map((e) => e.data()).toList();
    }
    if (uId != null && subPath == null) {
      var data = await firestoreService.collection(path).doc(uId).get();
      return data.data();
    }

    if (uId != null && subPath != null && subPathId != null) {
      var data =
          await firestoreService
              .collection(path)
              .doc(uId)
              .collection(subPath)
              .doc(subPathId)
              .get();
      return data.data();
    }

    if (uId != null && subPath != null) {
      Query<Map<String, dynamic>> data = firestoreService
          .collection(path)
          .doc(uId)
          .collection(subPath);

      if (query != null) {
        if (query['orderBy'] != null && query['where'] != null) {
          var orderByField = query['orderBy'];
          var descending = query['descending'] ?? false;
          var whereField = query['where'];
          var isEqualTo = query['isEqualTo'];

          data = data
              .where(whereField, isEqualTo: isEqualTo)
              .orderBy(orderByField, descending: descending);
        }
        if (query['where'] != null) {
          var whereField = query['where'];
          var isEqualTo = query['isEqualTo'];
          data = data.where(whereField, isEqualTo: isEqualTo);
        }
        if (query['orderBy'] != null) {
          var orderByField = query['orderBy'];
          var descending = query['descending'] ?? false;
          data = data.orderBy(orderByField, descending: descending);
        }
        if (query['whereRange'] != null) {
          var range = query['whereRange'];
          var field = range['field'];
          var isGreaterThanOrEqualTo = range['isGreaterThanOrEqualTo'];
          var isLessThan = range['isLessThan'];
          data = data
              .where(field, isGreaterThanOrEqualTo: isGreaterThanOrEqualTo)
              .where(field, isLessThan: isLessThan);
        }
      }

      var result = await data.get();
      return result.docs.map((e) => e.data()).toList();
    }
  }

  @override
  Stream<dynamic> getStreamData({
    required String path,
    String? uId,
    String? subPath,
    Map<String, dynamic>? query,
  }) async* {
    try {
      Query<Map<String, dynamic>> collectionRef;
      if (uId != null && subPath != null) {
        collectionRef = firestoreService
            .collection(path)
            .doc(uId)
            .collection(subPath);
      } else {
        collectionRef = firestoreService.collection(path);
      }

      if (query != null) {
        if (query['where'] != null && query['isEqualTo'] != null) {
          collectionRef = collectionRef.where(
            query['where'],
            isEqualTo: query['isEqualTo'],
          );
        }

        if (query['orderBy'] != null) {
          collectionRef = collectionRef.orderBy(
            query['orderBy'],
            descending: query['descending'] ?? false,
          );
        }
      }

      await for (var snapshot in collectionRef.snapshots()) {
        yield snapshot.docs.map((doc) => doc.data()).toList();
      }
    } catch (e) {
      yield* Stream.error(e);
    }
  }

  @override
  Future<bool> checkIfDataExists({
    required String path,
    String? docId,
    String? subPath,
    String? subPathId,
  }) async {
    if (docId != null && subPath != null && subPathId != null) {
      var data =
          await firestoreService
              .collection(path)
              .doc(docId)
              .collection(subPath)
              .doc(subPathId)
              .get();
      return data.exists;
    }

    var data = await firestoreService.collection(path).doc(docId).get();
    return data.exists;
  }

  @override
  Future<void> updateData({
    required String path,
    required String uId,
    required Map<String, dynamic> value,
  }) async {
    await firestoreService.collection(path).doc(uId).update(value);
  }

  @override
  Future<void> deleteData({
    required String path,
    String? uId,
    String? subPath,
    String? subPathId,
  }) async {
    if (uId != null && subPath != null && subPathId != null) {
      await firestoreService
          .collection(path)
          .doc(uId)
          .collection(subPath)
          .doc(subPathId)
          .delete();
      return;
    }

    await firestoreService.collection(path).doc(uId).delete();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getCollectionGroup({
    required String path,
  }) async {
    return FirebaseFirestore.instance.collectionGroup(path).get();
  }
}
