import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  //   Product(
  //     id: 'p1',
  //     description:
  //         'половина пиццы: Грибное ассорти, перья зеленого лука, сыр Моцарелла; половина пиццы: свежие томаты с оливками и травами, сыр Моцарелла',
  //     price: 446,
  //     title: '2 вкуса грибы и овощи',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614175909.jpg',
  //   ),
  //   Product(
  //     id: 'p2',
  //     description:
  //         'Классическая пицца с томатами, итальянскими травами и дуэтом из сыров Моцарелла и Пармезан',
  //     price: 365,
  //     title: 'Маргарита',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614176492.jpg',
  //   ),
  //   Product(
  //     id: 'p3',
  //     description:
  //         'Пицца с баварскими колбасками,свежими томатами, кольцами красного лука, острым перцем и сыром Моцарелла.',
  //     title: 'Баварайская лайт',
  //     weight: 500,
  //     price: 391,
  //     imageUrl: 'http://parmapizza.ru/upload/1614181987.jpg',
  //   ),
  //   Product(
  //     id: 'p4',
  //     description:
  //         'Сервелат, шампиньоны, перец Халапеньо, томатный соус, сыр Моцарелла,итальянские травы',
  //     price: 635,
  //     title: 'Пеперони',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614176733.jpg',
  //   ),
  //   Product(
  //     id: 'p5',
  //     description:
  //         'Пицца на грибном соусе с ломтиками бекона, шампиньонами, перепелинным яйцом, репчатым луком, перьями зеленого лука и сыром Моцарелла',
  //     price: 635,
  //     title: 'Карбонара',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614177102.jpg',
  //   ),
  //   Product(
  //     id: 'p6',
  //     description:
  //         'Экзотическая пицца с запеченым куриным филе, ананасами, сладким перцем,оливками, соусом Чили и сыром Моцарелла',
  //     price: 635,
  //     title: 'Бразильская',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614177291.jpg',
  //   ),
  //   Product(
  //     id: 'p7',
  //     description:
  //         'Сливочная пицца с кавказским колоритом. Адыгейский сыр, Сулугуни, яйцо перепелиное, классическая Моцарелла и южные травы',
  //     price: 665,
  //     title: 'Кавказская',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614177394.jpg',
  //   ),
  //   Product(
  //     id: 'p8',
  //     description:
  //         'Пицца с картофельным пюре на сливках, ломтиками бекона, шампиньонами, луком пореем и сыром Моцарелла, сдобренная чесночным маслом и ароматными травами',
  //     price: 685,
  //     title: 'А-ля русс  "A la russе"',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614177191.jpg',
  //   ),
  //   Product(
  //     id: 'p9',
  //     description:
  //         'Пицца на грибном соусе с рубленой телятиной, ломтиками бекона, грибным ассорти, зелёным и репчатым луком, сыром Моцарелла и зеленью орегано',
  //     price: 715,
  //     title: 'Парма',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614177433.jpg',
  //   ),
  //   Product(
  //     id: 'p10',
  //     description:
  //         'Пицца для гурманов: филе лосося, креветки, мидии, кальмар, томаты , сочный шпинат, фирменный соус и сыр Моцарелла',
  //     price: 855,
  //     title: 'Средниземноморье',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614177241.jpg',
  //   ),
  //   Product(
  //     id: 'p11',
  //     description: '1. кальцоне "Лето" 350 гр \n'
  //         '2. кальцоне "Жульен с цыпленком" 350 гр',
  //     price: 625,
  //     title: 'Дуэт №1',
  //     weight: 700,
  //     imageUrl: 'http://parmapizza.ru/upload/1614181638.jpg',
  //   ),
  //   Product(
  //     id: 'p12',
  //     description: '1. Кальцоне картофельная с грибами и беконом 350 гр \n'
  //         '2. Кальцоне с ветчиной и грибами 350 гр',
  //     price: 625,
  //     title: 'Дуэт №2',
  //     weight: 700,
  //     imageUrl: 'http://parmapizza.ru/upload/1614181638.jpg',
  //   ),
  //   Product(
  //     id: 'p13',
  //     description:
  //         '1. кальцоне "Рыба моя" 350 гр \n' '2. кальцоне "Масленица" 350 гр',
  //     price: 815,
  //     title: 'Дуэт №3',
  //     weight: 700,
  //     imageUrl: 'http://parmapizza.ru/upload/1614181638.jpg',
  //   ),
  //   Product(
  //     id: 'p14',
  //     description: 'С творожным кремом и ананасом',
  //     price: 595,
  //     title: 'Кальцоне "Экзотик"',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614178366.jpg',
  //   ),
  //   Product(
  //     id: 'p15',
  //     description: 'Закрытая десертная пицца с творгожным кремом и персиком',
  //     price: 595,
  //     title: 'Кальцоне "Персик"',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614178366.jpg',
  //   ),
  //   Product(
  //     id: 'p16',
  //     description:
  //         'Адыгейский сыр, Сулугуни, Моцарелла, яйцо куриное, сдобрена сливочным маслом',
  //     price: 615,
  //     title: 'Кальцоне "Масленица"',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614178132.jpg',
  //   ),
  //   Product(
  //     id: 'p17',
  //     description:
  //         'Русская Классика: воздушное картофельное пюре на сливках с грибами, жареным луком и кусочками бекона и сыром Моцарелла',
  //     price: 615,
  //     title: 'Картофельная с грибами и беконом',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614178132.jpg',
  //   ),
  //   Product(
  //     id: 'p18',
  //     description: 'С творожным кремом и вишней',
  //     price: 615,
  //     title: 'Кальцоне "Зимняя вишня"',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614179027.jpg',
  //   ),
  //   Product(
  //     id: 'p19',
  //     description:
  //         'Филе цыпленка , шампиньоны, репчатый лук, сливочно-грибной соус, сыр Моцарелла.',
  //     price: 615,
  //     title: 'Кальцоне "Жульен" с цыпленком',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614179409.jpg',
  //   ),
  //   Product(
  //     id: 'p20',
  //     description:
  //         'Закрытая пицца с зеленым луком, яйцом, сыром Сулугуни и Адыгейским сыром.',
  //     price: 615,
  //     title: 'Кальцоне "Лето"',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614178132.jpg',
  //   ),
  //   Product(
  //     id: 'p21',
  //     description:
  //         'Закрытая пицца с филе лосося, брокколи, сливочным соусом, итальянскими травамии сыром Моцарелла',
  //     price: 765,
  //     title: 'Кальцоне "Рыба моя"',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614179312.jpg',
  //   ),
  //   Product(
  //     id: 'p22',
  //     description:
  //         'Закрытая пицца с ветчиной, беконом, грибами, двумя соусами: грибным и чесночным ,душистыми травами и сыром Моцарелла',
  //     price: 765,
  //     title: 'Кальцоне с ветчиной',
  //     weight: 500,
  //     imageUrl: 'http://parmapizza.ru/upload/1614178132.jpg',
  //   ),
  //   Product(
  //     id: 'p23',
  //     description: '',
  //     price: 185,
  //     title: 'Блины с мясом',
  //     weight: 200,
  //     imageUrl: 'http://parmapizza.ru/upload/1623412946.jpg',
  //   ),
  //   Product(
  //     id: 'p24',
  //     description: '',
  //     price: 195,
  //     title: 'Блины с курицей и грибами',
  //     weight: 200,
  //     imageUrl: 'http://parmapizza.ru/upload/1623412946.jpg',
  //   ),
  //   Product(
  //     id: 'p25',
  //     description: '',
  //     price: 220,
  //     title: 'Блины с лососем',
  //     weight: 200,
  //     imageUrl: 'http://parmapizza.ru/upload/1624990822.jpg',
  //   ),
  //   Product(
  //     id: 'p26',
  //     description: '',
  //     price: 120,
  //     title: 'Сырники',
  //     weight: 200,
  //     imageUrl: 'http://parmapizza.ru/upload/1614181550.png',
  //   ),
  //   Product(
  //     id: 'p27',
  //     description: 'Кура, лук, тесто пельменное',
  //     price: 160,
  //     title: 'Куринные пельмени',
  //     weight: 250,
  //     imageUrl: 'http://parmapizza.ru/upload/1624990446.jpg',
  //   ),
  //   Product(
  //     id: 'p28',
  //     description: 'Свинина, говядина, лук репчатый, тесто пельменное',
  //     price: 180,
  //     title: 'Домашние пельмени',
  //     weight: 250,
  //     imageUrl: 'http://parmapizza.ru/upload/1624990436.jpg',
  //   ),
  //   Product(
  //     id: 'p29',
  //     description: 'Картофель толченый, шампиньоны, тесто пельменное',
  //     price: 115,
  //     title: 'Картофель с грибами',
  //     weight: 250,
  //     imageUrl: 'http://parmapizza.ru/upload/1614180957.jpg',
  //   ),
  //   Product(
  //     id: 'p30',
  //     description: 'Тесто пельменное, фарш капустный, лук репчатый',
  //     price: 115,
  //     title: 'Капустные',
  //     weight: 250,
  //     imageUrl: 'http://parmapizza.ru/upload/1614180957.jpg',
  //   ),
  //   Product(
  //     id: 'p31',
  //     description: 'вишневая начинка, тесто пельменное',
  //     price: 150,
  //     title: 'Вишневые',
  //     weight: 250,
  //     imageUrl: 'http://parmapizza.ru/upload/1624990464.jpg',
  //   ),
  //   Product(
  //     id: 'p33',
  //     description: 'Свинина, говядина, лук репчатый, тесто пресное',
  //     price: 210,
  //     title: 'Посикунчики 6 шт',
  //     weight: 200,
  //     imageUrl: 'http://parmapizza.ru/upload/1623412901.jpg',
  //   ),
  //   Product(
  //     id: 'p34',
  //     description:
  //         'Сливки, моцарелла, голландский сыр, плавленый сыр, пармезан, итальянские травы',
  //     price: 155,
  //     title: 'Сырный суп',
  //     weight: 250,
  //     imageUrl: 'http://parmapizza.ru/upload/1623335247.jpg',
  //   ),
  //   Product(
  //     id: 'p35',
  //     description:
  //         'Мясной набор, соленые огурцы, оливки, томатное пюре, лимон, лук репчатый, майонез',
  //     price: 199,
  //     title: 'Солянка',
  //     weight: 350,
  //     imageUrl: 'http://parmapizza.ru/upload/1614181317.jpg',
  //   ),
  // ];
  // var _showFavoritesOnly = false;
  List<Product> _items = [];
  Future<void> fetchAndSetProducts() async {
    const url = 'https://parmapizza.ru/parmajson.php';
    final response = await http.get(Uri.parse(url));
    final extractedDataMap =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    final categoryData = extractedDataMap['site']['group'];
    final List<Product> loadedProducts = [];
    for (int i = 0; i < categoryData.length; i++) {
      if (i == 3 || i == 6) {
        loadedProducts.add(Product(
            weight: categoryData[i]['item']['grm'],
            id: categoryData[i]['item']['id'],
            title: categoryData[i]['item']['name'],
            description: categoryData[i]['item']['descr'] is String
                ? categoryData[i]['item']['descr'].toString()
                : '',
            price: int.parse(categoryData[i]['item']['price']),
            imageUrl: categoryData[i]['item']['image']));
      } else
        for (int j = 0; j < categoryData[i]['item'].length; j++) {
          loadedProducts.add(Product(
              weight: categoryData[i]['item'][j]['grm'],
              id: categoryData[i]['item'][j]['id'],
              title: categoryData[i]['item'][j]['name'],
              description: categoryData[i]['item'][j]['descr'] is String
                  ? categoryData[i]['item'][j]['descr'].toString()
                  : '',
              price: int.parse(categoryData[i]['item'][j]['price']),
              imageUrl: categoryData[i]['item'][j]['image']));
        }
    }
    // for (int i = 0; i < categoryData.length; i++) {
    //   extractedData = categoryData[i]['item'];
    //   for (int j = 0; j < extractedData.length; j++) {
    //     loadedProducts.add(Product(
    //         weight: extractedData[j]['grm'],
    //         id: extractedData[j]['id'],
    //         title: extractedData[j]['name'],
    //         description: extractedData[j]['descr'],
    //         price: int.parse(extractedData[j]['price']),
    //         imageUrl: extractedData[j]['image']));
    //   }
    // }

    _items = loadedProducts;
    print('products fetched');
    notifyListeners();

    // extractedData['site']['group'][0]['item'][0].forEach((key, prodData) {
    //   loadedProducts.add(Product(
    //       id: prodData['id'],
    //       title: prodData['name'],
    //       description: prodData['descr'],
    //       price: prodData['price'],
    //       imageUrl: prodData['image']));
    // });
  }

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
