import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Employee").where("uid",isEqualTo: uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container(
          child: Column(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return Container(
                color: Colors.green[700],
                width: double.infinity,
                height: 200,
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,190,3),
                      child: greetings(),
                    ),
                    Text(
                      document.data()["Fullname"],
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Text(
                      document.data()["role"],
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    ));
  }
}

Widget greetings()
{
  DateTime now = DateTime.now();
  var hour = now.hour;
  if(hour<12)
  {
    return Text(" Good Morning,",style: TextStyle(fontSize: 15),);
  }
  else if(hour==12)
  {
    return Text(" Good Afernoon,");
  }
  else
  
    return Text(" Good Evening,");
  
}
