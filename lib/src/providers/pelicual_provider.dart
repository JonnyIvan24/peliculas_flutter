import 'dart:core';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {

  String _apyKey      = '2901cde95371f399f890b0378b4d1b03';
  String _url         = 'api.themoviedb.org';
  String _language    = 'es-MX';

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {

    // esperar la respuesta http
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    //print(decodeData['results']);

    final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    //print(peliculas.items[0].title);

    return peliculas.items;
  }


  Future<List<Pelicula>> getEnCines() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apyKey,
      'language': _language
    });

    return _procesarRespuesta(url);

  }

  Future<List<Pelicula>> getPopulares() async {

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apyKey,
      'language': _language
    });

    return _procesarRespuesta(url);

  }

}
