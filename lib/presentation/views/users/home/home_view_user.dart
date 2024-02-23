import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/presentation/widgets/drawer_usuario.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeViewUser extends StatefulWidget {
  const HomeViewUser({super.key});

  @override
  State<HomeViewUser> createState() => _HomeViewUserState();
}

class _HomeViewUserState extends State<HomeViewUser> {
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
                  FontAwesomeIcons.search, color: Color(0xffEB5C60),
                  //Icons.arrow_back_ios
                ),
              ),
              onPressed: () => {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height:MediaQuery.of(context).size.height*0.01 ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(5.0),
                  color: colorDirectorioArtista,
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("12-Febrero-2024",textAlign: TextAlign.center,style: TextStyle(color: colorWhite, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(                  
                  margin: EdgeInsets.all(5.0),
                  color: Color.fromARGB(48, 173, 169, 169),
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Icon(Icons.arrow_drop_down_circle_outlined, size: 30,color: Color(0xffEB5C60),
                  ),
                )
              ],
            ),
            listBuilder()
          ],
        ),
      ),
    );
  }

  Widget listBuilder() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1,
      child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, int index) {
            return SingleChildScrollView(
              child: _cardList(),
            );
          }),
    );
  }

  Widget _cardList() {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Image.network(
                'https://ul.edu.co/uleduco/images/Internacionalizacion/carnaval1.jpg', // Sustituye con la URL de la imagen que quieres mostrar.
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  color: colorAgendaCultural,
                  child: Text(
                    '13',
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
                          // Acción para compartir
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
                  'Carnaval de Barranquilla 2025\nQuien lo vive es quien lo goza',
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
}
