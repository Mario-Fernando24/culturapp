import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/domain/models/evento_models.dart';
import 'package:culturappco/presentation/cubits/directoryArtistaCubit/directory_artista_usuario_cubit.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';
import 'package:culturappco/presentation/cubits/loginCubits/auth_cubit.dart';
import 'package:culturappco/presentation/cubits/usuarioCubits/usuario_cubit.dart';
import 'package:culturappco/presentation/widgets/drawer_usuario.dart';
import 'package:culturappco/presentation/widgets/toasMessage.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:culturappco/utils/constants/constant_string.dart';
import 'package:culturappco/utils/function/parsear_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeViewUser extends StatefulWidget {
  const HomeViewUser({super.key});

  @override
  State<HomeViewUser> createState() => _HomeViewUserState();
}

class _HomeViewUserState extends State<HomeViewUser> {
  List<Evento> listEventos = [];
  bool loading = false;
  // Asegúrate de definir estas variables en el estado de tu Widget
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String estadoApp = 'null';
  bool _showSocialButtons = false;

  @override
  void initState() {
    context.read<UsuarioCubit>().getEventsUsuario("");
    _validateStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerUsuario(),
      floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_showSocialButtons) ...[
          FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () => context.read<HomeCubit>().urlGlobal(url_facebook),
            heroTag: 'facebook',
            child: FaIcon(
              FontAwesomeIcons.facebook,
              size: 40,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 16.0),
          FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () => context.read<HomeCubit>().urlGlobal(url_instagram),
            heroTag: 'instagram',
            child: FaIcon(
              FontAwesomeIcons.instagram,
              size: 40,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 16.0),
          FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () => context.read<HomeCubit>().urlGlobal(url_whatsapp),
            heroTag: 'whatsapp',
            child: FaIcon(
              FontAwesomeIcons.whatsapp,
              size: 40,
              color: Color.fromRGBO(76, 175, 80, 1),
            ),
          ),
          SizedBox(height: 16.0),
          FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () => context.read<HomeCubit>().urlGlobal(url_youtube),
            heroTag: 'youtube',
            child: FaIcon(
              FontAwesomeIcons.youtube,
              size: 40,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 16.0),
          FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () => context.read<HomeCubit>().urlGlobal(url_tiktok),
            heroTag: 'tiktok',
            child: FaIcon(
              FontAwesomeIcons.tiktok,
              size: 40,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 30.0),
        ],
        FloatingActionButton(
          backgroundColor: Color(0xff71C7E3),
          onPressed: () {
            setState(() {
              _showSocialButtons = !_showSocialButtons;
            });
          },
          heroTag: 'toggle_social',
          child: Icon(
            _showSocialButtons ? Icons.visibility_off : Icons.visibility,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.0),
        FloatingActionButton(
          backgroundColor: estadoApp == 'null' ? Colors.green[900] : Colors.red,
          onPressed: () {
            if (estadoApp == 'null') {
              toasMessage("Debes iniciar sesión");
              Navigator.pushNamed(context, loginViewRoutes);
            } else {
              toasMessage("Acabas de cerrar sesión");
              context.read<AuthenticationCubit>().logOut();
              Navigator.pushNamedAndRemoveUntil(context, homeUserviewRoutes, (route) => false);
            }
          },
          heroTag: 'auth_action',
          child: Icon(
            estadoApp == 'null' ? Icons.exit_to_app_sharp : Icons.close_rounded,
            color: Colors.white,
          ),
        ),
      ],
    ),
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
                                .read<UsuarioCubit>()
                                .getEventsUsuario(value);
                          }),
                        }
                    },
                    decoration: InputDecoration(
                      hintText: 'Buscar agenda cultural',
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
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logovert.png')
                          as ImageProvider,
                      fit: BoxFit.fill,
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
                    context.read<UsuarioCubit>().getEventsUsuario("");
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
        child: BlocBuilder<UsuarioCubit, UsuarioCubitState>(
          builder: (context, state) {
            if (state is GetEventsUsuario) {
              listEventos.clear(); // Limpiar la lista actual
              listEventos.addAll(state.listEvents);
              loading = false;
            }
            if (state is UsuarioLoading) {
              loading = true;
            }
            if (state is UsuarioInitial) {
              loading = false;
            }

            return Stack(
              children: [
                listBuilder(), // El contenido principal de tu aplicación
                loading == true
                    ? Container(
                        height: MediaQuery.of(context).size.height * 1,
                        color: Colors.black
                            .withOpacity(0.5), // Fondo semitransparente
                        child: Center(
                          child:
                              CircularProgressIndicator(), // El indicador de carga
                        ),
                      )
                    : Container(), // Si no está cargando, muestra un contenedor vacío
              ],
            );
            // TODO: implement listene
          },
        ),
      ),
    );
  }

  Widget listBuilder() {
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

  Widget _cardList(Evento evento) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: colorOfertaCultural,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              FadeInImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  evento.imagen.toString(),
                ),
                placeholder: AssetImage('assets/images/loading.gif'),
                fadeInDuration: Duration(milliseconds: 200),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  color: colorOfertaCultural,
                  child: Text(
                    parsearDateTime(evento.fechaEvento),
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
                                .read<UsuarioCubit>()
                                .downloadAndShare(evento);
                          }
                        },
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      child: IconButton(
                        icon: Icon(Icons.calendar_month),
                        color: Colors.white,
                        onPressed: () async {
                          final resp = await context
                              .read<DirectoryArtistaCubit>()
                              .getCurrent();
                          if (resp == 'null') {
                            toasMessage("Debes iniciar sesión");
                            Navigator.pushNamed(context, loginViewRoutes);
                          } else {
                            context.read<UsuarioCubit>().addEventToCalendar();
                          }
                        },
                      ),
                    ),
                    Container(
                      color: colorOfertaCultural,
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
                                  context, homeUserviewDetailsRoutes,
                                  arguments: evento);
                            }
                          }),
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
                  evento.tituloEvento,
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

  Future<void> shareDialog() async {
    FloatingActionButton(
      onPressed: () {
        Share.share('Comparte mi aplicación!');
      },
      child: Icon(Icons.share),
    );
  }

  Widget modalLoading() {
    return loading
        ? Container(
            color: colorDirectorioArtista,
            child: Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ),
          )
        : Container();
  }

  Future<void> _validateStatus() async {
    final response = await context.read<DirectoryArtistaCubit>().getCurrent();
    setState(() {
      estadoApp = response;
    });
  }
}
