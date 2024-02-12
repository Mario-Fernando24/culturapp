import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:culturappco/domain/models/categoria_models.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';

class HomeCategoriaDirectorio extends StatefulWidget {
  const HomeCategoriaDirectorio({Key? key}) : super(key: key);

  @override
  State<HomeCategoriaDirectorio> createState() =>
      _HomeCategoriaDirectorioState();
}

class _HomeCategoriaDirectorioState extends State<HomeCategoriaDirectorio> {
  List<CategoriaEvento> categoryEvents = [];

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getCategoryEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is GetCategoryEvents) {
            categoryEvents = state.listCategoryEvents;
            return Padding(
              padding: const EdgeInsets.only(top: 14),
              child: _listArtista(context),
            );
          }
          return CircularProgressIndicator();
        },
        
      ),
    );
  }

  Widget _listArtista(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.77,
      child: ListView.builder(
        itemCount: categoryEvents.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, int index) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                _cardCategory(context, categoryEvents[index]),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _cardCategory(BuildContext context, CategoriaEvento categoriaEvento) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        onTap: () => {},
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 8,
                spreadRadius: 2,
                color: Color.fromRGBO(186, 186, 186, 0.25),
              )
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              categoriaEvento.name ?? "",
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Spacer(),
                            // IconButton(
                            //   icon: new Icon(Icons.edit_outlined),
                            //   highlightColor: Colors.pink,
                            //   onPressed: () => {},
                            // ),
                            SizedBox(width: 14),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 15.0,
                            top: 0.02,
                            bottom: 20.0,
                          ),
                          child: Text(
                            categoriaEvento.description ?? "",
                            maxLines: 4,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 29, 14, 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
