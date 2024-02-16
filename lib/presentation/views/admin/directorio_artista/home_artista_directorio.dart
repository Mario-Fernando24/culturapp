import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/domain/models/directorio_artista.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeArtistaDirectorio extends StatefulWidget {
  const HomeArtistaDirectorio({super.key});

  @override
  State<HomeArtistaDirectorio> createState() => _HomeArtistaDirectorioState();
}

class _HomeArtistaDirectorioState extends State<HomeArtistaDirectorio> {
  List<DirectorioArtista> directorioArtista = [];

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getDirectorioArtista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [_listArtista(context)],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, homeDirectorioArtistaAddviewRoutes);
        },
        // ignore: sort_child_properties_last
        child: Icon(
          Icons.add,
          size: 40,
          weight: 20,
          color: Colors.white,
        ),
        backgroundColor: colorDirectorioArtista,
      ),
    );
  }


  // BlocBuilder<HomeCubit, HomeState>(
  //       builder: (context, state) {
  //         if (state is GetCategoryEvents) {
  //           categoryEvents = state.listCategoryEvents;
  //           return Padding(
  //             padding: const EdgeInsets.only(top: 14),
  //             child: _listArtista(context),
  //           );
  //         }
  //         return CircularProgressIndicator();
  //       },
        
  //     )
  

  Widget _listArtista(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
         if (state is GetDirectorioArtista) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.77,
          child: Expanded(
            child: ListView.builder(
                itemCount: state.listDirectorioArtista.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, int index) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [cardListArtista(state.listDirectorioArtista[index])],
                    ),
                  );
                }),
          ),
        );
       }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget cardListArtista(DirectorioArtista directorioArtista) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, homeDirectorioArtistaDetailsviewRoutes,arguments: directorioArtista),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(directorioArtista.image1.toString(),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 12, bottom: 5.0),
                child: Text(directorioArtista.name!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(directorioArtista.descripcion!,style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
