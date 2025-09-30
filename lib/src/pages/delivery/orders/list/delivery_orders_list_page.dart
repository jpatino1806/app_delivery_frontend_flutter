import 'package:delivery_flutter/src/pages/delivery/orders/list/delivery_orders_list_controller.dart';
import 'package:delivery_flutter/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class DeliveryOrdersListPage extends StatefulWidget {
  const DeliveryOrdersListPage({super.key});

  @override
  State<DeliveryOrdersListPage> createState() => _DeliveryOrdersListPageState();
}

class _DeliveryOrdersListPageState extends State<DeliveryOrdersListPage> {

final DeliveryOrdersListController _con = DeliveryOrdersListController();

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
      key: _con.key,
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        leading: _menuDrawer(),
      ),
      drawer: _drawer(),
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () => _con.logout(context), 
      //     child: Text('Cerrar Sesion'),
      //   ),
      // )
    );
  }


  Widget _menuDrawer(){
      return GestureDetector(
        onTap: _con.openDrawer,
          child: Container(
            margin: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Image.asset('assets/img/menu.png', width: 20, height: 20, color: Colors.white,),
        ),
      ); 
    }

    Widget _drawer(){
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: MyColors.primaryColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre del cliente',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                  maxLines: 1,
                ),
                Text('Email',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                  ),
                  maxLines: 1,
                ),
                Text('telefono',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                  ),
                  maxLines: 1,
                ),
                Container(
                  height: 55,
                  margin: EdgeInsets.only(top: 10),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.png'), 
                    image: AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
            
                    ),
                )
                ],
              ),
            ),
           
            ListTile(
              title: Text('Seleccionar rol'),
              trailing: Icon(Icons.person_outline),
            ),
            ListTile(
              onTap: () => _con.logout(context),
              title: Text('Cerrar sesion'),
              trailing: Icon(Icons.power_settings_new),
            )
          ],
        ),
      );
    }
}