import 'package:admin_panel/model/patient_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_provider.dart';

class PatientProvider extends AuthProvider{
  List<PatientsModel> _patientsList = List<PatientsModel>();
  get patientList => _patientsList;

  Future<void> getPatients()async{
    try{
      await FirebaseFirestore.instance.collection('Patients').get().then((snapShot){
        _patientsList.clear();
        snapShot.docChanges.forEach((element) {
          PatientsModel patients=PatientsModel(
              id: element.doc['id'],
              name: element.doc['name'],
              imageUrl: element.doc['imageUrl'],
              address: element.doc['address'],
              age: element.doc['age'],
              bloodGroup: element.doc['bloodGroup'],
              city: element.doc['city'],
              country: element.doc['country'],
              countryCode: element.doc['countryCode'],
              currency: element.doc['currency'],
              email: element.doc['email'],
              gender: element.doc['gender'],
              joinDate: element.doc['joinDate'],
              phone: element.doc['phone'],
              state: element.doc['state'],
              takenTeleService: element.doc['takenTeleService']
          );
          _patientsList.add(patients);
        });
      });
      notifyListeners();
      loadingMgs = '';
    }catch(error){
      print(error.toString());
      loadingMgs = '';
    }
  }


}