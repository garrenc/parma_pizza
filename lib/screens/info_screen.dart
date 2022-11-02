import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parma_pizza/bloc/products_bloc.dart';
import 'package:parma_pizza/bloc/products_event.dart';
import 'package:parma_pizza/bloc/products_state.dart';
import 'package:parma_pizza/widgets/info_alert_box.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  static const routeName = '/info';

  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  ProductsBloc bloc = ProductsBloc();
  String warning = '';
  List<String> info = [];
  String minimum = '';

  @override
  void initState() {
    super.initState();
    bloc.add(InfoFetch());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer(
      bloc: bloc,
      listener: (ctx, state) {
        if (state is InfoLoaded) {
          info = state.info;
          warning = state.warning;
          minimum = state.minimum;
        }
      },
      builder: (ctx, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Информация'),
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: EdgeInsets.only(top: height / 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Image.asset('assets/images/logo.jpg'),
                    ),
                    SizedBox(
                      height: height / 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: Icon(
                            Icons.phone,
                            size: 33,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => launchUrl(Uri.parse('tel:2700612')),
                          child: const Text(
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
                      child: TextButton(
                        child: const Text(
                          'Условия Доставки',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (ctx) => InfoAlertBox(
                            minimum: minimum,
                            info: info,
                            warning: warning,
                            title: 'Условия Доставки',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
