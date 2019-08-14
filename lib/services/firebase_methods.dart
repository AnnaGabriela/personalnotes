import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseMethods {
  final _firestore = Firestore.instance;

  Future<Map<String, dynamic>> getUserInfo(
      Future<AuthResult> user, String title, String email) async {
    String collection = title == 'Aluno' ? 'students' : 'academy';
    var query = await _firestore
        .collection(collection)
        .where("email", isEqualTo: email)
        .getDocuments();

    if (query.documents.length >= 1) return query.documents.first.data;

    return null;
  }
}
