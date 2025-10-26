import 'package:delivery_flutter/src/pages/client/address/list/client_address_list_controller.dart';
import 'package:delivery_flutter/src/utils/my_colors.dart';
import 'package:delivery_flutter/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientAddressListPage extends StatefulWidget {
  const ClientAddressListPage({super.key});

  @override
  State<ClientAddressListPage> createState() => _ClientAddressListPageState();
}

class _ClientAddressListPageState extends State<ClientAddressListPage> {

 final  ClientAddressListController _con = ClientAddressListController();


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
        title: Text('Direcciones'),
        backgroundColor: MyColors.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          _iconAdd(),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            _textSelectedAddress(),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: NoDataWidget(text: 'Agrega una direccion ')),
            _buttonNewAddress(),
          ],
        ),
      ),
      bottomNavigationBar: _buttonAccept(),
    );
  }


  Widget _buttonNewAddress(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.zero),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          
        ),
        onPressed: _con.goToNewAddress, 
        child: Text('Nueva direccion',style: TextStyle(fontSize: 18), 
        )),
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
        onPressed: () {}, 
        child: Text('ACEPTAR',style: TextStyle(fontSize: 18), 
        )),
    );
  }


  Widget _textSelectedAddress(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text('Elige donde recibir tus compras',
      style: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold
      ),
      ),
    );
  }


  Widget _iconAdd(){
    return IconButton(
      onPressed: _con.goToNewAddress, 
      icon: Icon(Icons.add, color: Colors.white,));
  }


  void refresh() {
    setState(() {});
  }
}