import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
  final _formData = AuthFormData();

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    widget.onSubmit(_formData);
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
