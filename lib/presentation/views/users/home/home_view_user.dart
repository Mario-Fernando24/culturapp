import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/domain/models/evento_models.dart';
import 'package:culturappco/presentation/cubits/usuarioCubits/usuario_cubit.dart';
import 'package:culturappco/presentation/widgets/drawer_usuario.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:culturappco/utils/function/parsear_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

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

  @override
  void initState() {
    context.read<UsuarioCubit>().getEventsUsuario("");
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
                            context.read<UsuarioCubit>().getEventsUsuario(value);
                          }),
                        }
                    },
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
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
             
            }
            if (state is UsuarioLoading) {
              loading = true;
              return Container();
            }
            if (state is UsuarioInitial) {
              loading = false;
            }
            return Column(
               children: [
                 SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                 modalLoading(),
                 listBuilder()
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
      child: listEventos.length>0? ListView.builder(
          itemCount: listEventos.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, int index) {
            return SingleChildScrollView(
              child: _cardList(listEventos[index]),
            );
          }):Center(child: Text("No tiene ningun evento", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
    );
  }

  Widget _cardList(Evento evento) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: colorAgendaCultural,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Image.network(
                evento
                    .imagen, // Sustituye con la URL de la imagen que quieres mostrar.
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  color: colorAgendaCultural,
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
                        onPressed: () {
                          context.read<UsuarioCubit>().downloadAndShare(evento);
                        },
                      ),
                    ),
                    Container(
                      color: colorDirectorioArtista,
                      child: IconButton(
                        icon: Icon(Icons.calendar_month),
                        color: Colors.white,
                        onPressed: () {
                          context.read<UsuarioCubit>().addEventToCalendar();
                        },
                      ),
                    ),
                    Container(
                      color: colorOfertaCultural,
                      child: IconButton(
                        icon: Icon(Icons.visibility),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, homeUserviewDetailsRoutes,
                              arguments: evento);
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
                color: colorAgendaCultural,
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
}
