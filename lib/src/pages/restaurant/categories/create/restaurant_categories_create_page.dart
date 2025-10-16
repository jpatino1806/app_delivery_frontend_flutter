 import 'package:delivery_flutter/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';
import 'package:delivery_flutter/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RestaurantCategoriesCreatePage extends StatefulWidget {
  const RestaurantCategoriesCreatePage({super.key});

  @override
  State<RestaurantCategoriesCreatePage> createState() => _RestaurantCategoriesCreatePageState();
}

class _RestaurantCategoriesCreatePageState extends State<RestaurantCategoriesCreatePage> {
  
  final RestaurantCategoriesCreateController _con = RestaurantCategoriesCreateController();

  @override
  void initState() {
 
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp){
      _con.init(context, refresh);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva categoria'),
        backgroundColor: MyColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(height: 30,),
          _textFieldNane(),
          _textFieldDescription()
        ],
      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }


  Widget _textFieldNane(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
          hintText: 'Nombre de la categoria',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark
          ),
          suffixIcon: Icon(
            Icons.list_alt,
            color: MyColors.primaryColor,
          )
      
        ),
      ),
    );
  }


  Widget _textFieldDescription(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.descriptionController,
        maxLength: 255,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: 'Descripcion de la categoria',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark
          ),
          suffixIcon: Icon(
            Icons.description,
            color: MyColors.primaryColor,
          )
      
        ),
      ),
    );
  }

  Widget _buttonCreate(){
    return Container(
      height: 70,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: ElevatedButton(
        onPressed: _con.createCategory,
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primaryColor,
            padding: EdgeInsets.symmetric(vertical: 20)
          ), 
        child: Text('Crear categoria',style: TextStyle(color: Colors.white, fontSize: 16 ),),
          
        ),
    );
  }

  void refresh(){
    setState(() {
      
    });
  }

}