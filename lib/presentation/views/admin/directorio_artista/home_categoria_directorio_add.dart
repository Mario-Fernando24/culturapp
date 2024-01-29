import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/presentation/widgets/header_text.dart';
import 'package:flutter/material.dart';

class HomeCategoriaDirectorioAdd extends StatefulWidget {
  const HomeCategoriaDirectorioAdd({super.key});

  @override
  State<HomeCategoriaDirectorioAdd> createState() => _HomeCategoriaDirectorioAddState();
}

class _HomeCategoriaDirectorioAddState extends State<HomeCategoriaDirectorioAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Agregar nueva categoria'),
          backgroundColor: kPrimaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          )),
          body:  Stack(
        children: [
        _backgruoundCover(context),
        _boxForm(context),
        _textNewCategory(context)
      ],
      ),
    );
  }

  Widget _backgruoundCover(BuildContext context){
   return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height*0.4,
    color: kPrimaryColor,
   );
}
Widget _textNewCategory(BuildContext context){
  return  SafeArea(
    child: Container(
      margin: EdgeInsets.only(top:16 ),
      alignment: Alignment.topCenter,
        child: Column(
          children: [
          Icon(Icons.category,size: 100,),
          Text("NUEVA CATEGORIA",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),),
          ])
    )
  );
}

Widget _boxForm(BuildContext context){
  return Container(
    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.22, left: 30, right: 30),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black54,
          blurRadius: 15,
          offset: Offset(0.0,75)
        )
      ]
    ),
    height: MediaQuery.of(context).size.height*0.60,
    child: SingleChildScrollView(
      child: Column(
        children: [
          _textYourInfo(),
          _textName(),
          _textDescription(context),
          _buttonUpdate(context)
        ],
      ),
    ),
  );
}

Widget _textYourInfo(){
  return Container(
    margin: EdgeInsets.only(top: 30,bottom: 30),
    child: Text("Agregar categoria",
    style: TextStyle(color: Colors.black,
     fontWeight: FontWeight.bold, fontSize: 30),));
}

Widget _textName(){
   return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleForm('Nombre'),
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
                  // controller: _titleController,
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

Widget _buttonUpdate(BuildContext context) {
    return Container(
      width: 350.0,
      height: 50.0,
      margin: EdgeInsets.only(top: 25.0, left: 20,right: 20),
      child: ElevatedButton(
        onPressed: () {
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Crear categoria',
              style: TextStyle(fontSize: 15.0),
            ),
            SizedBox(width: 10),
            Icon(Icons.category),
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


}