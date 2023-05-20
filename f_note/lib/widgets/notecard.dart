import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_note/style/appstyle.dart';
import 'package:flutter/material.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Appstyle.cardColor[doc['color_id']],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doc["note_title"], style: Appstyle.mainTitle,),
          SizedBox(
                  height: 8,
          ),
          Text(doc["creation_date"], style: Appstyle.dateTitle,),
          Text(doc["note_content"], style: Appstyle.mainContent,
          overflow: TextOverflow.ellipsis,)
        ],
      ),
    ),
  );
}
