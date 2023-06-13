import 'package:flutter/material.dart';
import 'quizscreen.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenPage createState() => _FirstScreenPage();
}
class _FirstScreenPage extends State<FirstScreen> {
   TextEditingController _textController=TextEditingController();

   @override
   void dispose() {
     _textController.dispose();
     super.dispose();
   }


   @override
  Widget build (BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,70,0,0),
            child: ListTile(
              leading: Icon(Icons.laptop,size: 30,color: Colors.red,),
              title: Text('My App Quiz',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.red,
                ),

              ),
            subtitle: Text('A Coding Club Project',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.red[200],
            ),
            ),


            //
            ),
          ),
          // Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(10,200,10,0),
            child: TextField(
              style: TextStyle(
                fontSize: 30,
                color: Colors.blue[600],
              ),
              controller:_textController ,
              decoration: InputDecoration(
                hintText: 'Enter Your Name',
                border: OutlineInputBorder(


                  borderRadius:const BorderRadius.all(
                    Radius.circular(30.0),
                  )
                ),
                hintStyle: TextStyle(
                  fontSize: 30,

                ),
                suffixIcon: GestureDetector(
                  onTap: _textController.clear,
                  child: Icon(Icons.clear,
                    size: 40,
                    color: Colors.black,


                  ),
                ),

              ),


            ),
          ),
          InkWell(
            onTap:()=> Navigator.push(
              context,
              MaterialPageRoute(builder:(context)=>QuizScreen( textController: _textController)),

            ) ,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(280,15,15,20),
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(5.0),
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.grey),
                //
                //     borderRadius: BorderRadius.circular(100)
                // ),
                child: Text("Enter",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.blue[100]
                ),),
              ),
            ),
          ),

        ],
      ),




    );
  }

}