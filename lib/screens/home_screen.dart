import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/order_platform.dart';
import 'package:bakingup_frontend/enum/order_type.dart';
import 'package:bakingup_frontend/models/home.dart';
import 'package:bakingup_frontend/screens/notification_screen.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/bottom_navbar.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_two_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_no_result.dart';
import 'package:bakingup_frontend/widgets/home/home_top_filter_bottom.dart';
import 'package:bakingup_frontend/widgets/home/home_top_filter_list.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _currentDrawerIndex = 0;
  bool isLoading = true;
  bool isLoadingDashboard = true;
  bool isLoadingNoti = true;
  bool isError = true;
  DashboardChartData chartData = DashboardChartData(
    costRevenue: [],
    netProfit: [],
    profitThreshold: [],
  );
  int unreadNotiAmount = 0;
  bool successResponse = false;

  List<TopProductItem> topProductList = [];
  String filterName = "Best Selling";

  Future<void> _fetchDashboardChartData() async {
    setState(() {
      isLoadingDashboard = true;
      isError = false;
    });
    try {
      final response = await NetworkService.instance
          .get('/api/home/getDashboardChartData?user_id=1');

      final chartDataResponse = DashboardChartResponse.fromJson(response);
      final data = chartDataResponse.data;
      setState(() {
        chartData = data;
      });
    } catch (e) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoadingDashboard = false;
      });
    }
  }

  Future<void> _fetchUnreadNotification() async {
    setState(() {
      isLoadingNoti = true;
      isError = false;
    });

    try {
      final response = await NetworkService.instance
          .get('/api/home/getUnreadNotification?user_id=1');
      final unreadNotiResponse = UnreadNotificationResponse.fromJson(response);
      final data = unreadNotiResponse.data;
      setState(() {
        unreadNotiAmount = data.unreadNotiAmount;
      });
    } catch (error) {
      isError = true;
    } finally {
      setState(() {
        isLoadingNoti = false;
      });
    }
  }

  Future<void> _fetchTopProducts() async {
    setState(() {
      isLoading = true;
      isError = false;
      topProductList = [];
      successResponse = false;
    });
    List<String> orderPlatform = ["STORE"];
    List<String> orderType = ["BULK_ORDER"];
    String userID = "1";
    try {
      final data = {
        "filter_type": filterName,
        "order_types": orderType,
        "sales_channel": orderPlatform,
        "user_id": userID
      };

      final response = await NetworkService.instance
          .post("/api/home/getTopProducts", data: data);

      final topProductListResponse = TopProductResponse.fromJson(response);

      final dataResponse = topProductListResponse.data;
      setState(() {
        topProductList = dataResponse.products;
        successResponse = true;
      });
    } catch (error) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _filterTopProducts(
    List<Map<String, dynamic>>? filterFirstOption,
    List<Map<String, dynamic>>? filterSecondOption,
    String? filterType,
    String? ingredientType,
    String? sortType,
  ) async {
    setState(() {
      isLoading = true;
      isError = false;
      topProductList = [];
      successResponse = false;
    });

    List<String> orderPlatform = [];
    List<String> orderType = [];
    String userID = "1";

    if (filterType != "Wasted Ingredients" &&
        filterType != "Wasted Bakery Stock") {
      for (var i = 0; i < filterFirstOption!.length; i++) {
        if (filterFirstOption[i]["isChecked"]) {
          orderPlatform
              .add(convertOrderPlatformString(filterFirstOption[i]["title"]));
        }
      }

      for (var i = 0; i < filterSecondOption!.length; i++) {
        if (filterSecondOption[i]["isChecked"]) {
          orderType.add(convertOrderTypeString(filterSecondOption[i]["title"]));
        }
      }
    }

    try {
      Map<String, dynamic> data = {};
      if (filterType != "Wasted Ingredients" &&
          filterType != "Wasted Bakery Stock") {
        data = {
          "filter_type": filterType,
          "order_types": orderType,
          "sales_channel": orderPlatform,
          "user_id": userID
        };
      } else if (filterType != "Wasted Ingredients") {
        data = {
          "filter_type": filterType,
          "sort_type": sortType,
          "user_id": userID
        };
      } else {
        data = {
          "filter_type": filterType,
          "unit_type": ingredientType,
          "sort_type": sortType,
          "user_id": userID
        };
      }

      final response = await NetworkService.instance
          .post("/api/home/getTopProducts", data: data);

      final topProductListResponse = TopProductResponse.fromJson(response);

      final dataResponse = topProductListResponse.data;
      setState(() {
        topProductList = dataResponse.products;
        filterName = filterType!;
        successResponse = true;
      });
    } catch (error) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchDashboardChartData();
    _fetchUnreadNotification();
    _fetchTopProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 35,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()));
                  },
                  child: Icon(
                    Icons.notifications,
                    color: blackColor,
                    size: 35,
                  ),
                ),
                if (unreadNotiAmount > 0)
                  if (isLoadingNoti)
                    Positioned(
                        right: 0,
                        child: Shimmer.fromColors(
                          baseColor: greyColor,
                          highlightColor: whiteColor,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: whiteColor,
                            ),
                          ),
                        ))
                  else
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: yellowColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          unreadNotiAmount.toString(),
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
      drawer: BakingUpDrawer(
        currentDrawerIndex: _currentDrawerIndex,
      ),
      bottomNavigationBar: const BottomNavbar(),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 20),
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  if (isLoadingDashboard)
                    Shimmer.fromColors(
                      baseColor: greyColor,
                      highlightColor: whiteColor,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.06),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                  else
                    PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPageIndex = index;
                        });
                      },
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 300,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SfCartesianChart(
                            title: ChartTitle(
                              text: "Cost & Revenue",
                              textStyle: TextStyle(
                                color: blackColor,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            primaryXAxis: CategoryAxis(
                              title: AxisTitle(
                                text: 'Months',
                                textStyle: TextStyle(
                                  color: blackColor,
                                  fontFamily: 'Inter',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: blackColor,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                              majorGridLines: const MajorGridLines(width: 0),
                            ),
                            primaryYAxis: const NumericAxis(),
                            legend: const Legend(isVisible: true),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <CartesianSeries<CostRevenueData, String>>[
                              ColumnSeries<CostRevenueData, String>(
                                dataSource: chartData.costRevenue,
                                xValueMapper: (CostRevenueData item, _) =>
                                    item.month.substring(0, 3),
                                yValueMapper: (CostRevenueData item, _) =>
                                    item.revenue,
                                name: "Revenue",
                                color: yellowColor,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: false),
                              ),
                              ColumnSeries<CostRevenueData, String>(
                                dataSource: chartData.costRevenue,
                                xValueMapper: (CostRevenueData item, _) =>
                                    item.month.substring(0, 3),
                                yValueMapper: (CostRevenueData item, _) =>
                                    item.cost,
                                name: "Costs",
                                color: redColor,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: false),
                              ),
                              ColumnSeries<CostRevenueData, String>(
                                dataSource: chartData.costRevenue,
                                xValueMapper: (CostRevenueData item, _) =>
                                    item.month.substring(0, 3),
                                yValueMapper: (CostRevenueData item, _) =>
                                    item.netProfit,
                                name: "Net Profit",
                                color: greenColor,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: false),
                              )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 300,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SfCartesianChart(
                            title: ChartTitle(
                              text: "Profit Threshold",
                              textStyle: TextStyle(
                                color: blackColor,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            primaryXAxis: CategoryAxis(
                              title: AxisTitle(
                                textStyle: TextStyle(
                                  color: blackColor,
                                  fontFamily: 'Inter',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ), // Title for X-axis
                              labelStyle: TextStyle(
                                color: blackColor,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                              majorGridLines: const MajorGridLines(
                                  width: 0), // Hides vertical grid lines
                            ),
                            primaryYAxis: const NumericAxis(),
                            // title: const ChartTitle(text: "Profit Chart"),
                            legend: const Legend(isVisible: true),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <CartesianSeries<ProfitThreshold, String>>[
                              BarSeries<ProfitThreshold, String>(
                                dataSource: chartData.profitThreshold,
                                xValueMapper: (ProfitThreshold item, _) =>
                                    item.name,
                                yValueMapper: (ProfitThreshold item, _) =>
                                    item.threshold,
                                name: "Profit%",
                                color: greenColor,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: false),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  Positioned(
                    left: -20,
                    top: MediaQuery.of(context).size.height * 0.17,
                    child: IconButton(
                      icon: const Icon(Icons.chevron_left, size: 40),
                      onPressed: () {
                        if (_currentPageIndex > 0) {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ),
                  Positioned(
                    right: -20,
                    top: MediaQuery.of(context).size.height * 0.17,
                    child: IconButton(
                      icon: const Icon(Icons.chevron_right, size: 40),
                      onPressed: () {
                        if (_currentPageIndex < 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  filterName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      backgroundColor: backgroundColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.70,
                            child: DraggableScrollableSheet(
                              initialChildSize: 1,
                              minChildSize: 1,
                              maxChildSize: 1,
                              builder: (context, scrollController) {
                                return HomeTopFilterBottom(
                                    filterFunction: _filterTopProducts);
                              },
                            ));
                      },
                    );
                  },
                  child: const BakingUpFilterTwoButton(),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (topProductList.isEmpty && successResponse)
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03),
                child: const BakingUpNoResult(
                  message: "No results found",
                ),
              )
            else
              HomeTopFilterList(
                  isLoading: isLoading, topProductList: topProductList),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
