import 'package:delivery_flutter/src/models/product.dart';
import 'package:delivery_flutter/src/pages/client/order/create/client_order_create_controller.dart';
import 'package:delivery_flutter/src/utils/my_colors.dart';
import 'package:delivery_flutter/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientOrderCreatePage extends StatefulWidget {
  const ClientOrderCreatePage({super.key});

  @override
  State<ClientOrderCreatePage> createState() => _ClientOrderCreatePageState();
}

class _ClientOrderCreatePageState extends State<ClientOrderCreatePage> {

  final ClientOrderCreateController _con = ClientOrderCreateController();

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
        title: Text('Mi orden'),
        backgroundColor: MyColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * .23,
        child: Column(
          children: [
            Divider(
              color: Colors.grey[400],
              endIndent: 30, // margen derecho
              indent: 30, // margen izquierdo
            ),
            _textTotalPrice(),
            _buttonNext()
          ],
        ),

      ),
      body: _con.selectedProducts.isNotEmpty//length > 0
        ? ListView(
          children: _con.selectedProducts.map((Product product){
            return _cardProduct(product);
          }).toList(),
        )
        : NoDataWidget(text: 'Ningun producto agregado',),
      //  
    );
  }



  Widget _cardProduct(Product product) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _imageProduct(product),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _addOrRemoveItem(product),
            ],
          ),
          Spacer(),
          Column(
            children: [
              _textPrice(product),
              _iconDelete(product),
            ],
          )
        ],
      ),
    );
  }


  Widget _buttonNext() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 40),
      child: ElevatedButton(
        onPressed: () {}, 
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 5)
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                height: 50,
                child: Text('CONTINUAR',
                  style: TextStyle(color: Colors.white,
                    fontSize: 16, fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 90, top: 10),
                height: 30,
                child: Icon(Icons.check_circle, color: Colors.green,
                  size: 30,
                )
                ),
              ),
            
          ],
        ),
      ),
    );
  }



  Widget _textTotalPrice(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22
            ),
          ),
          Spacer(),
          Text('S/. ${_con.total}',
            style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconDelete(Product product) {
    return IconButton(
      onPressed: () => _con.deleteItem(product), 
      icon: Icon(Icons.delete, color: MyColors.primaryColor)
    );
  }


  Widget _textPrice(Product product){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text('S/.  ${product.price! * product.quantity!}',
        style: TextStyle(color: Colors.grey,
        fontWeight: FontWeight.bold),
      ),
    );
  }


  Widget _imageProduct(Product product){
    return Container(
      width: 90,
      height: 90,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.grey[200]
      ),
      child: FadeInImage(
        image: product.image1 != null
          ? NetworkImage(product.image1!)
          : AssetImage('assets/img/no-image.png'),
          fit: BoxFit.contain,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder: AssetImage('assets/img/no-image.png'), 
        ),
    );
  }


  Widget _addOrRemoveItem(Product product){
    return Row(
      children: [
        GestureDetector(
          onTap: () => _con.removeItem(product),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8)
              ),
              color: Colors.grey[200]
            ),
            child: Text('-'),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          color: Colors.grey[200],
          child: Text('${product.quantity ?? 0}'),
        ),
        GestureDetector(
          onTap: () => _con.addItem(product),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8)
              ),
              color: Colors.grey[200]
            ),
            child: Text('+'),
          ),
        ),
      ],
    );
  }

  void refresh(){
    setState(() {});
  }
}