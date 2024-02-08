import 'dart:io';

import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/domain/models/oferta_cultural_model.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';
import 'package:culturappco/presentation/widgets/back_button.dart';
import 'package:culturappco/presentation/widgets/toasMessage.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/header_text.dart';

class OfertaCulturalAdd extends StatefulWidget {
  const OfertaCulturalAdd({super.key});

  @override
  State<OfertaCulturalAdd> createState() => _OfertaCulturalAddState();
}

class _OfertaCulturalAddState extends State<OfertaCulturalAdd> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _youtubeController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  File? imageFile;
  File? imageFile2;
  File? imageFile3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0.0,
          title: Text('Nueva oferta cultural'),
          leading: Builder(builder: (BuildContext context) {
            return backButton(context, Colors.white);
          })),
      body: BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
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
        if (state is OfertaCulturalAddState) {
          if (state.status) {
            toasMessage("Oferta cultural guardada correctamente");
            Navigator.pushNamed(context, ofertaCulturalHomeviewRoutes);
          } else {
            toasMessage("Hubo un error interno\nPor favor intentelo mas tarde");
          }
        }
      }, builder: (context, state) {
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              _title(context),
              _description(context),
              _dateEvento(),
              _telefono(context),
              _youtube(context),
              _instagram(context),
              _facebook(context),
              _imagenes(context),
              _buttonCultura(context)
            ],
          ),
        );
      }),
    );
  }

  Widget _title(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleForm('Titulo de la oferta'),
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5),
          padding: const EdgeInsets.only(left: 5.0),
          width: SizeConfig.blockSizeV! * 43,
          height: SizeConfig.blockSizeH! * 13,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: PrimaryGreyColors),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _titleController,
                  onChanged: (value) => {setState(() {})},
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Titulo de la oferta",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _description(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleForm('Descripción de la oferta'),
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5),
          padding: const EdgeInsets.only(left: 5.0),
          width: SizeConfig.blockSizeV! * 43,
          height: SizeConfig.blockSizeH! * 35,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: PrimaryGreyColors),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 5,
                  onChanged: (value) => {setState(() {})},
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Descripción de la oferta",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _telefono(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleForm('Telefono'),
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5),
          padding: const EdgeInsets.only(left: 5.0),
          width: SizeConfig.blockSizeV! * 43,
          height: SizeConfig.blockSizeH! * 13,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: PrimaryGreyColors),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _telefonoController,
                  onChanged: (value) => {setState(() {})},
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Telefono",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _youtube(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleForm('Youtube'),
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5),
          padding: const EdgeInsets.only(left: 5.0),
          width: SizeConfig.blockSizeV! * 43,
          height: SizeConfig.blockSizeH! * 13,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: PrimaryGreyColors),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _youtubeController,
                  onChanged: (value) => {setState(() {})},
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "https://www.youtube.com/channe",
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
          width: SizeConfig.blockSizeV! * 43,
          height: SizeConfig.blockSizeH! * 13,
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
          width: SizeConfig.blockSizeV! * 43,
          height: SizeConfig.blockSizeH! * 13,
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

    Widget _dateEvento() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleForm('Fecha del evento '),
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5),
          padding: const EdgeInsets.only(left: 5.0),
          width: SizeConfig.blockSizeV! * 43,
          height: SizeConfig.blockSizeH! * 13,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: PrimaryGreyColors),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: TextFormField(
            controller: _dateController,
            decoration: InputDecoration(
              labelText: 'Fecha del evento',
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              hintStyle: TextStyle(
                fontSize: 17,
                color: Colors.grey,
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today, color: kPrimaryColor),
                onPressed: () => _selectDate(context),
              ),
              filled: true,
              focusColor: Colors.transparent,
              focusedBorder: InputBorder.none,
              labelStyle: TextStyle(
                color: kPrimaryColor,
              ),
            ),
            readOnly: true,
            onTap: () => _selectDate(context),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: kPrimaryColor,
            colorScheme: ColorScheme.light(primary: kPrimaryColor),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      print(selectedDate.toLocal());
      _dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
    }
  }


  Widget _buttonCultura(BuildContext context) {
    return Container(
      width: 350.0,
      height: 50.0,
      margin: EdgeInsets.only(top: 25.0),
      child: ElevatedButton(
        onPressed: () {
          if (_titleController.text.trim().isNotEmpty &&
              _descriptionController.text.trim().isNotEmpty &&
              _telefonoController.text.trim().isNotEmpty &&
              _youtubeController.text.trim().isNotEmpty &&
              _instagramController.text.trim().isNotEmpty &&
              _dateController.text.toString().isNotEmpty &&
              _facebookController.text.trim().isNotEmpty) {
            if (imageFile!.path.isNotEmpty &&
                imageFile2!.path.isNotEmpty &&
                imageFile3!.path.isNotEmpty) {
              final ofertaModels = OfertaCultural(
                  titleOfertaCultural: _titleController.text.trim(),
                  description: _descriptionController.text.trim(),
                  telefono: _telefonoController.text.trim(),
                  youtube: _youtubeController.text.trim(),
                  instagram: _instagramController.text.trim(),
                  facebook: _facebookController.text.trim(),
                  fecha: _dateController.text.trim().toString(),
                  image1: imageFile!.path,
                  image2: imageFile2!.path,
                  image3: imageFile3!.path);

              context.read<HomeCubit>().saveOfertaCultural(
                  ofertaModels, imageFile!, imageFile2!, imageFile3!);
            } else {
              toasMessage("Todos las imagenes son obligatorias");
            }
          } else {
            toasMessage("Todos los campos deben ser deligenciados");
          }
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
