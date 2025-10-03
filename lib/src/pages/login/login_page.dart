import 'package:delivery_flutter/src/pages/login/login_controller.dart';
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
              top: 20,
              left: 10,
              child: Container(
                width: 150,
                height: 150,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(130),
                //   color: Colors.black26
                // ),
                child: Image.asset('assets/img/wie_1024_sin_fondo.png'),
              ),
            ),  
            Positioned(
              top: 160,
              left: 160,
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
  
  // Widget _imageLogo(){
  //   return CircleAvatar(
  //     backgroundImage: AssetImage('assets/img/assets/img/wie_1024.png'),
  //     radius: 80,
  //     backgroundColor: Colors.black,
  //   );
  // }

  Widget _imageLogo(){
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(130),
        color: Colors.black12
        
      ),
      child: Image.asset('assets/img/wie_1024.png'),
    );
  }

  Widget _circleLogin(){
    return Container(
      width: 280,
      height: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(130),
        color: MyColors.primaryColor
      ),
    );
  }

  Widget _textLogin(){
    return Text('LOGIN',
      style: TextStyle(
        color: const Color.fromARGB(255, 200, 15, 15),
        fontWeight: FontWeight.bold,
        fontSize: 34,
        fontFamily: 'NimbusSans'
      ),
    );
  }

  Widget _lottieAnimation(){
    return Container(
      margin: EdgeInsets.only(
        top: 220, 
        bottom: MediaQuery.of(context).size.height * 0.1
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
              fontSize: 17,
              color: MyColors.primaryColor
            ),
        ),
        SizedBox(width: 7,),
        GestureDetector(
          onTap: _con.goToRegisterPage,
          child: Text('Registrate',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
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