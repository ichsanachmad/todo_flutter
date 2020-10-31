import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ToDo {
  String id;
  String subject;
  String body;
  Timestamp noted;
  bool isComplete;

  ToDo(this.id,
      {@required this.subject,
      @required this.body,
      @required this.noted,
      @required this.isComplete});

  static ToDo fromSnapshots(DocumentSnapshot snapshot) {
    return ToDo(
      snapshot.id,
      body: snapshot['body'],
      isComplete: snapshot['is_complete'],
      noted: snapshot['noted'],
      subject: snapshot['subject'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'subject': subject,
      'noted': noted,
      'is_complete': isComplete,
      'body': body
    };
  }
}
