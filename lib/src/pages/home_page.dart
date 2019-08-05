import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/pelicual_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';


class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();


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

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        // si el snapshot tiene algun dato retornamos el CardSwiper
        if (snapshot.hasData){
          return CardSwiper(
          // el snapshot. data retorna el future de peliculasProvider
          peliculas: snapshot.data,
          );
        }else { //caso contrario retornamos un loading
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
        
      },
    );

  }

}