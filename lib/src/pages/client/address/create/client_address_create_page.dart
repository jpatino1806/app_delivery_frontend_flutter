import 'package:delivery_flutter/src/pages/client/address/create/client_address_create_controller.dart';
import 'package:delivery_flutter/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientAddressCreatePage extends StatefulWidget {
  const ClientAddressCreatePage({super.key});

  @override
  State<ClientAddressCreatePage> createState() => _ClientAddressCreatePageState();
}

class _ClientAddressCreatePageState extends State<ClientAddressCreatePage> {

 final  ClientAddressCreateController _con = ClientAddressCreateController();


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
        title: Text('Nueva direccion'),
        backgroundColor: MyColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: _buttonAccept(),
      body: Column(
        children: [
          _textCompleteData(),
          _textFieldAddress(),
          _textFieldNeighborhood(),
          _textFieldRefPoint(),
        ],
      ),
    );
  }


   Widget _textFieldRefPoint(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: _con.refPointController,
        onTap: _con.openMap,
        autofocus: false,
        focusNode: AlwaysDisabledFocusNode(),
        decoration: InputDecoration(
          labelText: 'Punto de referencia',
          suffixIcon: Icon(
            Icons.map,
            color: MyColors.primaryColor,
          )
        ),
      ),
    );
  }


  Widget _textFieldNeighborhood(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: _con.neighborhoodController,
        decoration: InputDecoration(
          labelText: 'Distrito',
          suffixIcon: Icon(
            Icons.location_city,
            color: MyColors.primaryColor,
          )
        ),
      ),
    );
  }


  Widget _textFieldAddress(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: _con.addressController,
        decoration: InputDecoration(
          labelText: 'Direccion',
          suffixIcon: Icon(
            Icons.location_on,
            color: MyColors.primaryColor,
          )
        ),
      ),
    );
  }


  Widget _textCompleteData(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text('Completa estos datos',
      style: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold
      ),
      ),
    );
  }



  Widget _buttonAccept(){
    return Container(
      //padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          foregroundColor: Colors.white,
          
        ),
        onPressed: _con.createAddress, 
        child: Text('CREAR DIRECCION',style: TextStyle(fontSize: 18), 
        )),
    );
  }



  void refresh() {
    setState(() {});
  }
}



class AlwaysDisabledFocusNode extends FocusNode {

  @override
  bool get hasFocus => false;
}