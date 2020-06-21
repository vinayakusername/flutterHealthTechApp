import 'package:flutter/material.dart';
import 'package:health_tech_app1/Views/home.dart';
import 'package:health_tech_app1/Views/signup.dart';
import 'package:health_tech_app1/helper/functions.dart';
import 'package:health_tech_app1/services/auth.dart';
import 'package:health_tech_app1/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  String email,password;
  AuthService authService = new AuthService();

  bool _isLoading = false;

  signIn() async
  {
    if(_formKey.currentState.validate())
    {
       setState(() {
         _isLoading = true;
       });
     authService.signInEmailAndPass(email, password).then((val)
       {
            if(val != null)
            {
                setState(() {
                              _isLoading = false;
                         });
                
                HelperFunctions.saveUserLoggedInDetails(isLoggedIn: true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Home()));
            }
       });

      
    }
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
     appBar: AppBar
     (
       title: appBar(context),
       backgroundColor: Colors.transparent,
       elevation: 0.0,
       brightness: Brightness.light,
       centerTitle: true,
     ),

     body: _isLoading ? Container(

       child: Center
       (
         child: CircularProgressIndicator(),
       ),
     ) : SingleChildScrollView(
          child: Container
          (
            margin: EdgeInsets.all(15.0),
            child: Form
            (
              key: _formKey,
              child: Column
              (
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: createInputs()+createButtons(),
              )
            ),
          ),
     ),
     /* 
     Form(
       key: _formKey,
     child:Container
     (
       margin: EdgeInsets.symmetric(horizontal: 24.0),
       child: Column
       (
         children: <Widget>
         [
           Spacer(),
           TextFormField
           (
             validator: (val){return val.isEmpty ? "Enter Email Id": null;},
             decoration: InputDecoration(hintText: "Email"),
             onChanged: (val)
             {
               email = val;
             },
           ),
           SizedBox(height: 6.0,),
            TextFormField
           (
             obscureText: true,
             validator: (val){return val.isEmpty ? "Enter Password": null;},
             decoration: InputDecoration(hintText: "Password"),
             onChanged: (val)
             {
               password = val;
             },
           ),
           SizedBox(height:24.0),
           GestureDetector
           (
             onTap: ()
             {
                signIn();
             },
            child: Container
                      (
                             padding: EdgeInsets.symmetric(vertical: 16.0),
                             decoration: BoxDecoration
                            (
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(30)
                            ),
                            width: MediaQuery.of(context).size.width-48,
                            child: Text("Sign In",style: TextStyle(color:Colors.white,fontSize:16),),
                            alignment: Alignment.center,
                       ),
            ),
           
            SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style:
                              TextStyle(color: Colors.black87, fontSize: 17)),
                      GestureDetector(
                                onTap: ()
                                {
                                  Navigator.pushReplacement(context,MaterialPageRoute(
                                    builder: (context) => SignUp()
                                    ));
                                },
                                child: Text("Sign Up",style:
                                TextStyle(color: Colors.black87, fontSize: 17,
                                decoration: TextDecoration.underline)),
                      ),
                    ],
                  ),
           SizedBox(height:80.0)
         ],
       ),
     ),
     ), */
      
    );
  }

  List<Widget> createInputs()
  {
      return 
      [
      
           TextFormField
           (
             validator: (val){return val.isEmpty ? "Enter Email Id": null;},
             decoration: InputDecoration(hintText: "Email"),
             onChanged: (val)
             {
               email = val;
             },
           ),
           SizedBox(height: 6.0,),
            TextFormField
           (
             obscureText: true,
             validator: (val){return val.isEmpty ? "Enter Password": null;},
             decoration: InputDecoration(hintText: "Password"),
             onChanged: (val)
             {
               password = val;
             },
           ),
           SizedBox(height:20.0), 
      ];
  }

  List<Widget> createButtons()
  {
     return
     [
        GestureDetector
           (
             onTap: ()
             {
                signIn();
             },
            child: customButtonWidget(context: context, buttonName: "Sign In",)
            ),
           
            SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style:
                              TextStyle(color: Colors.black87, fontSize: 17)),
                      GestureDetector(
                                onTap: ()
                                {
                                  Navigator.pushReplacement(context,MaterialPageRoute(
                                    builder: (context) => SignUp()
                                    ));
                                },
                                child: Text("Sign Up",style:
                                TextStyle(color: Colors.black87, fontSize: 17,
                                decoration: TextDecoration.underline)),
                      ),
                    ],
                  ),
     ];
  }
}