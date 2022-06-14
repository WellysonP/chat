import 'dart:io';
import 'package:chat/components/user_image_picker.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  // final _passwordController = TextEditingController();
  final _formData = AuthFormData();

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSingUp) {
      return _showError("Imagem não selecionada");
    }

    widget.onSubmit(_formData);
  }

  void _handlerImagePick(File image) {
    _formData.image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSingUp)
                UserImagePicker(onImagePick: _handlerImagePick),
              if (_formData.isSingUp)
                TextFormField(
                  key: ValueKey("name"),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name,
                  decoration: InputDecoration(labelText: "Nome"),
                  validator: (_name) {
                    final name = _name ?? "";
                    if (name.trim().length < 5) {
                      return "Novo deve conter no mínimo 5 caracteres";
                    }
                    return null;
                  },
                ),
              TextFormField(
                key: ValueKey("email"),
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                decoration: InputDecoration(labelText: "E-mail"),
                validator: (_email) {
                  final email = _email ?? "";
                  if (!email.contains("@")) {
                    return "E-mail inválido";
                  }
                  return null;
                },
              ),
              TextFormField(
                key: ValueKey("passord"),
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                decoration: InputDecoration(labelText: "Senha"),
                obscureText: true,
                // controller: _passwordController,
                validator: (_password) {
                  final password = _password ?? "";
                  if (password.length < 6) {
                    return "Senha deve conter no mínimo 6 caracteres";
                  }
                  return null;
                },
              ),
              if (_formData.isSingUp)
                TextFormField(
                  decoration: InputDecoration(labelText: "Confirmar Senha"),
                  obscureText: true,
                  // validator: _formData.isLogin
                  //     ? null
                  //     : (_password) {
                  //         final password = _password ?? "";
                  //         if (password != _passwordController) {
                  //           return "Senhas informadas não conferem";
                  //         }
                  //         return null;
                  //       },
                ),
              SizedBox(height: 12),
              ElevatedButton(
                child: Text(_formData.isLogin ? "Entrar" : "Cadastrar"),
                onPressed: _submit,
              ),
              TextButton(
                child: Text(_formData.isLogin
                    ? "Criar uma nova conta"
                    : "Entrar com conta existente"),
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
