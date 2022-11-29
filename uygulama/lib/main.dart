import 'package:flutter/material.dart';
import 'package:said/form.dart';
import 'package:said/nesne.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Nesne> liste = [];
  bool Varmi = false;
  int quantity = 1;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String UserInput = "nothing";
  TextEditingController _controller = TextEditingController();
  TextEditingController _controllerr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Center(child: Text("Liste Uygulaması")),
          ),
          body: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,

                            decoration: InputDecoration(
                              hintText: "nesne adı",
                            ),
                            controller: _controller,
                          ),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.all(30),
                          child: Column(
                            children: [
                              Card(
                                  color: Colors.green,
                                  child: SizedBox(
                                    height: 50,
                                    width: 150,
                                    child: quantity == 1
                                        ? TextButton(
                                            child: const Text(
                                              '1 Adet',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                quantity++;
                                              });
                                            },
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.remove),
                                                onPressed: () {
                                                  setState(() {
                                                    quantity--;
                                                  });
                                                },
                                              ),
                                              Text(quantity.toString()),
                                              IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () {
                                                  setState(() {
                                                    quantity++;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                  )),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green)),
                                  onPressed: () {
                                    setState(() {
                                      UserInput = _controller.text;
                                      Nesne yeniNesne = Nesne(UserInput);
                                      if (liste.isEmpty) {
                                        if (quantity == 0) {
                                          liste.add(yeniNesne);
                                        } else {
                                          yeniNesne.sayi += quantity;
                                          liste.add(yeniNesne);
                                        }
                                      } else {
                                        for (int i = 0; i < liste.length; i++) {
                                          if (liste[i].name == UserInput) {
                                            if (quantity == 0) {
                                              liste[i].sayi++;
                                            } else {
                                              liste[i].sayi += quantity;
                                            }

                                            Varmi = true;
                                          }
                                        }

                                        if (Varmi == false) {
                                          if (quantity == 0) {
                                            liste.add(yeniNesne);
                                          } else {
                                            yeniNesne.sayi += quantity;
                                            liste.add(yeniNesne);
                                          }
                                        }
                                      }
                                      Varmi = false;
                                    });
                                  },
                                  child: Text("Ekle")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: liste.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Center(child: Text(liste[index].name.toString())),
                        iconColor: Colors.green,
                        leading: Text(liste[index].sayi.toString(),style: TextStyle(fontSize: 15)),
                        trailing: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              liste.remove(liste[index]);
                            });
                          },
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return Divider(thickness: 3,
                      color: Colors.green,
                      height: 20,

                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
