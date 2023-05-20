import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_note/style/appstyle.dart';
import 'package:flutter/material.dart';

class NoteReader extends StatefulWidget {
  NoteReader(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<NoteReader> createState() => _NoteReaderState();
}

class _NoteReaderState extends State<NoteReader> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc["color_id"];
    return Scaffold(
      backgroundColor: Appstyle.cardColor[color_id],
      appBar: AppBar(
        backgroundColor: Appstyle.cardColor[color_id],
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Appstyle.cardColor[widget.doc['color_id']],
          borderRadius: BorderRadius.circular(8),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.doc["note_title"],
                style: Appstyle.mainTitle,
              ),
              SizedBox(
                height: 28,
              ),
              Text(
                widget.doc["creation_date"],
                style: Appstyle.dateTitle,
              ),
              Text(
                widget.doc["note_content"],
                style: Appstyle.mainContent,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
