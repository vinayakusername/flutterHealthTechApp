import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_tech_app1/Views/widget_BuyProductPage.dart';
import 'package:health_tech_app1/Views/widget_DashBoardPage.dart';
import 'package:health_tech_app1/Views/widget_MojoPage.dart';




final GoogleSignIn gSignIn = GoogleSignIn();

class HomePage extends StatefulWidget {

   logOutMethod() => createState().logOutUser();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   bool isSignedIn = false;
   PageController pageController;
   int getPageIndex = 0;

   void initState()
   {
       super.initState();

       pageController = PageController();

       gSignIn.onCurrentUserChanged.listen((gSigninAccount)
       {
              controlSignIn(gSigninAccount);
       },onError: (gError)
       {
            print("Error Message :"+gError);
       });

       // To maintain the auth state of user after loginIn into the application
       gSignIn.signInSilently(suppressErrors: false).then((gSignInAccount)
       {
         controlSignIn(gSignInAccount);
       }).catchError((gError)
       {
           print("Error Message: "+gError);
       });
   }

   controlSignIn(GoogleSignInAccount signInAccount) async {

       if(signInAccount != null)
       {
          setState(() 
          {
             isSignedIn = true;
          });
       }
       else
       {
         setState(() 
         {
            isSignedIn = false;
         });
       }      
    
   }
 
   void dispose()
   {
     pageController.dispose();
     super.dispose();
   }


//this login function using google account
   loginUser()
   {
       gSignIn.signIn();
   }

 // this logout function
   logOutUser()
   {
       gSignIn.signOut();
   }

  @override
  Widget build(BuildContext context) {
    
       if(isSignedIn)
       {
         return buildHomeScreen();
       }
       else
       {
         return buildLoginScreen();
       }
  }

   whenPageChanges(int pageIndex)
   {
     setState(() {
       this.getPageIndex = pageIndex;
     });
      
   }


  onTapChangePage(int pageIndex)
    {
      pageController.animateToPage(pageIndex, duration: Duration(milliseconds: 400), curve: Curves.bounceInOut);
    }


  Scaffold buildHomeScreen()
  {
     //return RaisedButton.icon(onPressed: logOutUser, icon: Icon(Icons.close), label: Text("SignOut"));
     return Scaffold
     (
       body: PageView
       (
         children: <Widget>
         [
           DashBoardPage(),
           //RaisedButton.icon(onPressed: logOutUser, icon: Icon(Icons.close), label: Text("SignOut")),
           MojoPage(),
           BuyProductPage()
           
         ],
         controller: pageController,
         onPageChanged: whenPageChanges,
         physics: NeverScrollableScrollPhysics(),
       ),

       bottomNavigationBar: CupertinoTabBar
                           (
                             currentIndex: getPageIndex,
                             onTap: onTapChangePage,
                             backgroundColor: Theme.of(context).primaryColor,
                             activeColor: Colors.white,
                             inactiveColor: Colors.blueGrey,
                             items: 
                             [
                               BottomNavigationBarItem(icon: Icon(Icons.home)),
                               BottomNavigationBarItem(icon: Icon(Icons.gif,size:37.0)),
                               BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,)),
                             
                             ] ,
                           ),
     );
  }

  Scaffold buildLoginScreen()
  {
    return Scaffold(
      body: Container
      (
        decoration: BoxDecoration
        (
          gradient: LinearGradient
          (
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Theme.of(context).accentColor,Theme.of(context).primaryColor],
          )
        ),
        alignment: Alignment.center,
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>
          [
              Text("HealthTech App",
              style: TextStyle(color:Colors.white,fontSize: 45.0),
              ),

   Padding(
     padding:EdgeInsets.all(5.0),
     child:FlatButton
           (
               
               shape: RoundedRectangleBorder
                       (
                             borderRadius: BorderRadius.circular(18.0),
                             side: BorderSide(color: Colors.white,)
                       ),
                 child:Row
               (
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>
                 [
                     Image.asset("images/googleIcon.png",width: 50.0,height: 50.0,),
                     Text("Sign in With Google",style: TextStyle(color:Colors.white,fontSize:22.0),),
                     Opacity(
                         opacity: 0.0,
                         child: Image.asset("images/googleIcon.png",width: 50.0,height: 50.0,),
                     )
                 ],
              ),  
              
               textColor: Colors.white,
               onPressed: loginUser,
            ),
          )
                  
          ],
        ),
      ),
    );
  }
}