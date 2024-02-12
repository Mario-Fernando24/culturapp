import 'dart:io';

import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/domain/models/categoria_models.dart';
import 'package:culturappco/domain/models/directorio_artista.dart';
import 'package:culturappco/domain/models/oferta_cultural_model.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';
import 'package:culturappco/presentation/widgets/header_text.dart';
import 'package:culturappco/presentation/widgets/toasMessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class HomeArtistaDirectorioAdd extends StatefulWidget {
  const HomeArtistaDirectorioAdd({super.key});

  @override
  State<HomeArtistaDirectorioAdd> createState() =>
      _HomeArtistaDirectorioAddState();
}

class _HomeArtistaDirectorioAddState extends State<HomeArtistaDirectorioAdd> {
  List<CategoriaEvento> categoryEvents = [];
  int selectedGenderIndex = -1;
  String NameGender = 'Seleccione categoria';
  String codeGender = 'ok';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();

  File? imageFile;
  File? imageFile2;
  File? imageFile3;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getCategoryEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Agregar Artista'),
          backgroundColor: kPrimaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          )),
      body: formulario(),
    );
  }

  Widget formulario() {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state is GetCategoryEvents) {
        categoryEvents.addAll(state.listCategoryEvents);
      }
      if (state is ImageFileProfile) {
        if (state.numImagen == 1) {
          imageFile = state.imageFile;
        }
        if (state.numImagen == 2) {
          imageFile2 = state.imageFile;
        }
        if (state.numImagen == 3) {
          imageFile3 = state.imageFile;
        }
      }
    }, builder: (context, state) {
      if (state is HomeLoading) {
        return Center(child: CircularProgressIndicator());
      }
      return SingleChildScrollView(
        child: Column(
          children: [
            categoryForm(),
            _textName(),
            _textDescription(context),
            _facebook(context),
            _instagram(context),
            _imagenes(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            _buttonDirectorioArtista(context)
          ],
        ),
      );
    });
  }

  Widget categoryForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
          child: Text(
            "Seleccione categoria",
            textAlign: TextAlign.start,
            style: TextStyle(
              color: PrimaryBlackColors,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: PrimaryGreyColors),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: GestureDetector(
            onTap: () => _showModalBottomSheet(context, categoryEvents, 130),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.9),
                  child: Text(NameGender,
                      style: TextStyle(
                        color: PrimaryBlackColors,
                        fontSize: 16,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: kPrimaryColor,
                    size: 40,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _textName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleForm('Nombre'),
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5),
          padding: const EdgeInsets.only(left: 5.0),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: PrimaryGreyColors),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _nameController,
                  onChanged: (value) => {setState(() {})},
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Nombre",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _textDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleForm('Descripción'),
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5),
          padding: const EdgeInsets.only(left: 5.0),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: PrimaryGreyColors),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _descripcionController,
                  maxLines: 5,
                  onChanged: (value) => {setState(() {})},
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Descripción",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _instagram(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleForm('Instagram'),
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5),
          padding: const EdgeInsets.only(left: 5.0),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: PrimaryGreyColors),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _instagramController,
                  onChanged: (value) => {setState(() {})},
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "https://www.instagram.com/example/",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _facebook(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleForm('Facebook'),
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5),
          padding: const EdgeInsets.only(left: 5.0),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: PrimaryGreyColors),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _facebookController,
                  onChanged: (value) => {setState(() {})},
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "https://www.facebook.com/example.96/",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _imagenes(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            child: GestureDetector(
              onTap: () => showAlertDialog(context, 1),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageFile != null
                        ? FileImage(imageFile!)
                        : AssetImage('assets/images/no-image.png')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            child: GestureDetector(
              onTap: () => showAlertDialog(context, 2),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageFile2 != null
                        ? FileImage(imageFile2!)
                        : AssetImage('assets/images/no-image.png')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            child: GestureDetector(
              onTap: () => showAlertDialog(context, 3),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageFile3 != null
                        ? FileImage(imageFile3!)
                        : AssetImage('assets/images/no-image.png')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonDirectorioArtista(BuildContext context) {
    return Container(
      width: 350.0,
      height: 50.0,
      margin: EdgeInsets.only(top: 25.0, right: 20, left: 20),
      child: ElevatedButton(
        onPressed: () {
          final directorioArtista = DirectorioArtista(
              categoria: NameGender,
              idCategoria: codeGender,
              name: _nameController.text.trim(),
              descripcion: _descripcionController.text.trim(),
              facebook: _facebookController.text.trim(),
              instagram: _instagramController.text.trim(),
              image1: imageFile!.path,
              image2: imageFile2!.path,
              image3: imageFile3!.path
              );

          context.read<HomeCubit>().saveDirectorioArtista(
              directorioArtista, imageFile!, imageFile2!, imageFile3!);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Registrar oferta cultural',
              style: TextStyle(fontSize: 15.0),
            ),
            SizedBox(width: 10)
          ],
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),
    );
  }

  void _showModalBottomSheet(
      BuildContext context, List<CategoriaEvento> categoria, double size) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.30,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 300, top: 16),
                    child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'X',
                          style: TextStyle(
                              fontSize: 22, color: PrimaryBlackColors),
                        ))),
                Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: ListView(
                    children: categoria.asMap().entries.map((entry) {
                      int index = entry.key;
                      String descripcionTipoDocumento = entry.value.name!;
                      return ListTile(
                        title: Text(descripcionTipoDocumento,
                            style: TextStyle(color: PrimaryBlackColors)),
                        trailing: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            activeColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            value: index == selectedGenderIndex,
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  selectedGenderIndex = index;
                                  NameGender =
                                      categoria[selectedGenderIndex].name!;

                                  codeGender =
                                      categoria[selectedGenderIndex].uid ?? '';

                                  print("mario");

                                  Navigator.pop(context);
                                } else {
                                  selectedGenderIndex = -1;
                                }
                              });
                            },
                          ),
                        ),
                        onTap: () {},
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showAlertDialog(BuildContext context, int number) async {
    Widget galleryButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
        ),
        onPressed: () async {
          context
              .read<HomeCubit>()
              .selectImageOfertaCultural(ImageSource.gallery, number);
        },
        child: Text("Galeria", style: TextStyle(color: Colors.black)));

    Widget cameraButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
        ),
        onPressed: () async {
          context
              .read<HomeCubit>()
              .selectImageOfertaCultural(ImageSource.camera, number);
        },
        child: Text("Camara", style: TextStyle(color: Colors.black)));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una opción'),
      actions: [galleryButton, cameraButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
