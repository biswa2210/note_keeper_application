import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:note_keeper_app/models/note.dart';
import 'package:note_keeper_app/utils/database_helper.dart';
import 'package:note_keeper_app/screens/note_detail.dart';
import 'package:sqflite/sqflite.dart';


class NoteList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(

      appBar: AppBar(
        title: Text('Notes'),
      ),

      body: noteList.isEmpty? showsadface():getNoteListView(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(Note('', '', 2), 'Add Note');
        },

        tooltip: 'Add Note',

        child: Icon(Icons.add),

      ),
    );
  }
    LayoutBuilder showsadface(){
    return LayoutBuilder(builder:(ctx,contraints){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[Container(
          child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: contraints.maxHeight*0.05,
          ),
          Container(
              height: contraints.maxHeight*0.20,
              child:AutoSizeText("NO NOTES ADDED YET",
                  minFontSize: 28,
                  maxFontSize: 42,
                  style:TextStyle(fontFamily: 'CB'
                  )
              )),
          SizedBox(
            height: contraints.maxHeight*0.05,
          ),
          Container(
            height:contraints.maxHeight*0.45,
            child: Image.asset('assets/images/sadface.png',fit:BoxFit.cover),

          ),
          SizedBox(
            height:contraints.maxHeight*0.25 ,
          )
        ],
      ))]);
    });
    }
  ListView getNoteListView() {

    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: CircleAvatar(
              backgroundColor: getPriorityColor(this.noteList[position].priority),
              child: getPriorityIcon(this.noteList[position].priority),
            ),

            title: Text(this.noteList[position].title, style: titleStyle,),

            subtitle: Text(this.noteList[position].date),

            trailing: GestureDetector(
              child: MediaQuery.of(context).size.width>460 ?
              FlatButton.icon(
                icon: Icon(Icons.delete),
                color:Theme.of(context).errorColor,
                label: Text('Delete'),
                onPressed: () =>  _delete(context, noteList[position]),
              ):
              IconButton(
                icon: Icon(Icons.delete),
                color:Theme.of(context).errorColor,
                onPressed: () =>  _delete(context, noteList[position]),
              ),
            ),


            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetail(this.noteList[position],'Edit Note');
            },

          ),
        );
      },
    );
  }

  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.green;
        break;
      case 2:
        return Colors.lightGreenAccent;
        break;

      default:
        return Colors.lightGreenAccent;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.keyboard_arrow_up);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_down);
        break;

      default:
        return Icon(Icons.keyboard_arrow_down);
    }
  }

  void _delete(BuildContext context, Note note) async {

    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
