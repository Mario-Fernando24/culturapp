import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/domain/models/oferta_cultural_model.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';
import 'package:culturappco/presentation/widgets/drawer.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfertaCulturalHome extends StatefulWidget {
  const OfertaCulturalHome({super.key});

  @override
  State<OfertaCulturalHome> createState() => _OfertaCulturalHomeState();
}

class _OfertaCulturalHomeState extends State<OfertaCulturalHome> {
  List<OfertaCultural> listOfertaCultual = [];

  @override
  void initState() {
    // TODO: implement initState
    context.read<HomeCubit>().getOfertaCultural();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Oferta cultural'),
      ),
      drawer: drawer_menu(context, Colors.black),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ofertaCulturalAddviewRoutes);
        },
        // ignore: sort_child_properties_last
        child: Icon(
          Icons.add,
          size: 40,
          weight: 20,
          color: kPrimaryColor,
        ),
        backgroundColor: kSecondaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _listOfertaCultural()
            ],
        ),
      ),
    );
  }

  Widget _listOfertaCultural() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is GetOfertaCulturalEvents) {
          listOfertaCultual.addAll(state.listOferaCultural);
        }
        return SizedBox(
          height: SizeConfig.screenHeight! * 1,
          child: ListView.builder(
            
              itemCount: listOfertaCultual.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, int index) {
                return _cardOfertaCultural(context, listOfertaCultual[index]);
              }),
        );
      },
    );
  }


  
  Widget _cardOfertaCultural(BuildContext context, OfertaCultural ofertaCultural) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
         onTap: () => Navigator.pushNamed(context, detailsOfertaCulturalviewRoutes, arguments:ofertaCultural ),
        child: Card(
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(ofertaCultural.image1 ?? "https://www.creativefabrica.com/wp-content/uploads/2021/04/05/Photo-Image-Icon-Graphics-10388619-1-1-580x386.jpg",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12.0, top: 5.0),
                child: Text(ofertaCultural.titleOfertaCultural!,
                 maxLines: 2,
                 textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
               Padding(
                 padding: const EdgeInsets.only(right: 12.0, left: 12.0, bottom: 20.0, top: 10),
                 child: Text(ofertaCultural.description!,
                 maxLines: 2,
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                      ),
               ),
            ],
          ),
        ),
      ),
    );
  }

}
