import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/expiration_status.dart';
import 'package:bakingup_frontend/models/stock.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_add_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_two_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_search_bar.dart';
import 'package:bakingup_frontend/widgets/stock/stock_box.dart';
import 'package:flutter/material.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final int _currentDrawerIndex = 9;
  bool isLoading = false;
  bool isError = false;
  List<StockItemData> stocks = [];
  List<StockItem> stockList = [
    StockItem(
        imgUrl:
            'https://divascancook.com/wp-content/uploads/2023/12/butter-cookies.jpg',
        name: 'Butter Cookies',
        quantity: 30,
        lst: 3,
        sellingPrice: 50,
        expirationStatus: ExpirationStatus.green),
    StockItem(
        imgUrl: 'https://bakerjo.co.uk/wp-content/uploads/2022/08/IMG_3525.jpg',
        name: 'Carrot Cake',
        quantity: 5,
        lst: 3,
        sellingPrice: 195,
        expirationStatus: ExpirationStatus.yellow),
    StockItem(
        imgUrl:
            'https://www.inspiredtaste.net/wp-content/uploads/2024/01/Brownies-Recipe-Video.jpg',
        name: 'Chocolate Brownie',
        quantity: 2,
        lst: 3,
        sellingPrice: 150,
        expirationStatus: ExpirationStatus.red),
    StockItem(
        imgUrl:
            'https://www.twopeasandtheirpod.com/wp-content/uploads/2018/04/Strawberry-Shortcake-5.jpg',
        name: 'Strawberry Shortcake',
        quantity: 0,
        lst: 3,
        sellingPrice: 190,
        expirationStatus: ExpirationStatus.black)
  ];

  @override
  void initState() {
    super.initState();
    _fetchStockList();
  }

  Future<void> _fetchStockList() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await NetworkService.instance
          .get('/api/stock/getAllStocks?user_id=1');

      final stockResponse = StockListResponse.fromJson(response);
      final data = stockResponse.data;
      setState(() {
        stocks = data.stocks;
      });
    } catch (e) {
      isError = true;
    } finally {
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0,
        title: const Text(
          "Bakery Stock",
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 14.0),
            child: BakingUpCircularAddButton(),
          )
        ],
      ),
      drawer: BakingUpDrawer(
        currentDrawerIndex: _currentDrawerIndex,
      ),
      body: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 15),
                child: Row(
                  children: [
                    BakingUpSearchBar(
                      hintText: 'Search Bakery Stock',
                    ),
                    SizedBox(width: 12),
                    BakingUpFilterTwoButton()
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                itemCount: stocks.length,
                itemBuilder: (context, index) {
                  return StockBox(stockList: stocks, index: index);
                },
              ))
            ],
          )),
    );
  }
}

class StockItem {
  final String imgUrl;
  final String name;
  final int quantity;
  final int lst;
  final double sellingPrice;
  final ExpirationStatus expirationStatus;

  StockItem(
      {required this.imgUrl,
      required this.name,
      required this.quantity,
      required this.lst,
      required this.sellingPrice,
      required this.expirationStatus});
}
