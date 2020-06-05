import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:health_tech_app1/Views/widget_AppBarPage.dart';
import 'package:health_tech_app1/Views/widget_BuyPage.dart';
import 'package:health_tech_app1/Views/widget_EditProfilePage.dart';
import 'package:health_tech_app1/Views/widget_HomePage.dart';
import 'package:health_tech_app1/Views/widget_MojoPage.dart';
import 'package:health_tech_app1/utility/DBWebService_FireBase_Authentication.dart';

class MyHomePage extends StatefulWidget {
 // MyHomePage({Key key, this.title}) : super(key: key);
 //final String title;

 MyHomePage
 ({
   this.auth,
   this.onSignedOut
 });

 final AuthImplementation auth;
 final VoidCallback onSignedOut;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex =0;
  final List<Widget> _children =
  [
    MyHomePage(),
    MojoPage(),
    BuyPage()
  ];
  
   void onTapped(int index)
   {
           setState(() {
             _currentIndex = index;
           });
   } 


  void logOutUser() async
  {
     try
     {
      await widget.auth.signOut();
      widget.onSignedOut;
     }
     catch(e)
     {
        print("Error:"+e.toString());
     }
  }

  @override
  Widget build(BuildContext context) {

   
    return Scaffold(
      // appBar:  AppBar
      //         (
      //         //  title: Container(
      //         //           alignment: Alignment.center,
      //         //           child: Text("Home Page",style: TextStyle(color: Colors.white,fontSize: 20.0),),
      //         //    ),
      //            backgroundColor: Colors.pink,
      //             //elevation property is used to set elevation to AppBar in Android Device.
      //            elevation: defaultTargetPlatform == TargetPlatform.android ?5.0 : 0.0,
      //          ),
      
       appBar: header(context,strTitle: "Home"),
         
       drawer: navigationDrawer(),

       body: _children[_currentIndex],

       bottomNavigationBar: myBottomNavigationBar(),
    );
  }
  

  Widget navigationDrawer()
  {
    return new Drawer(
          // ListView is used to create  static list of items.  
          child: new ListView(
            children: <Widget>[
              //useraccountsdrawerheader is used to show user accounts details on drawer.
              new UserAccountsDrawerHeader(
                 accountName: new Text("Ganesh"),
                 accountEmail: new Text("ganesh@gmail.com"),
                 currentAccountPicture: new CircleAvatar(
                   backgroundColor: Theme.of(context).platform==TargetPlatform.iOS 
                   ? Colors.pink:Colors.white,
                   child: new Text("G"),
                 ),
                 otherAccountsPictures: <Widget>[
                   new CircleAvatar(
                      backgroundColor: Theme.of(context).platform==TargetPlatform.iOS 
                   ? Colors.pink:Colors.white,
                      child: new Text("A"),
                   ),
                 ],
              ),
              //ListTite widget is used to create to items in list view.
              new ListTile(
                   title: new Text("Wallet"),//Text widget is used to define text.
                   leading:Icon(Icons.account_balance_wallet),
                   //onTap widget is used for providing triggering an event.
                   onTap: () {
                     Navigator.of(context).pop(); // this statement is used to close the drawer.
                     Navigator.of(context).pushNamed("/c"); // this statement is used navigate to specified route or page using named route='/a'.
                     },
              ),
              
               new ListTile(
                   title: new Text("Gallery Events"),
                   leading: Icon(Icons.event),
                   onTap: (){
                     Navigator.of(context).pop();
                     Navigator.of(context).pushNamed("/b");
                   },
              ),

                new ListTile(
                   title: new Text("Support"),
                   leading: Icon(Icons.help),
                   onTap: (){
                     Navigator.of(context).pop();
                     Navigator.of(context).pushNamed("/b");
                   },
              ),
              
               new ListTile(
                   title: new Text("Edit Profile"),
                   leading: Icon(Icons.edit),
                   onTap: (){
                     Navigator.of(context).pop();
                     //Navigator.of(context).pushNamed("/c");
                      Navigator.push
                                (
                                  context, 
                                  MaterialPageRoute(builder: (context)
                                  {
                                    return new EditProfilePage();

                                  })
                                );
                   },
              ),

               new ListTile(
                   title: new Text("Quiz"),
                   leading: Icon(Icons.question_answer),
                   onTap: (){
                     Navigator.of(context).pop();
                     Navigator.of(context).pushNamed("/c");
                   },
              ),
              
               new ListTile(
                   title: new Text("Search"),
                   leading: Icon(Icons.search),
                   onTap: (){
                     Navigator.of(context).pop();
                     Navigator.of(context).pushNamed("/c");
                   },
              ),


            // Divider widget is used for separating the items or widgets.
             // new Divider(),


               new ListTile(
                   title: new Text("SignOut"),
                   leading: Icon(Icons.lock),
                   onTap: () 
                   {
                     //Navigator.of(context).pop();
                     //exit(0);
                     logOutUser();
                   },
              ),
            
               new ListTile(
                   title: new Text("Close"),
                   leading: new Icon(Icons.close),//Icon widget is used to set Icons for particular items.
                   onTap: ()=> Navigator.of(context).pop(),
              ),
             
             
              SizedBox(
                height: 15.0,
              ),
              new Divider(), 
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>
                        [   
                            Container
                              (
                                alignment: Alignment.topLeft,
                                child: Text("Legal",style: TextStyle(color: Colors.black,fontSize: 13.0),),
                              ) ,

                               Container
                              (
                                alignment: Alignment.topLeft,
                                child: Text("v1.0.0",style: TextStyle(color: Colors.black,fontSize: 13.0),),
                              ) ,   
                        ],
                  
                  ),
              
              ],
          ),
        );
 
  }

  Widget myBottomNavigationBar()
  {
    return BottomNavigationBar( 
    currentIndex: _currentIndex,
    type: BottomNavigationBarType.fixed,
       backgroundColor: Colors.pink,
       iconSize: 26.0,
       selectedFontSize: 15,
        items: 
        [
            BottomNavigationBarItem
            (
              icon: Icon(Icons.home,color: Colors.white,),
              title:Text('Home',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
              backgroundColor: Colors.pink
            ),

            BottomNavigationBarItem
            (
              icon: Icon(Icons.gif,color: Colors.white,),
              title:Text('Mojo',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
              backgroundColor: Colors.pink
            ),

            BottomNavigationBarItem
            (
              icon: Icon(Icons.shopping_cart,color: Colors.white,),
              title:Text('Buy',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
              backgroundColor: Colors.pink
            ),
        ],
        
        onTap: onTapped,
      
    );
  }

  
  
}
