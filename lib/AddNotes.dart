import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:keeonotes/ViweNotes.dart';

class AddNotes extends StatefulWidget {

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {

  TextEditingController _title= TextEditingController();
  TextEditingController _remark = TextEditingController();
  var dt="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AddNotes"),
      ),
      body:SingleChildScrollView(
        child: Column
          (
          children:
          [
            SizedBox(height: 25.0,),
            Text("TITLE"),
            TextField(
              controller: _title,
              decoration: InputDecoration(
                hintText: "title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Text("RMARK",style: TextStyle(
              fontSize: 15.0
            ),),
            TextField(
              controller: _remark,
              decoration: InputDecoration(
                hintText: "remark",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                SizedBox(
                  height: 300.0,
                  width: 200.0,
                  child: DateTimePicker(
                    initialValue: '',
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Date',
                    onChanged: (val){
                      setState(() {
                        dt=val;
                      });
                    }  , validator: (val) {
                    print(val);
                    return null;
                  },
                    onSaved: (val) => print(val),
                  ),
                ),
              ],
            ),
            ElevatedButton(onPressed: () async{
              var ti =_title.text.toString();
              var rk =_remark.text.toString();
              var date= dt.toString();
              await FirebaseFirestore.instance.collection("AddNotes").add({
                "title":ti,
                "remark":rk,
                "time": date,
              }).
              then((value){
                setState((){
                  _title.text="";
                  _remark.text="";
                  dt ="";
                });
              });
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>ViweNotes(),));
            }, child: Text("submit")
            ),
          ],
        ),
      ),
    );
  }
}


