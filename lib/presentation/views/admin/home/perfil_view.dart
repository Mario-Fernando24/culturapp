import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/domain/models/usuario.dart';
import 'package:culturappco/presentation/cubits/loginCubits/auth_cubit.dart';
import 'package:culturappco/presentation/widgets/back_button.dart';
import 'package:culturappco/presentation/widgets/drawer.dart';
import 'package:culturappco/presentation/widgets/header_text.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:culturappco/utils/constants/constant_string.dart';
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
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password_confirm_Controller =
      TextEditingController();
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _usersValidate = false;
  bool _lastNameValidate = false;
  bool _emailValidate = false;
  bool _phoneValidate = false;
  bool _passwordValidate = false;
  bool _password_confirm_Validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Perfil'),
        ),
        drawer: drawer_menu(context,Colors.black),
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            if (state.user.rol == rolUser)
              Navigator.pushNamed(context, homeUserviewRoutes);
          } else if (state is AuthenticationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red, // Color de fondo rojo
              behavior: SnackBarBehavior.floating, // Posición superior
            ));
          }
        },
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return _registerForm(context);
        },
      ),
    );
  }

  Widget _registerForm(BuildContext context) {
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
                    fit:
                        BoxFit.contain, // Ajusta el BoxFit según tus preferencias
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
                onChanged: (value) => {
                  setState(() {
                    _usersValidate = _usersController.text.isNotEmpty;
                  })
                },
                decoration: InputDecoration(
                  hintText: "Nombre",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            _usersValidate
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.check_circle, color: Colors.green),
                )
                : Container(),
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
              controller: _lastNameController,
              onChanged: (value) => {
                setState(() {
                  _lastNameValidate = _lastNameController.text.isNotEmpty;
                })
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: "Apellido",
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
          _lastNameValidate
              ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                child: Icon(Icons.check_circle, color: Colors.green),
              )
              : Container(),
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
              controller: _emailController,
              onChanged: (value) => {
                setState(() {
                  _emailValidate = _emailController.text.isNotEmpty;
                })
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Correo electronico",
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
          _emailValidate
              ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                child: Icon(Icons.check_circle, color: Colors.green),
              )
              : Container(),
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
              onChanged: (value) => {
                setState(() {
                  _phoneValidate = _phoneController.text.isNotEmpty;
                })
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "Telefono",
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
          _phoneValidate
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.check_circle, color: Colors.green),
                )
              : Container(),
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
              username: _usersController.text.trim(),
              lastname: _lastNameController.text.trim(),
              email: _emailController.text.trim(),
              telefono: _phoneController.text.trim(),
              password: "");
          context.read<AuthenticationCubit>().register(userss);
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
