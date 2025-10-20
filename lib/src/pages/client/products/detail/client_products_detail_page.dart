import 'package:delivery_flutter/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientProductsDetailPage extends StatefulWidget {
  const ClientProductsDetailPage({super.key});

  @override
  State<ClientProductsDetailPage> createState() => _ClientProductsDetailPageState();
}

class _ClientProductsDetailPageState extends State<ClientProductsDetailPage> {

  final ClientProductsDetailController _con = ClientProductsDetailController();

  @override
  void initState() {
   
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp){
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Text('MODAL SHEET'),
    );
  }



  void refresh(){
    setState(() {
      
    });
  }
}