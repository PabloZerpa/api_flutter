import 'package:api_flutter/data/models/superhero_model.dart' hide Image;
import 'package:api_flutter/data/superhero_services.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Superhero> superheroes = [];
  bool isLoading = false;
  String error = '';

  void _searchSuperheroes() async {
    if (_searchController.text.isEmpty) return;

    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      final results = await SuperheroService.searchSuperhero(_searchController.text);
      setState(() {
        superheroes = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
        superheroes = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscador de Superhéroes'),
        backgroundColor: Colors.red[800],
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar superhéroe... (ej: batman, spider)',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: _searchSuperheroes,
                      ),
                    ),
                    onSubmitted: (_) => _searchSuperheroes(),
                  ),
                ),
              ],
            ),
          ),

          // Estado de carga/error/resultados
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (error.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchSuperheroes,
              child: Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (superheroes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Busca tu superhéroe favorito',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: superheroes.length,
      itemBuilder: (context, index) {
        return _buildSuperheroCard(superheroes[index]);
      },
    );
  }

  Widget _buildSuperheroCard(Superhero superhero) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[300],
          backgroundImage: superhero.image.url.isNotEmpty
              ? NetworkImage(superhero.image.url)
              : null,
          child: superhero.image.url.isEmpty
              ? Text(superhero.name[0])
              : null,
        ),
        title: Text(
          superhero.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text('Alias: ${superhero.biography.fullName}'),
            Text('Editorial: ${superhero.biography.publisher}'),
            SizedBox(height: 4),
            _buildPowerStats(superhero.powerstats),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          _showSuperheroDetails(superhero);
        },
      ),
    );
  }

  Widget _buildPowerStats(Powerstats stats) {
    return Wrap(
      spacing: 8,
      children: [
        _buildStatChip('INT: ${stats.intelligence}', Colors.blue),
        _buildStatChip('FUE: ${stats.strength}', Colors.red),
        _buildStatChip('VEL: ${stats.speed}', Colors.green),
      ],
    );
  }

  Widget _buildStatChip(String text, Color color) {
    return Chip(
      label: Text(
        text,
        style: TextStyle(fontSize: 10, color: Colors.white),
      ),
      backgroundColor: color,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      labelPadding: EdgeInsets.symmetric(horizontal: 4),
    );
  }

  void _showSuperheroDetails(Superhero superhero) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(superhero.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Imagen del superhéroe
              if (superhero.image.url.isNotEmpty)
                Center(
                  child: Image.network(
                    superhero.image.url,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              
              SizedBox(height: 16),
              
              // Estadísticas de poder
              Text('Estadísticas de Poder:', style: TextStyle(fontWeight: FontWeight.bold)),
              _buildStatRow('Inteligencia', superhero.powerstats.intelligence),
              _buildStatRow('Fuerza', superhero.powerstats.strength),
              _buildStatRow('Velocidad', superhero.powerstats.speed),
              _buildStatRow('Durabilidad', superhero.powerstats.durability),
              _buildStatRow('Poder', superhero.powerstats.power),
              _buildStatRow('Combate', superhero.powerstats.combat),
              
              SizedBox(height: 16),
              
              // Biografía
              Text('Biografía:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Nombre real: ${superhero.biography.fullName}'),
              Text('Lugar de nacimiento: ${superhero.biography.placeOfBirth}'),
              Text('Primera aparición: ${superhero.biography.firstAppearance}'),
              Text('Alineación: ${superhero.biography.alignment}'),
              
              SizedBox(height: 16),
              
              // Apariencia
              Text('Apariencia:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Género: ${superhero.appearance.gender}'),
              Text('Raza: ${superhero.appearance.race}'),
              Text('Color de ojos: ${superhero.appearance.eyeColor}'),
              Text('Color de pelo: ${superhero.appearance.hairColor}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text('$label:')),
          Expanded(
            flex: 1,
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}