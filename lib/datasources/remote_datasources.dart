import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import '../constant.dart';
import '../models/request_model.dart';

class RemoteDatasource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final dio = Dio();

  Stream<List<RequestModel>> getRequests() {
    try {
      var data = firestore.collection("request").snapshots().map(
        (event) {
          var result = event.docs.map(
            (e) {
              return RequestModel.fromJson(e.id, e.data());
            },
          ).toList();

          result.sort(
            (a, b) => b.createdAt.compareTo(a.createdAt),
          );
          return result;
        },
      );

      return data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future addRequest(RequestModel request) async {
    try {
      var data = await firestore.collection('request').add({
        'permintaanPerbaikan': request.permintaanPerbaikan,
        'catatanPermintaan': request.catatanPermintaan,
        'statusPengerjaan': request.statusPengerjaan,
        'catatanPengerjaan': request.catatanPengerjaan,
        'createdAt': request.createdAt.toString(),
        'updatedAt': request.updatedAt.toString(),
      });

      return data.id;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> editRequest(RequestModel request) async {
    try {
      await firestore.collection('request').doc(request.id).update({
        'permintaanPerbaikan': request.permintaanPerbaikan,
        'catatanPermintaan': request.catatanPermintaan,
        'statusPengerjaan': request.statusPengerjaan,
        'catatanPengerjaan': request.catatanPengerjaan,
        'createdAt': request.createdAt.toString(),
        'updatedAt': DateTime.now().toString(),
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteRequest(String id) async {
    try {
      await firestore.collection('request').doc(id).delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> sendNotification(String title, String content) async {
    try {
      await dio.post(oneSignalUrl,
          data: {
            "app_id": oneSignalAppID,
            "included_segments": ["Total Subscriptions"],
            "headings": {"en": title},
            "contents": {"en": content}
          },
          options: Options(headers: {
            "Authorization": oneSignalKey,
          }));
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
