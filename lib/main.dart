import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imc_calculator/components/colored_text.dart';
import 'package:imc_calculator/components/imc_image_show.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
          useMaterial3: true,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text(
                'IMCalc',
                style:
                    TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
              ),
              backgroundColor: Colors.deepPurpleAccent,
            ),
            body: const Scaffold(
              body: Padding(
                padding: EdgeInsets.all(16.0),
                child: ImcCalculatorPage(),
              ),
            )));
  }
}

class ImcCalculatorPage extends StatefulWidget {
  const ImcCalculatorPage({super.key});

  @override
  State<ImcCalculatorPage> createState() => _ImcCalculatorPageState();
}

class _ImcCalculatorPageState extends State<ImcCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  double _weight = 0.0;
  double _high = 0.0;
  double _imc = 0.0;

  void _calculateIMC() {
    if (_high != 0) {
      setState(() {
        _imc = _weight / (_high * _high);
      });
      return;
    }
    setState(() {
      _imc = 0;
    });
  }

  void _clear() {
    setState(() {
      _imc = 0;
      _weight = 0;
      _high = 0;
    });
  }

  bool _validateKey(double key) => key > 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: TextEditingController(
                            text: _validateKey(_weight)
                                ? _weight.toString()
                                : ''),
                        decoration: const InputDecoration(labelText: 'Weight'),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: false,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(
                              r'((?=\.\d|\d)(?:\d+)?(?:\.?\d*))(?:[Ee]([+-]?\d+))?'))
                        ],
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'Please type your weight.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _weight = double.parse(value!);
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: TextEditingController(
                            text: _validateKey(_high) ? _high.toString() : ''),
                        decoration: const InputDecoration(labelText: 'High'),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: false,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(
                              r'((?=\.\d|\d)(?:\d+)?(?:\.?\d*))(?:[Ee]([+-]?\d+))?'))
                        ],
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'Please type your high.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _high = double.parse(value!);
                        },
                      ),
                    )
                  ],
                ),
                ColoredText(imc: _imc),
                ImcImageShow(imc: _imc),
                Padding(
                  padding: EdgeInsets.only(top: _validateKey(_imc) ? 50 : 200),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_validateKey(_imc) &&
                          !_validateKey(_weight) &&
                          !_validateKey(_high)) {
                        _clear();
                        return;
                      }

                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _calculateIMC();
                      }
                    },
                    child: const Text('Calc'),
                  ),
                )
              ],
            ))));
  }
}
