import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_app/datamodel/tripmodel.dart';

ValueNotifier<List<TripModel>> tripnotifier = ValueNotifier([]);

// add to db
class TripDb extends ChangeNotifier {
  var box1 = Hive.openBox<TripModel>('tripdb');
  Future<void> addUser(TripModel trip) async {
    var box = await box1;
    await box.add(trip);
    await getUser();
  }

// get datas from db
  Future getUser() async {
    var box = await box1;

    tripnotifier.value.clear();
    tripnotifier.value.addAll(box.values.toList());
    tripnotifier.notifyListeners();
  }

// add diary to db
  Future<void> addJournalToTrip(int tripKey, journalModel, newJournal) async {
    var box = await box1;
    TripModel? trip = box.get(tripKey);

    if (trip != null) {
      trip.journalKeys = (trip.journalKeys ?? [])..add(newJournal);
      await box.put(tripKey, trip);
    }
    await getUser();
  }

  // delete from db
  Future deleteUser(int key) async {
    var box = await box1;
    await box.delete(key);
    await getUser();
  }

// edit from db
  Future editUser(int key, TripModel updatedTrip) async {
    var box = await box1;
    await box.put(key, updatedTrip);
    await getUser();
  }
}
