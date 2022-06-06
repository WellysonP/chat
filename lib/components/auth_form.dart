import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nome"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "E-mail"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Senha"),
                obscureText: true,
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {},
                child: Text("Entrar"),
              ),
              TextButton(onPressed: () {}, child: Text("Criar uma nova conta"))
            ],
          ),
        ),
      ),
    );
  }
}
