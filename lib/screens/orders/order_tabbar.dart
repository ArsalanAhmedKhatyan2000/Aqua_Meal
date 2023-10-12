import 'package:aqua_meal/helper/preferences.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/providers/order_details_provider.dart';
import 'package:aqua_meal/providers/orders_provider.dart';
import 'package:aqua_meal/screens/orders/completed_orders_list.dart';
import 'package:aqua_meal/screens/orders/pending_orders_list.dart';
import 'package:aqua_meal/widgets/build_custom_circular_image_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersTabBar extends StatefulWidget {
  static const String routeName = "/OrdersTabBar";
  const OrdersTabBar({Key? key}) : super(key: key);

  @override
  State<OrdersTabBar> createState() => _OrdersTabBarState();
}

class _OrdersTabBarState extends State<OrdersTabBar>
    with SingleTickerProviderStateMixin {
  final List<Widget> _tabBarViews = const [
    PendingOrders(),
    CompletedOrders(),
  ];
  TabController? _tabController;
  int tabBarIndex = 0;
  bool isLoading = false;
  @override
  void initState() {
    loadOrdersData();
    _tabController = TabController(
      length: _tabBarViews.length,
      vsync: this,
    );
    _tabController!.addListener(_handleTabSelection);
    super.initState();
  }

  loadOrdersData() async {
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    final orderDetailsProvider =
        Provider.of<OrderDetailsProvider>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    final String? token = await SharedPreferencesHelper().getAuthToken();

    if (token != null && token.isNotEmpty) {
      await ordersProvider.fetchOrders();
      await orderDetailsProvider.fetchOrdersDetails();
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      tabBarIndex = _tabController!.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "My Orders",
            style: TextStyle(fontSize: getProportionateScreenWidth(20)),
          ),
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            controller: _tabController,
            tabs: [
              _tabBarOptionWidget(
                  icon: tabBarIndex == 0
                      ? Icons.access_time_filled_rounded
                      : Icons.access_time_rounded,
                  label: "Pending Orders"),
              _tabBarOptionWidget(
                  icon: tabBarIndex == 1
                      ? Icons.check_circle_rounded
                      : Icons.check_circle_outline_rounded,
                  label: "Orders History"),
            ],
            onTap: (newTabIndex) {
              setState(() {
                tabBarIndex = newTabIndex;
              });
            },
          ),
        ),
        body: isLoading == true
            ? const LoadingIcon()
            : TabBarView(
                controller: _tabController,
                children: _tabBarViews,
              ),
      ),
    );
  }

  Widget _tabBarOptionWidget(
      {required IconData? icon, required String? label}) {
    return Column(
      children: [
        Icon(icon),
        Text(
          label!,
          style: TextStyle(fontSize: getProportionateScreenWidth(15)),
        ),
        SizedBox(height: getProportionateScreenHeight(5)),
      ],
    );
  }
}
