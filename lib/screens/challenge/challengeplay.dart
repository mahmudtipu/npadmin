import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants.dart';

class ChallengeScreen  extends StatefulWidget {
  ChallengeScreen ({Key? key}) : super(key: key);

  @override
  State<ChallengeScreen > createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen > {
  void initState(){
    quest(index);
    super.initState();
  }

  TextEditingController questionController = new TextEditingController();
  List<TextEditingController> _controllers = [];
  List<TextField> _fields = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey, Colors.blueGrey],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        title: const Text('NP Challenge'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10),
            child: Text(
              "Question : $index",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black87),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: questionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter question here',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10),
            child: Text(
              "Options : ",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black87),
            ),
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(child: _listView()),
          )),
          Expanded(child: Container(child: _addTile())),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10),
            child: Text(
              "Correct answer : ",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black87),
            ),
          ),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      c=0;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.black12,
                        child: Center(
                          child: Text(
                            "1",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.black87),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      c=1;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.black12,
                        child: Center(
                          child: Text(
                            "2",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.black87),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      c=2;

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.black12,
                        child: Center(
                          child: Text(
                            "3",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.black87),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      c=3;

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.black12,
                        child: Center(
                          child: Text(
                            "4",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.black87),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                if(questionController.text.toString().isNotEmpty&&c>=0&&_controllers.length>1&&c<_controllers.length)
                {
                  List optionList = [];
                  for (int i = 0; i < _controllers.length; i++) {
                    optionList.add(_controllers[i].text);
                  }
                  //DocumentReference question = FirebaseFirestore.instance.collection('question').doc('1');
                  DocumentReference question = FirebaseFirestore.instance.collection('npquestion').doc('$index');
                  question.set(
                      {
                        "id": index,
                        "question": questionController.text.toString(),
                        "options": FieldValue.arrayUnion(optionList),
                        "answer_index": c,
                      }).then((value){

                  });
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ChallengeScreen();
                        },
                      )
                  );
                  Get.snackbar(
                    "Ready for another question",
                    "Question $index saved successfylly",
                    icon: Icon(Icons.thumb_up_alt_rounded, color: Colors.white),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                  );
                }
              },
              child: Center(child: Text('Save to database')),
              style: ElevatedButton.styleFrom(
                  primary: Colors.black87,
                  onPrimary: Colors.white,
                  shape: StadiumBorder()
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addTile() {
    return ListTile(
      title: Icon(Icons.add),
      onTap: () {
        final controller = TextEditingController();
        final field = TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Option ${_controllers.length + 1}",
          ),
        );

        setState(() {
          _controllers.add(controller);
          _fields.add(field);
        });
      },
    );
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: _fields.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(5),
          child: _fields[index],
        );
      },
    );
  }

  Future<void> quest(int i) async {
    List data = [];

    await FirebaseFirestore.instance.collection("npquestion").get().then(
          (QuerySnapshot snapshot) =>
          snapshot.docs.forEach((f) {
            //data.add(Question(id: f['id'], question: f['question'], answer: f['answer_index'], options: List.from(f['options'])));

            i = f['id'];
            /*  _questions=data
                .map(
                  (question) => Question(
                  id: question['id'],
                  question: question['question'],
                  options: question['options'],
                  answer: question['answer_index']),
            )
                .toList(); */
            //data.add(Question(id: f['id'], question: f['question'], answer: f['answer_index'], options: List.from(f['options'])));
          }),
    );
    setState(() {
      index=i+1;
    });
    // _questions =
  }
}
