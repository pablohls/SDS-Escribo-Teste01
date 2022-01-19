import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formUserData = GlobalKey<FormState>();
  var resultado = {};
  var resultadoSoma = 'Por favor, insira um valor!';
  var resultadoInteiros = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            "Seleção de Desenvolvedor de Software Escribo - Teste Técnico 1"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                  "Olá! Por favor, insira um número inteiro maior que 0:"),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: Card(
                      elevation: 10.0,
                      child: Form(
                        onChanged: () {
                          setState(() {});
                        },
                        key: _formUserData,
                        child: TextFormField(
                          //controller: _valorController,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              resultadoSoma = "Por favor, insira um valor.";
                              resultadoInteiros = "";
                            } else if (int.parse(value) == 0) {
                              resultadoSoma =
                                  "Por favor, insira um valor maior que zero.";
                              resultadoInteiros = "";
                            } else if (int.parse(value) < 4) {
                              resultadoSoma = "Valor muito baixo.";
                              resultadoInteiros = "Nenhum divisível encontrado";
                            } else {
                              resultado = converterText(value);
                              resultadoSoma = resultado['resultado'].toString();
                              resultadoInteiros =
                                  resultado['inteiros'].toString();
                            }
                          },
                          validator: (value) => Validator.number(value)
                              ? "Apenas numeros inteiros"
                              : null,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Text("Soma dos Divisíveis: $resultadoSoma"),
              const SizedBox(
                height: 25,
              ),
              Text(
                  "Numeros Divisíveis por 3 ou 5 menores que o valor digitado:\n $resultadoInteiros"),
            ],
          ),
        ),
      ),
    );
  }
}

dynamic converterText(String texto) {
  int valor;
  List<int> resultados = [];
  int somaTotal = 0;
  var resultado = {};

  valor = int.parse(texto);

  for (int i = 1; i < valor; i++) {
    if (i % 3 == 0 || i % 5 == 0) {
      resultados.add(i);
      somaTotal += i;
    }
  }

  resultado = {'resultado': somaTotal, 'inteiros': resultados};
  return resultado;
}
