import 'package:delivery_flutter/src/login/login_controller.dart';
import 'package:delivery_flutter/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginController _con = LoginController();

  @override
  void initState() {
    
    super.initState();
    
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -100,
              child: _circleLogin()),
            Positioned(
              top: 60,
              left: 25,
              child: _textLogin()),
            SingleChildScrollView(
              child: Column(
                children: [
                  //_imageBanner(),
                  _lottieAnimation(),
                  _textFieldEmail(),
                  _textFieldPassword(),
                  SizedBox(height: 30,),
                  _buttonLogin(),
                  SizedBox(height: 15,),
                  _textDontHaveAccount(),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }


  /////////////////////////////////////////////////////////
  
  Widget _circleLogin(){
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: MyColors.primaryColor
      ),
    );
  }

  Widget _textLogin(){
    return Text('LOGIN',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24,
        fontFamily: 'NimbusSans'
      ),
    );
  }

  Widget _lottieAnimation(){
    return Container(
      margin: EdgeInsets.only(
        top: 150, 
        bottom: MediaQuery.of(context).size.height * 0.17
      ),
      child: Lottie.asset('assets/json/Delivery.json',
        width: 350,
        height: 200,
        fit: BoxFit.fill
      ),
    );
  }

  Widget _textDontHaveAccount(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('No tienes cuenta?',
          style: TextStyle(
              color: MyColors.primaryColor
            ),
        ),
        SizedBox(width: 7,),
        GestureDetector(
          onTap: _con.goToRegisterPage,
          child: Text('Registrate',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.primaryColor
            ),
          ),
        ),
        
      ],
    );
  }

  Widget _buttonLogin(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: ElevatedButton(
        onPressed: _con.login,
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primaryColor,
            padding: EdgeInsets.symmetric(vertical: 20)
          ), 
        child: Text('INGRESAR',style: TextStyle(color: Colors.white),),
          
        ),
    );
  }

  Widget _textFieldPassword(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Contraseña',
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.lock,
            color: MyColors.primaryColor,
            
          )
      
        ),
      ),
    );
  }

  Widget _textFieldEmail(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Correo electronico',
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.email,
            color: MyColors.primaryColor,
          )
      
        ),
      ),
    );
  }

  // Widget _imageBanner(){
  //   return Container(
  //     margin: EdgeInsets.only(
  //       top: 85, 
  //       bottom: MediaQuery.of(context).size.height * 0.10
  //     ),
  //     child: Image.asset(
  //       'assets/img/delivery.png',
  //       width: 200,
  //       height: 200,
  //       ),
  //   );
  // }
}