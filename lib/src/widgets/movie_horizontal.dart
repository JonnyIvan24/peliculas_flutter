import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;

  MovieHorizontal ({@required this.peliculas});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.25,
      // PageView sirve para mostrar datos de manera paginada
      child: PageView(
        // en el controller podemos configurar por medio de un PageController la forma de presentar las paginas
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        // en la propiedad pageSnapping se le puede quitar el efecto de imantado al momento de hacer scroll y dejar que mantenga el momentum
        pageSnapping: false,
        children: _tarjetas(context),
      ),
    );
  }

  List<Widget> _tarjetas(BuildContext context) {

    return peliculas.map( (pelicula) {

      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 5.0,),
            // en la propiedad overflow podemos poner algun dato o caracteriztica en caso de que el texto sea muy largo
            // en este caso con .ellipsis se ponen ... al final
            Text(pelicula.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption)
          ],
        ),
      );

    }).toList();

  }

}