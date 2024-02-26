import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/domain/models/evento_models.dart';
import 'package:culturappco/presentation/cubits/usuarioCubits/usuario_cubit.dart';
import 'package:culturappco/presentation/widgets/drawer_usuario.dart';
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

  @override
  void initState() {
    context.read<UsuarioCubit>().getEventsUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerUsuario(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: new AppBar(
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
          toolbarHeight: 150.0,
          title: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.30,
              height: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/agendacultural.png')
                      as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          backgroundColor: colorWhite,
          actions: <Widget>[
            new IconButton(
              icon: Container(
                margin: EdgeInsets.only(right: 20),
                child: new Icon(
                  FontAwesomeIcons.search,
                  color: Color(0xffEB5C60),
                ),
              ),
              onPressed: () => {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<UsuarioCubit, UsuarioCubitState>(
          listener: (context, state) {
            if (state is GetEventsUsuario) {
              listEventos.addAll(state.listEvents);
            }
            if(state is UsuarioLoading){
               loading= true;
            }
            if(state is UsuarioInitial){
              loading = false;
            }
            // TODO: implement listene
          },
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                modalLoading(),
                listBuilder()
              ],
            );
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
      color: colorAgendaCultural,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Image.network(evento.imagen, // Sustituye con la URL de la imagen que quieres mostrar.
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
                      color: colorOfertaCultural,
                      child: IconButton(
                        icon: Icon(Icons.visibility),
                        color: Colors.white,
                        onPressed: () {
                          // Acción para ver detalle
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

  Widget modalLoading(){
    return loading? Container(
              color: colorDirectorioArtista,
              child: Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
            ):Container();
  }

}
