import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        centerTitle: false,
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
        ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperTargetas()
          ],
        ),
      )
    );
  }

  Widget _swiperTargetas() {

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: double.infinity, // hacemos uso de todo el ancho posible
      height: 300.0,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: 200.0,
          itemBuilder: (BuildContext context,int index){
            return new Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
          },
          itemCount: 3,
          //pagination: new SwiperPagination(),
          //control: new SwiperControl(),
      ),
    );

  }

}