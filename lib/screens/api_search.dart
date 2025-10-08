import 'package:api_flutter/data/models/superhero_response.dart';
import 'package:api_flutter/data/repository.dart';
import 'package:flutter/material.dart';

class ApiSearch extends StatefulWidget {
  const ApiSearch({super.key});

  @override
  State<ApiSearch> createState() => _ApiSearchState();
}

class _ApiSearchState extends State<ApiSearch> {
  Future<SuperheroResponse?>? _superheroInfo;
  Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api search"),
      ),
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Busca un superheroe",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => {
                setState(() {
                  _superheroInfo = repository.fetchSuperheroInfo(value);
                })
              },
            ),
            FutureBuilder(future: _superheroInfo, builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              else if(snapshot.hasError){
                return Text("Error: ${snapshot.error}");
              }
              else if(snapshot.hasData){
                return Text("${snapshot.data?.response}");
              }
              else{
                return Text("No hay resultado");
              }
            }),
          ],
        ),
      );
  }
}