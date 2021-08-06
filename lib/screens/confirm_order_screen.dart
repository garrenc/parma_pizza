import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/tabs_screen.dart';
import '../providers/cart.dart';

class ConfirmOrderScreen extends StatefulWidget {
  static const routeName = '/confirmorder';

  @override
  _ConfirmOrderScreenState createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  final _form = GlobalKey<FormState>();

  String _name;

  String _phoneNumber;

  String _street;

  String _house;

  String _apartment;

  var _deliveryOptions = ['Самовывоз', 'Доставка домой'];

  var _paymentOptions = ['Наличными', 'Картой курьеру'];

  TimeOfDay picked;

  String payment;
  String delivery;

  Future<Null> selectTime(BuildContext context) async {
    picked = await showTimePicker(
      helpText: 'Выберите время',
      context: context,
      initialTime: TimeOfDay.now(),
    );
    print(MaterialLocalizations.of(context)
        .formatTimeOfDay(picked, alwaysUse24HourFormat: true));
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Подтверждение заказа'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Имя'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _name = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Введите имя!';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Телефон'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  _phoneNumber = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Введите номер телефона!';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Улица'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _street = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Введите улицу!';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Дом'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _house = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Введите номер дома!';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Квартира'),
                onSaved: (value) {
                  _apartment = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Введите номер квартиры!';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: DropdownButtonFormField(
                  isExpanded: true,
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  hint: Text('Способ доставки'),
                  value: delivery,
                  onChanged: (newValue) {
                    setState(() {
                      delivery = newValue;
                    });
                  },
                  items: _deliveryOptions.map((valueItem) {
                    return DropdownMenuItem(
                      child: Text(valueItem),
                      value: valueItem,
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Укажите способ оплаты!';
                    }
                    return null;
                  },
                ),
              ),
              DropdownButtonFormField(
                isExpanded: true,
                style: TextStyle(color: Colors.black, fontSize: 17),
                hint: Text('Способ оплаты'),
                value: payment,
                onChanged: (newValue) {
                  setState(() {
                    payment = newValue;
                  });
                },
                items: _paymentOptions.map((valueItem) {
                  return DropdownMenuItem(
                    child: Text(valueItem),
                    value: valueItem,
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Укажите способ оплаты!';
                  }
                  return null;
                },
              ),
              TextButton(
                  onPressed: () => selectTime(context),
                  child: Text(
                      'Выбрать время ${delivery != null && delivery == 'Самовывоз' ? 'самовывоза' : 'доставки'}')),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.orange)))),
                      onPressed: () {
                        final isValid = _form.currentState.validate();
                        if (!isValid) {
                          return;
                        }
                        _form.currentState.save();
                        String items = '';
                        for (int i = 0; i < cart.items.length; i++) {
                          items += cart.items.values.toList()[i].productId +
                              '-' +
                              cart.items.values
                                  .toList()[i]
                                  .quantity
                                  .toString() +
                              ',';
                        }

                        cart.sendOrder(
                            Platform.isIOS ? "0" : "1",
                            items,
                            _name,
                            _street,
                            _house,
                            _apartment,
                            _phoneNumber,
                            delivery,
                            MaterialLocalizations.of(context)
                                .formatTimeOfDay(picked,
                                    alwaysUse24HourFormat: true)
                                .toString(),
                            payment);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Ваш заказ успешно отправлен',
                            ),
                            duration: Duration(seconds: 5),
                          ),
                        );
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TabsScreen(0)),
                          (Route<dynamic> route) => false,
                        );
                        cart.clear();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Оформить за ${cart.totalAmount.toStringAsFixed(0)} ₽',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Comic Sans',
                              color: Colors.white),
                        ),
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
}
