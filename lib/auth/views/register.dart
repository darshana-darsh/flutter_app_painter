import 'package:email_validator/email_validator.dart';
import 'package:flutter_app/auth/auth.service.dart';
import 'package:flutter_app/auth/views/login.dart';
import 'package:flutter_app/painter/views/homeView/home.dart';
import 'package:flutter_app/preferences/UserPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/Config_file.dart';
import 'package:shared_preferences/shared_preferences.dart';



class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  SharedPreferences prefs;
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController fullnameController = new TextEditingController();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _fullNameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  bool passShow=true;
  bool _autoValidate = false;
  String _name;
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
          child: Container(
          //  height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(

              image: DecorationImage(
                image: AssetImage("assets/images/login-bg.png",),
                fit: BoxFit.contain,
                repeat: ImageRepeat.noRepeat,
                alignment: Alignment.topRight,

              ),
            ),
            child: Stack(
              children: [
                Form(
                  key:_key,
                  autovalidate: _autoValidate,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 150,horizontal: 35),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      image: DecorationImage(
                        image: AssetImage("assets/images/login-transparent.png",),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top:15.0),
                            child: Text(
                              'Painter',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                                color: Config_File.PRIMARY_COLOR,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'App',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              color: Config_File.PRIMARY_COLOR,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:18.0,left:20),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 22,
                              color: Config_File.PRIMARY_COLOR,
                              fontWeight: FontWeight.w700,
                              height: 1.3636363636363635,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        /* Padding(
                          padding: const EdgeInsets.only(left:20.0,top: 20),
                          child: Text("Login",style: TextStyle(color: Config_File.PRIMARY_COLOR,fontSize: 20,fontWeight: FontWeight.w500),),
                        ),*/
                        Padding(
                          padding: const EdgeInsets.only(left:20.0,right: 30,top: 10,bottom: 10),
                          child: TextFormField(
                            controller: fullnameController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (String arg) {
                              if(arg.length < 3)
                                return 'Name must be more than 2 charater';
                              else
                                return null;
                            },
                            onSaved: (String val) {
                              _name = val;
                            },
                            onFieldSubmitted: (_){
                              fieldFocusChange(context, _fullNameFocusNode, _emailFocusNode);
                            },
                            decoration: InputDecoration(hintText: "Full Name"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0,right: 30,top: 10,bottom: 10),
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (email)=>EmailValidator.validate(email)? null:"Invalid email address",
                            onSaved: (email)=> _email = email,
                            focusNode: _emailFocusNode,
                            onFieldSubmitted: (_){
                              fieldFocusChange(context, _emailFocusNode, _passwordFocusNode);
                            },
                            decoration: InputDecoration(hintText: "Email Address"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0,right: 30,top: 10,bottom: 10),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: passShow,
                            textInputAction: TextInputAction.done,
                            validator: (password){
                              Pattern pattern =
                                  r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                              RegExp regex = new RegExp(pattern);
                              if (!regex.hasMatch(password))
                                return 'Invalid password';
                              else
                                return null;
                            },
                            onSaved: (password)=> _password = password,
                            focusNode: _passwordFocusNode,
                            decoration: InputDecoration(hintText: "Password",
                                suffixIcon: IconButton(icon:Icon( passShow ? Icons.remove_red_eye_outlined: Icons.remove_red_eye_rounded)
                                    , onPressed: (){
                                      setState(() {
                                        if(passShow){
                                          passShow=false;
                                        }
                                        else{
                                          passShow=true;
                                        }
                                      });
                                    })
                            ),
                          ),
                        ),
                      /*  Transform.translate(
                          offset: Offset(10.0, 85.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: (){

                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right:20.0,top: 20),
                                  child: Text("Forget Password?",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400),),
                                ),
                              ),
                            ],
                          ),
                        ),*/
                        Padding(
                          padding: EdgeInsets.only(left: 20,right: 20,top: 30),
                          child: InkWell(
                            onTap: (){
                            //AuthService().signUp(emailController.text,passwordController.text,fullnameController.text);
                            setState(() {
                            //  UserPreference.setLoginStatus(true);
                            });
                          //  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                            signupValidation();
                            },
                            child: Container(
                              height: 55,

                              decoration: BoxDecoration(
                                  color: Config_File.PRIMARY_COLOR,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                              ),
                              child: Center(child: Text("Register".toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500))),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top:13.0,bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 0.6,
                                  width: 50,
                                  color: Colors.grey,
                                ),
                              ),
                              Center(
                                child: Text(
                                  'or',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    color: Config_File.GREY,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3636363636363635,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 0.6,
                                  width: 50,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                             //   AuthService().signInFacebook();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/images/fb.png"),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                AuthService().signInWithGoogle();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/images/gplus.png"),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 5,)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:80.0),
                        child: Text(
                          "You have an accouont?",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Config_File.GREY,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => LoginPage(
                          )));
                        //  Get.offNamed("/login");
                        },
                        child: Text(
                          'Click here',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            color: Config_File.BLUE,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )



    );
  }
  void fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Future<String> signupValidation()async{

    if (_key.currentState.validate()) {
      _key.currentState.save();

      try {

      var userId=  AuthService().signUp(emailController.text,passwordController.text,fullnameController.text);

        print("Success in signing, you can now navigate");
            setState(() {
              UserPreference().setUserId(userId.toString());
              UserPreference.setLoginStatus(true);
            });
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
            Config_File.toastMsg("Success in signing, you can now navigate");


      } catch (e) {
        print(e.message);
      }
    }
    else{
      setState(() {
        _autoValidate = true;
      });

    }

  }
}



