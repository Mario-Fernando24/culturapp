import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/domain/models/usuario.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';
import 'package:culturappco/presentation/widgets/drawer.dart';
import 'package:culturappco/presentation/widgets/header_text.dart';
import 'package:culturappco/presentation/widgets/toasMessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  final TextEditingController _usersController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _usersValidate = false;
  bool _lastNameValidate = false;
  bool _emailValidate = false;
  bool _phoneValidate = false;
  String _uidUsers = '';

  @override
  void initState() {
    // TODO: implement initState
    context.read<HomeCubit>().getProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Perfil'),
      ),
      drawer: drawer_menu(context, Colors.black),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UsuarioState) {
            _usersController.text = state.user.username!;
            _lastNameController.text = state.user.lastname!;
            _emailController.text = state.user.email!;
            _phoneController.text = state.user.telefono!;
            _uidUsers = state.user.uid!;
            return _editProfileForm(context);
          } else if (state is HomeProfile) {
            if (state.status) {
              toasMessage('Su perfil se modifico correctamente');
              state.status!=true;
              return _editProfileForm(context);
            }
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _editProfileForm(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Image.asset(
                    "assets/images/logoapp.png",
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.22,
                    fit: BoxFit
                        .contain, // Ajusta el BoxFit según tus preferencias
                  ),
                ),
              ],
            ),
            _container(context)
          ],
        ),
      ),
    );
  }

  // @override
  Widget _container(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerText('Editar perfil', kPrimaryColor, FontWeight.bold, 30.0),
              _userInput(context),
              _lastNameInput(context),
              _emailInput(context),
              _phoneInput(context),
              _buttonSign_up(context)
              //_phoneInput(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _userInput(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 40.0),
        padding: EdgeInsets.only(left: 20.0),
        decoration: BoxDecoration(
            color: inputColors, borderRadius: BorderRadius.circular(40.0)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _usersController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Nombre",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _lastNameInput(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: inputColors, borderRadius: BorderRadius.circular(40.0)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              enabled: true, // Asegúrate de que esté habilitado para edición.

              controller: _lastNameController,

              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: "Apellido",
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailInput(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: inputColors, borderRadius: BorderRadius.circular(40.0)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              enabled: false,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Correo electronico",
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _phoneInput(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: inputColors, borderRadius: BorderRadius.circular(40.0)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "Telefono",
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonSign_up(BuildContext context) {
    return Container(
      width: 350.0,
      height: 50.0,
      margin: EdgeInsets.only(top: 25.0),
      child: ElevatedButton(
        onPressed: () {
          final userss = Users(
            uid: _uidUsers,
            username: _usersController.text.trim(),
            lastname: _lastNameController.text.trim(),
            telefono: _phoneController.text.trim(),
          );
          context.read<HomeCubit>().updateProfile(userss);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Editar',
              style: TextStyle(fontSize: 15.0),
            ),
            SizedBox(width: 10),
            Icon(Icons.edit),
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
