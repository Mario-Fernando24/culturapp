import 'dart:io';
import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';
import 'package:culturappco/presentation/views/admin/agenda_cultural/marker_map.dart';
import 'package:culturappco/presentation/widgets/back_button.dart';
import 'package:culturappco/presentation/widgets/header_text.dart';
import 'package:culturappco/presentation/widgets/toasMessage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../domain/models/evento_models.dart';

class AddAgendaCultura extends StatefulWidget {
  const AddAgendaCultura({super.key});

  @override
  State<AddAgendaCultura> createState() => _AddAgendaCulturaState();
}

class _AddAgendaCulturaState extends State<AddAgendaCultura> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? imageFile;
  TextEditingController puntoReferenciaController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  double latitud = 0.0;
  double longitud = 0.0;

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0.0,
          title: Text('Nuevo evento cultural'),
          leading: Builder(builder: (BuildContext context) {
            return backButton(context, Colors.white);
          })),
      body: BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
        if (state is ImageFileProfile) {
          Navigator.pop(context);
          imageFile = state.imageFile;
        }
      }, builder: (context, state) {
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _imageCover(context),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      _title(context),
                      _description(context),
                      _textPuntoReferencia(context),
                      _dateEvento(),
                      _buttonRegisterEvento(context),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _imageCover(BuildContext context) {
    return GestureDetector(
      onTap: () => showAlertDialog(context),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageFile != null
                ? FileImage(imageFile!)
                : AssetImage('assets/images/no-image.png') as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleForm('Titulo del evento'),
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
                      hintText: "Titulo del evento",
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
        titleForm('Descripción del evento'),
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
                      hintText: "Descripción del evento",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _textPuntoReferencia(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleForm('Punto de referencia del evento'),
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
          child: TextField(
            onTap: () => goToGoogleMap(context),
            controller: puntoReferenciaController,
            autofocus: true,
            focusNode: AlwaysDisableFocusNode(),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: 'Punto de referencia del evento',
                prefixIcon: Icon(Icons.map)),
          ),
        ),
      ],
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

  Widget _buttonRegisterEvento(BuildContext context) {
    return Container(
      width: 350.0,
      height: 50.0,
      margin: EdgeInsets.only(top: 25.0),
      child: ElevatedButton(
        onPressed: () {
          if (_titleController.text.trim().isEmpty ||
              _descriptionController.text.trim().isEmpty ||
              puntoReferenciaController.text.trim().isEmpty ||
              _dateController.text.trim().isEmpty ||
              imageFile!.path.isEmpty) {
            toasMessage("Todos los campos son obligatorios");
          } else {
             final eventModelo = Evento(
                 imagen: imageFile!.path,
                 tituloEvento: _titleController.text.trim(),
                 descriptionEvento: _descriptionController.text.trim(),
                 direccionEvento: puntoReferenciaController.text.trim(),
                 fechaEvento: _dateController.text.trim(),
                 latitud: latitud,
                 longitud: longitud,
                 uidUsers: 'okoko');
             context.read<HomeCubit>().saveEvents(eventModelo, imageFile);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Registrar evento',
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

  void showAlertDialog(BuildContext context) async {
    Widget galleryButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
        ),
        onPressed: () async {
          context.read<HomeCubit>().selectImage(ImageSource.gallery);
        },
        child: Text("Galeria", style: TextStyle(color: Colors.black)));

    Widget cameraButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
        ),
        onPressed: () async {
          context.read<HomeCubit>().selectImage(ImageSource.camera);
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

  void goToGoogleMap(BuildContext context) async {
    //nos devuelve un mapa
    Map<String, dynamic> refPositionMap = await showMaterialModalBottomSheet(
        context: context,
        builder: (context) => MarkersMapPage(),
        isDismissible: false,
        enableDrag: false);
    latitud = refPositionMap['lat'];
    longitud = refPositionMap['lng'];

    puntoReferenciaController.text = refPositionMap['address'];
    print('referencia del mapa${refPositionMap['address']}');

    print('sssssssssssssssssssssssssssssssssssssssssssssssssssssss');
    print(latitud);
    print(longitud);
    print('sssssssssssssssssssssssssssssssssssssssssssssssssssssss');
  }
}

class AlwaysDisableFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
