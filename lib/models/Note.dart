import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:note_keeper_app/models/note.dart';
import 'package:intl/intl.dart';

class Note{
  int _id;
  String _title;
  String _descrip;
  String  _date;
  int _priortyLevel;
  Note(this._title,this._date,this._priortyLevel,[this._descrip]);
  Note.withId(this._id,this._title,this._date,this._priortyLevel,[this._descrip]);
  int get id =>_id;
  String get title =>_title;
  String get descrip => _descrip;
  int get priority => _priortyLevel;
  String get date=>_date;
  set title(String newTitle){
    if(newTitle.length<=255){
      this._title=newTitle;
    }
  }
  set description(String newDescription){
    if(newDescription.length<=255){
      this._descrip=newDescription;
    }
  }
  set priority(int newPriority){
    if(newPriority>=1 && newPriority<=2){
      this._priortyLevel=newPriority;
    }
  }
  set date(String newDate){
    this._date=newDate;
  }
  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    if(id!=null){
      map['id']=_id;
    }
    map['title']=_title;
    map['description']=_descrip;
    map['priority']=_priortyLevel;
    map['date']=_date;
    return map;
  }
  Note.fromMapObject(Map<String,dynamic> map){
    this._id=map['id'];
    this._title=map['title'];
    this._descrip=map['description'];
    this._priortyLevel=map['priority'];
    this._date=map['date'];
  }
}