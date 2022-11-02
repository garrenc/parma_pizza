import 'dart:io';

import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';

import '../screens/tabs_screen.dart';
import '../providers/cart.dart';

class ConfirmOrderScreen extends StatefulWidget {
  static const routeName = '/confirmorder';

  const ConfirmOrderScreen({super.key});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  final _form = GlobalKey<FormState>();

  String _name = '';

  String _phoneNumber = '';

  String _street = '';

  String _house = '';

  String _apartment = '';

  final _deliveryOptions = ['Самовывоз', 'Доставка домой'];

  final _paymentOptions = ['Наличными', 'Картой'];

  void _launchMap() async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(57.99795604365832, 56.24277818818254),
      title: "Парма пицца",
      description: 'Кубышева 67',
    );
  }

  String? payment;
  String? delivery;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Подтверждение заказа'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Имя'),
                textInputAction: TextInputAction.next,
                onSaved: (String? value) {
                  _name = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите имя!';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Телефон'),
                textInputAction: delivery == 'Самовывоз' ? TextInputAction.done : TextInputAction.next,
                keyboardType: TextInputType.phone,
                onSaved: (String? value) {
                  _phoneNumber = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите номер телефона!';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Улица'),
                textInputAction: TextInputAction.next,
                onSaved: (String? value) {
                  _street = value!;
                },
                validator: delivery == 'Самовывоз'
                    ? null
                    : (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите улицу!';
                        }
                        return null;
                      },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Дом'),
                textInputAction: TextInputAction.next,
                onSaved: (String? value) {
                  _house = value!;
                },
                validator: delivery == 'Самовывоз'
                    ? null
                    : (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите номер дома!';
                        }
                        return null;
                      },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Квартира'),
                onSaved: (String? value) {
                  _apartment = value!;
                },
                validator: delivery == 'Самовывоз'
                    ? null
                    : (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите номер квартиры!';
                        }
                        return null;
                      },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: DropdownButtonFormField(
                  isExpanded: true,
                  style: const TextStyle(color: Colors.black, fontSize: 17),
                  hint: const Text('Способ доставки'),
                  value: delivery,
                  onChanged: (String? newValue) {
                    setState(() {
                      delivery = newValue!;
                    });
                  },
                  items: _deliveryOptions.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Укажите способ доставки!';
                    }
                    return null;
                  },
                ),
              ),
              DropdownButtonFormField(
                isExpanded: true,
                style: const TextStyle(color: Colors.black, fontSize: 17),
                hint: const Text('Способ оплаты'),
                value: payment,
                onChanged: (String? newValue) {
                  setState(() {
                    payment = newValue!;
                  });
                },
                items: _paymentOptions.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Укажите способ оплаты!';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: const BorderSide(color: Colors.orange)))),
                    onPressed: () {
                      final isValid = _form.currentState!.validate();
                      if (!isValid) {
                        return;
                      }
                      _form.currentState!.save();
                      String items = "";
                      for (int i = 0; i < cart.items.length; i++) {
                        items += '${cart.items.values.toList()[i].productId}-${cart.items.values.toList()[i].quantity},';
                      }

                      cart.sendOrder(Platform.isIOS ? "0" : "1", items, _name, _street, _house, _apartment, _phoneNumber, delivery!, payment!);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Ваш заказ успешно отправлен',
                          ),
                          duration: Duration(seconds: 5),
                        ),
                      );
                      if (delivery == 'Доставка домой') {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const TabsScreen(0)),
                          (Route<dynamic> route) => false,
                        );
                      }

                      if (delivery == 'Самовывоз') {
                        showAlertDialog(context);
                      }
                      cart.clear();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Оформить за ${cart.totalAmount.toStringAsFixed(0)} ₽',
                        style: const TextStyle(fontSize: 18, fontFamily: 'Comic Sans', color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Отменить"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const TabsScreen(0)),
          (Route<dynamic> route) => false,
        );
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Открыть"),
      onPressed: () {
        _launchMap();
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const TabsScreen(0)),
          (Route<dynamic> route) => false,
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Проложить маршрут"),
      content: const Text(
        "Хотите открыть карты для проложения маршрута?",
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
