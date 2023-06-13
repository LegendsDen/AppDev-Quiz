import 'package:flutter/material.dart';

import 'firstscreen.dart';
import 'question_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class QuizScreen extends StatefulWidget {
  final TextEditingController textController;
  QuizScreen({ this.textController});



  @override
  _QuizPageScreen createState() => _QuizPageScreen();
}
class _QuizPageScreen extends State< QuizScreen> {
   String text;



  Uri apiUrl =Uri.parse('https://opentdb.com/api.php?amount=10&category=17&difficulty=medium&type=multiple');
  int currentQuestion=0;
  QuizModel quizModel;
  int total=0;
  int flag=0;
  int check=0;
  int sum=0;
  int tillquestion=0;
   @override
   void initState() {
     fetchQuiz();
     super.initState();
     text = widget.textController.text;
   }

   fetchQuiz()async {

     var response =await http.get(apiUrl);
     var body =response.body;
     var json =jsonDecode(body);
     setState(() {
       quizModel=QuizModel.fromJson(json);
       quizModel.results[currentQuestion].incorrectAnswers.add(
         quizModel.results[currentQuestion].correctAnswer
       );
       quizModel.results[currentQuestion].incorrectAnswers.shuffle();
     });
   }
   questionChangeForward1(){
     setState(() {
       if(quizModel.results.length-1==currentQuestion) {

       }
       else{
         currentQuestion++;
       }
     });

   }

   questionChangeForward(){
     if(quizModel.results.length-1==currentQuestion){
       SnackBar mysnackbar=SnackBar(
           duration: Duration(seconds: 3),
           content:
           Column(
             children: [
               ListTile(
                 leading: Icon(Icons.scoreboard,
                   size: 50,
                   color: Colors.red,),
                 title: Text(
                   " Final Score: "+total.toString()+"/"+(currentQuestion).toString(),
                   style: TextStyle(
                     fontSize: 30,
                     color: Colors.red,
                   ),

                 ),
                 subtitle: Text(
                   "Well Done,!",
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                     color: Colors.red,

                   ),
                 ),

               ),
             ],
           )
       );

       ScaffoldMessenger.of(context).showSnackBar(mysnackbar);

     }
     else{
       // code need to be written here now to error jo aa rha hai on moving back and next
       if(flag==0) {
         // sum++;
         setState(() {
           currentQuestion++;
           quizModel.results[currentQuestion].incorrectAnswers.add(
               quizModel.results[currentQuestion].correctAnswer
           );
           quizModel.results[currentQuestion].incorrectAnswers.shuffle();
         });
       }
       else if(flag==1){
         questionChangeForward1();
         if(currentQuestion==tillquestion+1){
           flag=0;
         }
       }
     }
   }
   checkAnswer(answer){
     if(quizModel.results[currentQuestion].correctAnswer==answer){
       total++;
       // to fix now score on going back
       // score out of total all seen question till now


     }

     questionChangeForward();
   }
   questionChangeBackward(){
     setState(() {
       if(currentQuestion==0) {

       }
       else{
         currentQuestion--;

       }
     });

   }



  @override

  Widget build (BuildContext context) {


    if(quizModel!=null){
      return Scaffold(
        appBar: AppBar(
          title: Text("Lets,Quiz😉 "+ text+' !',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.red[600],
            ),),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,80,0,0),
                  child: Expanded(
                    child: Text(quizModel.results[currentQuestion].question,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,250,0,0),
              child: Column(
                children: quizModel.results[currentQuestion].incorrectAnswers
                    .map((e) =>  InkWell(
                  onTap: (){

                    checkAnswer(e);



                    },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30,0,0,0),
                    child: Container(

                        padding: EdgeInsets.fromLTRB(70,10,80,10),
                        child:Text(
                          e,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.red,
                          ),)
                    ),
                  ),
                )
                ).toList(),
              ),
            ),
            InkWell(
              onTap: (){

                if(flag==0){
                 questionChangeForward();
                 // if(currentQuestion!=quizModel.results.length-1){
                 //
                 // sum++;}
                }
                else if(flag==1){
                  questionChangeForward1();
                  if(currentQuestion==tillquestion+1){
                    flag=0;
                  }

                //
                }


              }  ,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(260,10,10,10),
                child: Container(

                  // width: 40,
                  // height: 100,
                  // color: Colors.red, giving error
                  decoration: BoxDecoration(
                    // color: Colors.deepPurple,

                    border: Border.all(
                      color: Colors.deepPurple,



                    ),
                    borderRadius:BorderRadius.circular(15),



                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8,2,10,2),
                    child: Text('Next',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),


                    ),
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: (){

                if(flag==0){
                questionChangeBackward();
                tillquestion=currentQuestion;
                // check=tillquestion;
                flag=1;}
                else if(flag==1){
                  questionChangeBackward();

                }


              }  ,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                child: Container(

                  decoration: BoxDecoration(
                    // color: Colors.deepPurple,
                    border: Border.all(
                      color: Colors.deepPurple,


                    ),
                    borderRadius:BorderRadius.circular(15),


                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8,2,10,2),
                    child: Text('Back',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.deepPurple,
                      ),


                    ),
                  ),
                ),
              ),
            ),








            Positioned(
              bottom: 0,
              right: 0,
              child:Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.scoreboard_rounded,
                      color: Colors.red,
                      size: 40,),
                    onPressed: () {
                      if (quizModel.results.length - 1 == currentQuestion) {

                        SnackBar mysnackbar=SnackBar(
                            duration: Duration(seconds: 3),
                            content:
                            Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.scoreboard,
                                    size: 50,
                                    color: Colors.red,),
                                  title: Text(
                                    " Final Score: "+total.toString()+"/"+(currentQuestion).toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.red,
                                    ),

                                  ),
                                  subtitle: Text(
                                    "Well Done,!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,

                                    ),
                                  ),

                                ),
                              ],
                            )
                        );

                        ScaffoldMessenger.of(context).showSnackBar(mysnackbar);

                      }


                      else {
                        SnackBar mysnackbar = SnackBar(
                            duration: Duration(seconds: 1),
                            content:
                            Column(
                              children: [

                                ListTile(


                                  leading: Icon(Icons.timelapse,
                                    size: 50,
                                    color: Colors.red,),
                                  title: Text(
                                    "Score: " + total.toString() + "/" +
                                        (currentQuestion).toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.red,
                                    ),

                                  ),
                                  subtitle: Text(
                                    "Time is Running!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,

                                    ),
                                  ),

                                ),
                              ],
                            )
                        );

                        ScaffoldMessenger.of(context).showSnackBar(mysnackbar);
                      }

                    }




                  ),
                  Text('Score',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red[200]
                    ),



                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child:Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.home,
                      color: Colors.red,
                      size: 40,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text('Home',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red[200]
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),


      );
    }
    else{
      return
       Center(
         child: CircularProgressIndicator(),
       );
    }
  }
}



