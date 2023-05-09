import 'package:brew_project/models/brew.dart';
import 'package:brew_project/models/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUser(String sugars, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({'sugars': sugars, 'name': name, 'strength': strength});
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map<Brew>((doc) {
      return Brew(
          name: doc.get('name') ?? "",
          strength: doc.get('strength') ?? 0,
          sugars: doc.get('sugars') ?? "0");
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid!,
        name: snapshot['name'],
        strength: snapshot['strength'],
        sugars: snapshot['sugars']);
  }

  Stream<List<Brew>> get brews {
    return brewCollection
        .snapshots()
        // .map((QuerySnapshot snapshot) => _brewListFromSnapshot(snapshot));
        .map((_brewListFromSnapshot));
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
