
import 'dart:convert';
import 'package:api_flutter/data/models/superhero_response.dart';
import 'package:http/http.dart' as http;

class Repository {

  Future<SuperheroResponse?> fetchSuperheroInfo(String name) async{
    final response = await http.get(Uri.parse(
      "https://superheroapi.com/api/445d2ece3edf01c9c7ad5043f9710643/search/$name"
    ));

    if(response.statusCode == 200){
      var decodedJson = jsonDecode(response.body);
      SuperheroResponse superheroResponse = SuperheroResponse.fromJson(decodedJson);
      return superheroResponse;
    }
    else{
      return null;
    }
  }
}