import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';
import 'package:culturappco/presentation/widgets/drawer.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeViewAdmin extends StatefulWidget {
  const HomeViewAdmin({super.key});

  @override
  State<HomeViewAdmin> createState() => _HomeViewAdminState();
}

class _HomeViewAdminState extends State<HomeViewAdmin> {
  @override
  void initState() {
    context.read<HomeCubit>().numeroEventos();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Culturapp'),
        ),
        drawer: drawer_menu(context, Colors.black),
        body: BlocBuilder<HomeCubit, HomeState>(
          
          builder: (context, state) {
            if(state is NumeroEventos){
            return Column(
              children: [
                GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, ofertaCulturalHomeviewRoutes),
                    child: _cardOfertas(
                        "Oferta cultural", state.listEventos[1].toString(), colorOfertaCultural)),
                GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, agendaCulturalListviewRoutes),
                    child: _cardOfertas(
                        "Agenda cultural", state.listEventos[2].toString(), colorAgendaCultural)),
                GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, homeArtistaDirectorio),
                    child: _cardOfertas(
                        "Directorio de artista", state.listEventos[0].toString(), colorDirectorioArtista))
              ],
            );
            }
              return Center(child: CircularProgressIndicator());

          },
        ),
      ),
    );
  }

  Widget _cardOfertas(String title, String num, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Container(
        color: color,
        width: double.infinity,
        height: 150,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              num,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
