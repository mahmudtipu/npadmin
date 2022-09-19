import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:npadmin/screens/dailyplay/dailyplay.dart';

import '../constants.dart';
import 'challenge/challengeplay.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController timeinput = TextEditingController();
  void initState(){

    timeinput.text = "";
    super.initState();
  }

  TextEditingController timeController = new TextEditingController();
  TextEditingController prizeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextEditingController npController = new TextEditingController();
    TextEditingController descController = new TextEditingController();

    return Stack(
      children: [
        Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    'Daily Play',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 30.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(DailyPlayScreen());
                    },
                    child: Text('Continue'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        shape: StadiumBorder()
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  onTap: ()=>{
                    Get.to(ChallengeScreen())
                  },
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Card(
                      color: Colors.white38,
                      elevation: 4,
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          "Time",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(color: Colors.black87),
                                        ),
                                      ),
                                      IntrinsicWidth(
                                          child: Container(
                                              padding: EdgeInsets.all(15),
                                              child:Center(
                                                  child:TextField(
                                                    controller: timeinput, //editing controller of this TextField
                                                    decoration: InputDecoration(
                                                        icon: Icon(Icons.timer), //icon of text field
                                                        labelText: "Enter Time" //label text of field
                                                    ),
                                                    readOnly: true,  //set it true, so that user will not able to edit text
                                                    onTap: () async {
                                                      TimeOfDay? pickedTime =  await showTimePicker(
                                                        initialTime: TimeOfDay.now(),
                                                        context: context,
                                                      );

                                                      if(pickedTime != null ){
                                                        // print(pickedTime.format(context));   //output 10:51 PM
                                                        // DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                                        // //converting to DateTime so that we can further format on different pattern.
                                                        // print(parsedTime); //output 1970-01-01 22:53:00.000
                                                        // String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                                                        // print(formattedTime); //output 14:59:00
                                                        //DateFormat() is from intl package, you can format the time on any pattern you need.
                                                        String a = pickedTime.format(context);

                                                        setState(() {
                                                          timeinput.text = a; //set the value of text field.
                                                        });
                                                      }else{
                                                        print("Time is not selected");
                                                      }
                                                    },
                                                  )
                                              )
                                          )
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          "Prize Money",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(color: Colors.black87),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: IntrinsicWidth(
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.digitsOnly
                                            ],
                                            controller: prizeController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Prize amount',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: npController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'NP Challenge',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: descController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Win the prize money!',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if(npController.text.toString().isNotEmpty&&descController.text.toString().isNotEmpty&&prizeController.text.toString().isNotEmpty&&timeinput.text.toString().isNotEmpty)
                                      {
                                        DocumentReference question = FirebaseFirestore.instance.collection('texts').doc('1');
                                        question.set(
                                            {
                                              "title": npController.text.toString(),
                                              "desc": descController.text.toString(),
                                              "prize": int.parse(prizeController.text.toString()),
                                              "time": timeinput.text.toString(),
                                            }).then((value){
                                          //print(value.id);
                                        });
                                        npController.clear();
                                        descController.clear();
                                        prizeController.clear();
                                        timeinput.clear();
                                      }
                                    //DocumentReference question = FirebaseFirestore.instance.collection('question').doc('1');
                                  },
                                  child: Center(child: Text('Save')),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.black87,
                                      onPrimary: Colors.white,
                                      shape: StadiumBorder()
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}