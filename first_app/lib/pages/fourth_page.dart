import 'package:flutter/material.dart';

class FourthPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O'];
    final List<int> colorCodes = <int>[600,500,100];
    return Scaffold(
      appBar: AppBar(
        title: Text('List View Example'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(8.0),
        itemCount: entries.length,
        itemBuilder: (context, index){
          return ProductTile(
            items: ProductItem(
              name: 'Product ${entries[index]}',
              price: '฿25',
              colorShade : colorCodes[index % 3],
            )
          );
        },
        separatorBuilder: (context,index) =>Divider(),
      ),
    );
  }
}
class ProductItem  {
  final String name;
  final String price;
  final int colorShade;

  const ProductItem({Key? key,required this.name, 
  required this.price, required this.colorShade});
  
}

class ProductTile extends StatelessWidget {
  final ProductItem items;
  
  const ProductTile({Key? key,required this.items} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, 
          MaterialPageRoute(
            builder: (context)=> ProductDetail(items: items))
        );
      },
      child: Container(
        height: 100,
        color: Colors.amber[items.colorShade],
        child: Center(
          child:Text('${items.name}'),
        ),
      ),
      
    );
  }
}

class ProductDetail extends StatelessWidget {
   final ProductItem items;
   const ProductDetail({Key? key,required this.items} ) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Product Name : ${items.name}'),
          Text('Price Name : ${items.price}'),
        ],
      ),
    );
  }
}