import 'dart:io';

import 'package:delivery_flutter/src/pages/restaurant/products/create/restaurant_products_create_controller.dart';
import 'package:delivery_flutter/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:delivery_flutter/src/models/category.dart';

class RestaurantProductsCreatePage extends StatefulWidget {
  const RestaurantProductsCreatePage({super.key});

  @override
  State<RestaurantProductsCreatePage> createState() => _RestaurantProductsCreatePageState();
}

class _RestaurantProductsCreatePageState extends State<RestaurantProductsCreatePage> {
  
  final RestaurantProductsCreateController _con = RestaurantProductsCreateController();

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
        title: Text('Nuevo producto'),
        backgroundColor: MyColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SizedBox(height: 30,),
          _textFieldNane(),
          _textFieldDescription(),
          _textFieldPrice(),
          SizedBox(height: 20),
          Container(
            height: 120,
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _cardImage(_con.imageFile1, 1),
                _cardImage(_con.imageFile2, 2),
                _cardImage(_con.imageFile3, 3),
              ],
            ),
          ),
          SizedBox(height: 20,),
          _dropDownCategories(_con.categories.cast<Category>()),
         
        ],
      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }


  Widget _textFieldNane(){
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,
        maxLines: 1,
        maxLength: 180,
        decoration: InputDecoration(
          hintText: 'Nombre del producto',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark
          ),
          suffixIcon: Icon(
            Icons.local_pizza,
            color: MyColors.primaryColor,
          )
      
        ),
      ),
    );
  }

  Widget _textFieldPrice(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.priceController,
        keyboardType: TextInputType.numberWithOptions(),
        maxLines: 1,
        decoration: InputDecoration(
          hintText: 'Precio',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark
          ),
          suffixIcon: Icon(
            Icons.monetization_on,
            color: MyColors.primaryColor,
          )
      
        ),
      ),
    );
  }


  Widget _textFieldDescription(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
          hintText: 'Descripcion del producto',
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


  Widget _dropDownCategories(List<Category> categories){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 33),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                      Icons.search,
                      color: MyColors.primaryColor,
                  ),
                  SizedBox(width: 15,),
                  Text('Categorias',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  underline: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_drop_down_circle,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  elevation: 3,
                  isExpanded: true,
                  hint: Text('Seleccionar categoria',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                    ),
                  ),
                  items: _dropDownItems(categories), 
                  value: _con.idCategory,
                  onChanged: (option) {
                    setState(() {
                      print('Categoria seleccionada $option');
                      _con.idCategory = option;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  List<DropdownMenuItem<String>> _dropDownItems(List<Category> categories) {
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category){
      list.add(DropdownMenuItem<String>(
        value: category.id ?? '',
        child: Text(category.name ?? ''),
      ));
    });
    return list;
  }



  Widget _cardImage(File? imageFile, int numberFile) {
    return GestureDetector(
      onTap: () {
        _con.showAlertDialog(numberFile);
      },
      child: Card(
        elevation: 3.0,
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width * 0.26,
            child: imageFile != null
            ? Image.file(imageFile, fit: BoxFit.cover) 
            : Image.asset('assets/img/add_image.png')
            
            
        ),
      ),
    );
  }


  Widget _buttonCreate(){
    return Container(
      height: 70,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: ElevatedButton(
        onPressed: _con.createProduct,
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primaryColor,
            padding: EdgeInsets.symmetric(vertical: 20)
          ), 
        child: Text('Crear producto',style: TextStyle(color: Colors.white, fontSize: 18 ),),
          
        ),
    );
  }

  void refresh(){
    setState(() {});
  }

}

// extension on Category {
//   String? get id => null;
  
//   String? get name => null;
// }