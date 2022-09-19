import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentScreen extends StatelessWidget {

  TextEditingController paymentController = new TextEditingController();

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
        title: const Text('Payment'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10),
            child: Text(
              "Minimum payment threshold : ",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black87),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                IntrinsicWidth(
                  child: TextField(
                    controller: paymentController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Minimum payment threshold',
                    ),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if(paymentController.text.toString().isNotEmpty)
                    {
                      DocumentReference question = FirebaseFirestore.instance.collection('payment').doc('1');
                      question.set(
                          {
                            "threshold": int.parse(paymentController.text.toString()),
                          }).then((value){
                        //print(value.id);
                      });
                      paymentController.clear();
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
                Spacer(),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 10),
            child: Text(
              "List of payment requests : ",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}