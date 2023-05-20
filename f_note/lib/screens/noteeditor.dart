import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_note/style/appstyle.dart';
import 'package:flutter/material.dart';

class NoteEditor extends StatefulWidget {
  const NoteEditor({Key? key}) : super(key: key);

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  int color_id = Random().nextInt(Appstyle.cardColor.length);
  String date = DateTime.now().toString();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.cardColor[color_id],
      appBar: AppBar(
        backgroundColor: Appstyle.cardColor[color_id],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Add a new note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Note Title",
            ),
            style: Appstyle.mainTitle,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            date,
            style: Appstyle.dateTitle,
          ),
          SizedBox(
            height: 28,
          ),
          TextField(
            controller: _mainController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Note Content",
            ),
            style: Appstyle.mainContent,
          ),
          FloatingActionButton(
            backgroundColor: Appstyle.accentColor,
            onPressed: () async {
              FirebaseFirestore.instance
                  .collection("fnotes")
                  .add({
                    "note_title": _titleController,
                    "creation_date": date,
                    "note_content": _mainController,
                    "color_id": color_id
                  })
                  .then((value) => {
                        print(value.id),
                        Navigator.pop(context),
                      })
                  .catchError(
                      (error) => print("Failed to add new note due to $error"));
            },
            child: Icon(Icons.save),
          )
        ],
      ),
    );
  }
}
