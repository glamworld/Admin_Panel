import 'package:admin_panel/model/forum_model.dart';
import 'package:admin_panel/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_panel/model/forum_ans_model.dart';
class ForumProvider extends AuthProvider {

  List<ForumModel> _allQuesList = List();
  List<ForumAnsModel> _answerList = List();


  get allQuesList=> _allQuesList;

  get answerList=> _answerList;


  Future<void> getAllQuestionList()async{
    try{
      await FirebaseFirestore.instance.collection('ForumQuestions').orderBy('timeStamp',descending: true).get().then((snapshot){
        _allQuesList.clear();
        snapshot.docChanges.forEach((element) {
          ForumModel forumModel = ForumModel(
            id: element.doc['id'],
            patientId: element.doc['patientId'],
            patientPhotoUrl: element.doc['patientPhotoUrl'],
            quesDate: element.doc['quesDate'],
            question: element.doc['question'],
            totalAns: element.doc['totalAns'],
          );
          _allQuesList.add(forumModel);
        });
      });
      notifyListeners();
      print(_allQuesList.length);

    }catch(error){}
  }

  Future<void> getForumAnswer(String quesId)async{
    try{
      await FirebaseFirestore.instance.collection('ForumAnswers').where('quesId', isEqualTo: quesId).get().then((snapshot)async{
        _answerList.clear();
        snapshot.docChanges.forEach((element) {
          ForumAnsModel forumAnsModel = ForumAnsModel(
            id: element.doc['id'],
            quesId: element.doc['quesId'],
            drId: element.doc['drId'],
            drName: element.doc['drName'],
            drPhotoUrl: element.doc['drPhotoUrl'],
            drDegree: element.doc['drDegree'],
            answer: element.doc['answer'],
            ansDate: element.doc['ansDate'],
            timeStamp: element.doc['timeStamp'],
          );
          _answerList.add(forumAnsModel);
        });
      });
      notifyListeners();
    }catch(error){}

  }
}