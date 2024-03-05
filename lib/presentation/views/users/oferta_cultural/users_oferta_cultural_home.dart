import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/domain/models/oferta_cultural_model.dart';
import 'package:culturappco/presentation/cubits/directoryArtistaCubit/directory_artista_usuario_cubit.dart';
import 'package:culturappco/presentation/cubits/ofertaCulturalUsuarioCubit/oferta_cultural_usuario_cubit.dart';
import 'package:culturappco/presentation/widgets/drawer_usuario.dart';
import 'package:culturappco/presentation/widgets/toasMessage.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:culturappco/utils/function/parsear_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UsersOfertaCulturalHome extends StatefulWidget {
  const UsersOfertaCulturalHome({super.key});

  @override
  State<UsersOfertaCulturalHome> createState() =>
      _UsersOfertaCulturalHomeState();
}

class _UsersOfertaCulturalHomeState extends State<UsersOfertaCulturalHome> {
  List<OfertaCultural> listEventos = [];
  // Asegúrate de definir estas variables en el estado de tu Widget
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    context.read<OfertaCulturalUsuarioCubit>().getOfertaCultural("");
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
                            context
                                .read<OfertaCulturalUsuarioCubit>()
                                .getOfertaCultural(value);
                          }),
                        }
                    },
                    decoration: InputDecoration(
                      hintText: 'Buscar oferta cultural',
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
                    context
                        .read<OfertaCulturalUsuarioCubit>()
                        .getOfertaCultural("");
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
        child:
            BlocBuilder<OfertaCulturalUsuarioCubit, OfertaCulturalUsuarioState>(
          builder: (context, state) {
            if (state is GetOfertaCulturalEventUsuario) {
              listEventos.clear(); // Limpiar la lista actual
              listEventos.addAll(state.listOferaCultural);
            }
            if (state is OfertaCulturaLoading) {
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
            // TODO: implement listene
          },
        ),
      ),
    );
  }

  Widget _container() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: ListView.builder(
          itemCount: listEventos.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, int index) {
            return SingleChildScrollView(
              child: _cardList(listEventos[index]),
            );
          }),
    );
  }

  Widget _cardList(OfertaCultural ofertaCultural) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: colorAgendaCultural,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Image.network(
                ofertaCultural.image1
                    .toString(), // Sustituye con la URL de la imagen que quieres mostrar.
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  color: colorOfertaCultural,
                  child: Text(
                    parsearDateTime(ofertaCultural.fecha!),
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Row(
                  children: <Widget>[
                    Container(
                      color: colorDirectorioArtista,
                      child: IconButton(
                        icon: Icon(Icons.share),
                        color: Colors.white,
                        onPressed: () async {
                          final resp = await context
                              .read<DirectoryArtistaCubit>()
                              .getCurrent();
                          if (resp == 'null') {
                            toasMessage("Debes iniciar sesión");
                            Navigator.pushNamed(context, loginViewRoutes);
                          } else {
                            context
                                .read<OfertaCulturalUsuarioCubit>()
                                .downloadAndShareOfertaCultural(ofertaCultural);
                          }
                        },
                      ),
                    ),
                    Container(
                      color: colorAgendaCultural,
                      child: IconButton(
                        icon: Icon(Icons.visibility),
                        color: Colors.white,
                        onPressed: () async {
                          final resp = await context
                              .read<DirectoryArtistaCubit>()
                              .getCurrent();
                          if (resp == 'null') {
                            toasMessage("Debes iniciar sesión");
                            Navigator.pushNamed(context, loginViewRoutes);
                          } else {
                            Navigator.pushNamed(
                                context, usersOfertaCulturalDetailsRoute,
                                arguments: ofertaCultural);
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
                color: colorOfertaCultural,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Text(
                  ofertaCultural.titleOfertaCultural!,
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
