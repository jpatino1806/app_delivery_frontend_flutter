import 'package:delivery_flutter/src/pages/register/register_controller.dart';
import 'package:delivery_flutter/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  RegisterController _con = RegisterController();

  @override
  void initState() {
    
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback( (timeStamp){

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
              child: _circleRegister()),
            Positioned(
              top: 55,
              left: 28,
              child: _textRegister()),
            Positioned(
              top: 43,
              left: -1,
              child: _iconBack()),

            Container(
              margin: EdgeInsets.only(top: 150),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _imageUser(),
                    SizedBox(height: 30,),
                    _textFieldEmail(),
                    _textFieldName(),
                    _textFieldlastName(),
                    _textFieldPhone(),
                    _textFieldPassword(),
                    _textFieldConfirmPassword(),
                    SizedBox(height: 20,),
                    _buttonRegister(),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _imageUser(){
    return CircleAvatar(
      backgroundImage: AssetImage('assets/img/user_profile_2.png'),
      radius: 60,
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _circleRegister(){
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: MyColors.primaryColor
      ),
    );
  }

  Widget _buttonRegister(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: ElevatedButton(
        onPressed: _con.register,
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primaryColor,
            padding: EdgeInsets.symmetric(vertical: 20)
          ), 
        child: Text('REGISTRARSE',style: TextStyle(color: Colors.white),),
          
        ),
    );
  }

   Widget _textRegister(){
    return Text('REGISTRO',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: 'NimbusSans'
      ),
    );
  }

  Widget _iconBack(){
    return IconButton(
      onPressed: _con.back, 
      icon: Icon(Icons.arrow_back_ios, color: Colors.white,));
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
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark
          ),
          prefixIcon: Icon(
            Icons.email,
            color: MyColors.primaryColor,
          )
      
        ),
      ),
    );
  }

  Widget _textFieldName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
          hintText: 'Nombres',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark
          ),
          prefixIcon: Icon(
            Icons.person,
            color: MyColors.primaryColor,
          )
      
        ),
      ),
    );
  }

  Widget _textFieldlastName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.lastnameController,
        decoration: InputDecoration(
          hintText: 'Apellidos',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark
          ),
          prefixIcon: Icon(
            Icons.person_2_outlined,
            color: MyColors.primaryColor,
          )
      
        ),
      ),
    );
  }

  Widget _textFieldPhone(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: 'Telefono',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark
          ),
          prefixIcon: Icon(
            Icons.phone,
            color: MyColors.primaryColor,
          )
      
        ),
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
          hintText: 'Password',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: MyColors.primaryColor,
          )
      
        ),
      ),
    );
  }

  Widget _textFieldConfirmPassword(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Confirmar Password',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark
          ),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: MyColors.primaryColor,
          )
      
        ),
      ),
    );
  }

}