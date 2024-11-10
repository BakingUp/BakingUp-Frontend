import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/order_status.dart';
import 'package:bakingup_frontend/models/order.dart';
import 'package:bakingup_frontend/screens/add_edit_instore_order_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_preorder_order_screen.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/utilities/bottom_navbar.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:bakingup_frontend/widgets/baking_up_circular_add_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_modal_bottom.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_two_button.dart';
import 'package:bakingup_frontend/widgets/baking_up_no_result.dart';
import 'package:bakingup_frontend/widgets/baking_up_search_bar.dart';
import 'package:bakingup_frontend/widgets/baking_up_tab_button.dart';
import 'package:bakingup_frontend/widgets/order/order_info_list.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final int _currentDrawerIndex = 3;

  int tabIndex = 1;
  bool isLoading = true;
  bool isError = true;
  List<OrderInfo> orders = [];
  List<OrderInfo> inStoreOrders = [];
  List<OrderInfo> preOrderOrders = [];
  List<OrderInfo> filteredOrders = [];
  List<OrderInfo> filteredInStoreOrders = [];
  List<OrderInfo> filteredPreOrderOrders = [];
  final TextEditingController _searchOrderController = TextEditingController();
  final TextEditingController _searchInStoreOrderController =
      TextEditingController();
  final TextEditingController _searchPreOrderOrderController =
      TextEditingController();

  final List<String> orderFilterList = ['Done', 'In-Process', 'Cancel'];
  String selectedOrderFiltering = 'In-Process';
  String selectedOrderSorting = "Descending Order";

  FocusNode orderSearchFocusNode = FocusNode();
  FocusNode inStoreOrderSearchFocusNode = FocusNode();
  FocusNode preOrderOrderSearchFocusNode = FocusNode();

  bool noResult = false;

  String userID = "1";
  // FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _fetchAllList();
    // getUserId();
  }

  // void getUserId(){
  //   setState(() {
  //     userID = auth.currentUser!.uid;
  //   });
  // }

  Future<void> _fetchAllList() async {
    setState(() {
      isLoading = true;
      isError = false;
      _searchOrderController.clear();
      noResult = false;
    });

    try {
      final response = await NetworkService.instance
          .get('/api/order/getAllOrders/?user_id=$userID');

      final ordersResponse = OrdersResponse.fromJson(response);
      final data = ordersResponse.data;

      setState(() {
        orders = data.orders;
        preOrderOrders = [];
        inStoreOrders = [];
        selectedOrderFiltering = 'In-Process';
        selectedOrderSorting = 'Descending Order';
        if (ordersResponse.status == 200 && orders.isEmpty) {
          noResult = true;
        }

        for (var order in orders) {
          if (order.isPreOrder) {
            preOrderOrders.add(order);
          } else {
            inStoreOrders.add(order);
          }
        }
        orders.sort((a, b) => b.orderIndex.compareTo(a.orderIndex));
        preOrderOrders.sort((a, b) => b.orderIndex.compareTo(a.orderIndex));
        inStoreOrders.sort((a, b) => b.orderIndex.compareTo(a.orderIndex));

        filteredOrders = orders;
        filteredPreOrderOrders = preOrderOrders;
        filteredInStoreOrders = inStoreOrders;
      });
    } catch (e) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _searchOrders(String query) {
    setState(() {
      if (query == "") {
        filteredOrders = orders;
        filteredPreOrderOrders = preOrderOrders;
        filteredInStoreOrders = inStoreOrders;
      } else {
        filteredOrders = orders
            .where((order) => order.orderIndex
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
        filteredInStoreOrders = inStoreOrders
            .where((order) => order.orderIndex
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
        filteredPreOrderOrders = preOrderOrders
            .where((order) => order.orderIndex
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _filterAllOrder(
    String selectingOrderFiltering,
    String selectingOrderSorting,
  ) {
    setState(() {
      selectedOrderFiltering = selectingOrderFiltering;
      selectedOrderSorting = selectingOrderSorting;
    });

    List<OrderInfo> filteredList = orders.where((order) {
      switch (selectingOrderFiltering) {
        case "Done":
          return order.orderStatus == OrderStatus.done;
        case "In-Process":
          return order.orderStatus == OrderStatus.inProcess;
        case "Cancel":
          return order.orderStatus == OrderStatus.cancel;
        default:
          return true;
      }
    }).toList();

    if (selectingOrderSorting == "Ascending Order") {
      filteredList.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
    } else {
      filteredList.sort((a, b) => b.orderIndex.compareTo(a.orderIndex));
    }

    setState(() {
      filteredOrders = filteredList;
    });
  }

  void _filterInstoreOrder(
    String selectingOrderFiltering,
    String selectingOrderSorting,
  ) {
    setState(() {
      selectedOrderFiltering = selectingOrderFiltering;
      selectedOrderSorting = selectingOrderSorting;
    });

    List<OrderInfo> filteredList = inStoreOrders.where((order) {
      switch (selectingOrderFiltering) {
        case "Done":
          return order.orderStatus == OrderStatus.done;
        case "In-Process":
          return order.orderStatus == OrderStatus.inProcess;
        case "Cancel":
          return order.orderStatus == OrderStatus.cancel;
        default:
          return true;
      }
    }).toList();

    if (selectingOrderSorting == "Ascending Order") {
      filteredList.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
    } else {
      filteredList.sort((a, b) => b.orderIndex.compareTo(a.orderIndex));
    }

    setState(() {
      filteredInStoreOrders = filteredList;
    });
  }

  void _filterPreorderOrder(
    String selectingOrderFiltering,
    String selectingOrderSorting,
  ) {
    setState(() {
      selectedOrderFiltering = selectingOrderFiltering;
      selectedOrderSorting = selectingOrderSorting;
    });

    List<OrderInfo> filteredList = preOrderOrders.where((order) {
      switch (selectingOrderFiltering) {
        case "Done":
          return order.orderStatus == OrderStatus.done;
        case "In-Process":
          return order.orderStatus == OrderStatus.inProcess;
        case "Cancel":
          return order.orderStatus == OrderStatus.cancel;
        default:
          return true;
      }
    }).toList();

    if (selectingOrderSorting == "Ascending Order") {
      filteredList.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
    } else {
      filteredList.sort((a, b) => b.orderIndex.compareTo(a.orderIndex));
    }

    setState(() {
      filteredPreOrderOrders = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        orderSearchFocusNode.unfocus();
        inStoreOrderSearchFocusNode.unfocus();
        preOrderOrderSearchFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          scrolledUnderElevation: 0,
          title: const Center(
            child: Text(
              'Orders',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
          ),
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: BakingUpCircularAddButton(
                onPressed: () {
                  if (tabIndex == 1 || tabIndex == 2) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AddEditInstoreOrderScreen())).then((_) {
                      _fetchAllList();
                    });
                  } else if (tabIndex == 3) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AddEditPreorderOrderScreen())).then((_) {
                      _fetchAllList();
                    });
                  }
                },
              ),
            )
          ],
        ),
        drawer: BakingUpDrawer(currentDrawerIndex: _currentDrawerIndex),
        bottomNavigationBar: const BottomNavbar(),
        body: Container(
          margin: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: Row(
                  children: [
                    BakingUpTabButton(
                        text: "All",
                        isSelected: tabIndex == 1,
                        onClick: () {
                          setState(() {
                            tabIndex = 1;
                            _fetchAllList();
                            inStoreOrderSearchFocusNode.unfocus();
                            preOrderOrderSearchFocusNode.unfocus();
                          });
                        }),
                    const SizedBox(
                      width: 15,
                    ),
                    BakingUpTabButton(
                        text: "In-store",
                        isSelected: tabIndex == 2,
                        onClick: () {
                          setState(() {
                            tabIndex = 2;
                            _fetchAllList();
                            orderSearchFocusNode.unfocus();
                            preOrderOrderSearchFocusNode.unfocus();
                          });
                        }),
                    const SizedBox(
                      width: 15,
                    ),
                    BakingUpTabButton(
                        text: "Pre-order",
                        isSelected: tabIndex == 3,
                        onClick: () {
                          setState(() {
                            tabIndex = 3;
                            _fetchAllList();
                            orderSearchFocusNode.unfocus();
                            inStoreOrderSearchFocusNode.unfocus();
                          });
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                child: Row(
                  children: [
                    if (tabIndex == 1)
                      BakingUpSearchBar(
                        hintText: 'Search Order',
                        controller: _searchOrderController,
                        onChanged: _searchOrders,
                        focusNode: orderSearchFocusNode,
                      ),
                    if (tabIndex == 2)
                      BakingUpSearchBar(
                        hintText: 'Search Order',
                        controller: _searchInStoreOrderController,
                        onChanged: _searchOrders,
                        focusNode: inStoreOrderSearchFocusNode,
                      ),
                    if (tabIndex == 3)
                      BakingUpSearchBar(
                        hintText: 'Search Order',
                        controller: _searchPreOrderOrderController,
                        onChanged: _searchOrders,
                        focusNode: preOrderOrderSearchFocusNode,
                      ),
                    const SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        orderSearchFocusNode.unfocus();
                        inStoreOrderSearchFocusNode.unfocus();
                        preOrderOrderSearchFocusNode.unfocus();
                        showModalBottomSheet<void>(
                            context: context,
                            backgroundColor: backgroundColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return tabIndex == 1
                                  ? BakingUpFilterModalBottom(
                                      optionsOne: orderFilterList,
                                      optionOneName: "Filter by",
                                      defaultFilteringValue:
                                          selectedOrderFiltering,
                                      defaultSortingValue: selectedOrderSorting,
                                      filterFunction: _filterAllOrder,
                                    )
                                  : tabIndex == 2
                                      ? BakingUpFilterModalBottom(
                                          optionsOne: orderFilterList,
                                          optionOneName: "Filter by",
                                          defaultFilteringValue:
                                              selectedOrderFiltering,
                                          defaultSortingValue:
                                              selectedOrderSorting,
                                          filterFunction: _filterInstoreOrder,
                                        )
                                      : BakingUpFilterModalBottom(
                                          optionsOne: orderFilterList,
                                          optionOneName: "Filter by",
                                          defaultFilteringValue:
                                              selectedOrderFiltering,
                                          defaultSortingValue:
                                              selectedOrderSorting,
                                          filterFunction: _filterPreorderOrder,
                                        );
                            });
                      },
                      child: const BakingUpFilterTwoButton(),
                    )
                  ],
                ),
              ),
              //All order
              if (tabIndex == 1 && noResult)
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: const BakingUpNoResult(
                    message: "You currently have no order",
                  ),
                )
              else if (tabIndex == 1 &&
                  !noResult &&
                  filteredOrders.isEmpty &&
                  !isLoading)
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: const BakingUpNoResult(
                    message: "No results found",
                  ),
                )
              else if (tabIndex == 1 && !noResult && filteredOrders.isNotEmpty)
                // have result + have filter result
                OrderInfoList(
                  orderList: filteredOrders,
                  isLoading: isLoading,
                  isPreOrder: true,
                  fetchOrderList: _fetchAllList,
                ),
              if (tabIndex == 2 && noResult)
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: const BakingUpNoResult(
                    message: "You currently have no In-store order",
                  ),
                )
              else if (tabIndex == 2 &&
                  !noResult &&
                  !isLoading &&
                  filteredInStoreOrders.isEmpty)
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: const BakingUpNoResult(
                    message: "No results found",
                  ),
                )
              else if (tabIndex == 2 &&
                  !noResult &&
                  filteredInStoreOrders.isNotEmpty)
                OrderInfoList(
                  orderList: filteredInStoreOrders,
                  isLoading: isLoading,
                  isPreOrder: false,
                  fetchOrderList: _fetchAllList,
                ),

              if (tabIndex == 3 && noResult)
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: const BakingUpNoResult(
                    message: "You currently have no pre-order order",
                  ),
                )
              else if (tabIndex == 3 &&
                  !noResult &&
                  !isLoading &&
                  filteredPreOrderOrders.isEmpty)
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: const BakingUpNoResult(
                    message: "No results found",
                  ),
                )
              else if (tabIndex == 3 &&
                  !noResult &&
                  filteredPreOrderOrders.isNotEmpty)
                // Pre-order
                OrderInfoList(
                  orderList: filteredPreOrderOrders,
                  isLoading: isLoading,
                  isPreOrder: true,
                  fetchOrderList: _fetchAllList,
                )
            ],
          ),
        ),
      ),
    );
  }
}
