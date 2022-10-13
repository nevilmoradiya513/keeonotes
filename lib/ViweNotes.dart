import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keeonotes/AddNotes.dart';

class ViweNotes extends StatefulWidget {
  @override
  State<ViweNotes> createState() => _ViweNotesState();
}
class _ViweNotesState extends State<ViweNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ViweNotes"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("AddNotes").snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
          {
            if(snapshot.hasData)
            {
              if(snapshot.data.size<=0)
              {
                return Center(
                  child: Text("NO DATA"),
                );
              }
              else
              {
                return ListView(
                  children: snapshot.data.docs.map((document){
                    return Container(
                      width: 215,
                      height: 213,
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(15.0),
                      color: Colors.black26,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(height: 9.0,),
                              Text(document["title"].toString()),
                              SizedBox(height: 9.0,),
                              Text(document["remark"].toString()),
                              SizedBox(height: 9.0,),
                              Text(document["time"].toString()),
                              SizedBox(height: 9.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: ()async{
                                      AlertDialog alert = new AlertDialog(
                                        title: Text("Warning!",style: TextStyle(color: Colors.white),),
                                        backgroundColor: Colors.red,
                                        content: Text("Are you sure?"),
                                        actions: [
                                          ElevatedButton(onPressed: ()async{
                                            var docid = document.id.toString();
                                            await FirebaseFirestore.instance.collection("AddNotes").doc(docid).delete();
                                            Navigator.of(context).pop();
                                          }, child: Text("Yes")),
                                          ElevatedButton(onPressed: (){
                                          }, child: Text("No")),
                                        ],
                                      );
                                      showDialog(context: context, builder: (BuildContext context){
                                        return alert;
                                      });
                                    },
                                    child: Text("DELETE"),
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
                                    ),
                                  ),
                                  ElevatedButton(onPressed: (){
                                  }, child:Text("UPDATE")
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            }
            else
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      ),
      floatingActionButton:
      FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> AddNotes())
          );
        } ,
        child: Icon(Icons.add),
      ),
    );
  }
}
