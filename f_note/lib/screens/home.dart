import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_note/screens/noteeditor.dart';
import 'package:f_note/style/appstyle.dart';
import 'package:f_note/widgets/notecard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'notereader.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.mainColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("F Notes", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Appstyle.mainColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your recent notes",
            style: GoogleFonts.roboto(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("fnotes").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    children: snapshot.data!.docs
                        .map((note) => noteCard(
                            () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NoteReader(note),
                                    ),
                                  ),
                                },
                            note))
                        .toList(),
                  );
                }
                return Text(
                  "There's no notes",
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NoteEditor()));
            },
            label: Text(
              "Add New Notes",
            ),
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
