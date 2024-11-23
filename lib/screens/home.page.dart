import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home',style: TextStyle(color: Colors.white, fontSize: 40),
      ),
      centerTitle: true,
      backgroundColor: Colors.blueGrey,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                children:[
                  CircleAvatar(
                    backgroundImage: AssetImage("images/amongus.jpg"),
                    radius: 30,
                    ),
                    Text(
                      "Dalal AZIZ",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      "dalal@gmail.com",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )
                ],
              ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Covid Tracker'),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Emsi Chatbot'),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                trailing: const Icon(Icons.arrow_forward),
                title: Text('Settings'),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              //Divider(color :Colors.blue),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: (){
                  Navigator.pop(context);
                },
              )
          ],
        ),
      ),
      body : Center(
         child:Text("Welcome to the home page ", 
      style: TextStyle(color : Colors.blueGrey,fontSize: 30)),
      )
    );
  }
}