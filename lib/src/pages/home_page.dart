import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/pelicual_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();


  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTargetas(),
            _footer(context)
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

  Widget _footer(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead)
          ),
          SizedBox(height: 5.0,),
          // la diferencia entre un FutuereBuilder y un StreamBuilder es que el FutureBuilder solo se ejecuta una vez
          // y el streamBuilder se puede ejecutar mas de una vez
          StreamBuilder(
            // en stream: ponemos la funcion para escuchar al stream
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              // el signo de interrogación despues del data sirve para indicar si hay datos en el snapshot entonces ejecute el forEach
              // snapshot.data?.forEach((p) => print(p.title));

              if (snapshot.hasData){
                return MovieHorizontal(
                  // mandamos la data del snapshot
                  peliculas: snapshot.data,
                  // mandamos la funcion a ejecutar
                  siguientePagina: peliculasProvider.getPopulares,
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );

  }

}