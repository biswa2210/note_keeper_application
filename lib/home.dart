import 'package:flutter/material.dart';
import 'package:note_keeper_app/screens/note_detail.dart';
import './screens/note_list.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:note_keeper_app/models/note.dart';
import 'package:intl/intl.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Keeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: NoteList(),
    );
  }
}
