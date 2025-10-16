import 'package:delivery_flutter/src/pages/restaurant/orders/list/restaurant_orders_list_controller.dart';
import 'package:delivery_flutter/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RestaurantOrdersListPage extends StatefulWidget {
  const RestaurantOrdersListPage({super.key});

  @override
  State<RestaurantOrdersListPage> createState() => _RestaurantOrdersListPageState();
}

class _RestaurantOrdersListPageState extends State<RestaurantOrdersListPage> {

  final RestaurantOrdersListController _con = RestaurantOrdersListController();

  @override
  void initState() {

    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
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
                Text('${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}', // '${_con.user?.name ?? ''}'
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
                maxLines: 1,
              ),
              Text(_con.user?.email ?? '',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[200],
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
                ),
                maxLines: 1,
              ),
              Text(_con.user?.phone ?? '',
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
                  image: (_con.user?.image != null && _con.user!.image!.isNotEmpty)
                    ? NetworkImage(_con.user!.image!)
                    : AssetImage('assets/img/no-image.png') as ImageProvider,
                  fit: BoxFit.contain,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: AssetImage('assets/img/no-image.png'),
                ),
              )
              ],
            ),
          ),
          ListTile(
            onTap: () => _con.goToCategoryCreate(),
            title: Text('Crear categoria'),
            trailing: Icon(Icons.list_alt),
          ),

          _con.user != null ?
          _con.user!.roles.length > 1 ?
          ListTile(
            onTap: () => _con.goToRoles(),
            title: Text('Seleccionar rol'),
            trailing: Icon(Icons.person_outline),
          ) : Container() : Container(),
          ListTile(
            onTap: () => _con.logout(context),
            title: Text('Cerrar sesion'),
            trailing: Icon(Icons.power_settings_new),
          ),
          ],
        ),
      );
    }

    void refresh(){
    setState(() {},);
  }

}