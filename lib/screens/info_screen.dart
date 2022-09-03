import 'package:flutter/material.dart';
import 'package:parma_pizza/widgets/info_alert_box.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  static const routeName = '/info';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Информация'),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: height / 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Image.asset('assets/images/logo.jpg'),
                ),
                SizedBox(
                  height: height / 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Icon(
                        Icons.phone,
                        size: 33,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => launchUrl(Uri.parse('tel:2700612')),
                      child: Text(
                        '2-700-612',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 25,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: height / 5),
                  child: TextButton(child: Text('Условия Доставки' ,style: TextStyle(color: Colors.black),), onPressed: ()=>showDialog(context: context, builder: (ctx)=>
                      InfoAlertBox(
                    text:'-От 0 - до 5 км минимальная сумма заказа - 600 ₽\n'
                          '-От 5 - до 8 км минимальная сумма заказа - 700 ₽\n'
                          '-От 8 - до 10 км минимальная сумма заказа - 1000 ₽\n'
                          '-От 10 - до 15 км минимальная сумма заказа - 1500 ₽\n'
                          '-От 15 - 20 км доставка осуществляется платно 350₽ - при минимальной сумме заказа 2500₽. (На меньшую сумму доставка не осуществляется)\n'
                          '-От 20 км - доставка не осуществляется\n\n'
                            '*Обратите внимание, за заказ в на сумму свыше 6000₽ взымается предоплата 50% от стоимости заказа.\n',
                    title: 'Условия Доставки',
                  ),
                  ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
