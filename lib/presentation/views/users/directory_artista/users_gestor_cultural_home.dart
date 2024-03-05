import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/domain/models/directorio_artista.dart';
import 'package:culturappco/presentation/cubits/directoryArtistaCubit/directory_artista_usuario_cubit.dart';
import 'package:culturappco/presentation/cubits/ofertaCulturalUsuarioCubit/oferta_cultural_usuario_cubit.dart';
import 'package:culturappco/presentation/widgets/drawer_usuario.dart';
import 'package:culturappco/presentation/widgets/toasMessage.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UsersGestorCulturalHome extends StatefulWidget {
  const UsersGestorCulturalHome({super.key});

  @override
  State<UsersGestorCulturalHome> createState() => _UsersGestorCulturalHomeState();
}

class _UsersGestorCulturalHomeState extends State<UsersGestorCulturalHome> {

  List<DirectorioArtista> listDirectorioArtistaaa = [];
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    context.read<DirectoryArtistaCubit>().getDirectorioArtista("",'GESTOR CULTURAL');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerUsuario(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Ajusta esto según sea necesario
        child: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                size: 38,
                color: Color(0xffEB5C60),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          toolbarHeight: 150.0, // Ajusta esto según sea necesario
          title: _isSearching
              ? Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(left: 16, top: 10),
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: TextField(
                    onChanged: (value) => {
                      if (value.isNotEmpty)
                        {
                          setState(() {
                            context.read<DirectoryArtistaCubit>().getDirectorioArtista(value, 'GESTOR CULTURAL');
                          }),
                        }
                    },
                    decoration: InputDecoration(
                      hintText: 'Buscar gestor cultural',
                      hintStyle: TextStyle(color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    autofocus: true,
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logovert.png')
                          as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                _isSearching ? Icons.cancel : FontAwesomeIcons.search,
                color: Color(0xffEB5C60),
              ),
              onPressed: () {
                setState(() {
                  if (_isSearching) {
                    // Si ya está buscando, limpia el controlador y oculta el campo de búsqueda
                    _searchController.clear();
                    
                    context.read<DirectoryArtistaCubit>().getDirectorioArtista("",'GESTOR CULTURAL');
                  }
                  // Cambia el estado de la búsqueda
                  _isSearching = !_isSearching;
                });
              },
            ),
          ],
          backgroundColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<DirectoryArtistaCubit, DirectorioArtistaState>(
          builder: (context, state) {
            if (state is GetOfertaDirectorioArtistaUsuario) {
               listDirectorioArtistaaa.clear(); // Limpiar la lista actual
               listDirectorioArtistaaa.addAll(state.listDirectorioArtista);
             
            }
            if (state is DirectorioArtistaLoading) {
            //  loading = true;
              return Container();
            }
            if (state is OfertaCulturalInitial) {
             // loading = false;
            }
            return Column(
               children: [
                 SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                 //modalLoading(),
                _container()
               ],
             );
          },
        ),
        
      ),
    );
  }

  Widget _container(){
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child:  ListView.builder(
          itemCount: listDirectorioArtistaaa.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, int index) {
            return SingleChildScrollView(
              child: _cardList(listDirectorioArtistaaa[index]),
            );
          }),
    );
  }

  
  Widget _cardList(DirectorioArtista directorioArtista) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Image.network(
                directorioArtista
                    .image1.toString(), // Sustituye con la URL de la imagen que quieres mostrar.
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Row(
                  children: <Widget>[
                    Container(
                      color: colorAgendaCulturalOscuro,
                      child: IconButton(
                        icon: Icon(Icons.share),
                        color: Colors.white,
                        onPressed: () async {
                          final resp = await context.read<DirectoryArtistaCubit>().getCurrent();
                         if(resp=='null'){
                          toasMessage("Debes iniciar sesión");
                          Navigator.pushNamed(context, loginViewRoutes);
                         }else{
                         context.read<DirectoryArtistaCubit>().downloadAndShareOfertaCultural(directorioArtista);
                         }
                        },
                      ),

                    ),
                    Container(
                      color: Colors.grey,
                      child: IconButton(
                        icon: Icon(Icons.visibility),
                        color: Colors.white,
                        onPressed: () async {
                           final resp = await context.read<DirectoryArtistaCubit>().getCurrent();
                           if(resp=='null'){
                           toasMessage("Debes iniciar sesión");
                           Navigator.pushNamed(context, loginViewRoutes);
                            }else{
                             Navigator.pushNamed(context, usersDirectorioDetailsRoute);
                            }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: colorDirectorioArtista,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Text(
                  directorioArtista.name ?? '',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}