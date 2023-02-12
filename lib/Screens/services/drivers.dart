import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/constants.dart';
import '../models/driver.dart';

class DriverService {
  String collection = 'drivers';

  Stream<List<DriverModel>> getDrivers() {
    return firebaseFiretore.collection(collection).snapshots().map((event) =>
        event.docs.map((e) => DriverModel.fromFirestore(e.data())).toList());
  }

  Future<DriverModel> getDriverById(String id) =>
      firebaseFiretore.collection(collection).doc(id).get().then((doc) {
        return DriverModel.fromFirestore(doc.data());
      });

  Stream<QuerySnapshot> driverStream() {
    CollectionReference reference =
        FirebaseFirestore.instance.collection(collection);
    return reference.snapshots();
  }
}
