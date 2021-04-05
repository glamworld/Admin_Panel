import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context, var auth) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder:(context){
          return AlertDialog(
            content: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Expanded(child: Text(auth.loadingMgs,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey[700]))),
              ],
            ),
          );
        }
    );
}

void showSnackBar(GlobalKey<ScaffoldState> scaffoldKey,message) {
  scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content: Text(message,
          style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
      backgroundColor: Colors.deepOrange,
      elevation: 0,
    ),
  );
}

void showAlertDialog(BuildContext context, String message){
  showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Status'),
          content: Text(message),
        );
      }
  );
}