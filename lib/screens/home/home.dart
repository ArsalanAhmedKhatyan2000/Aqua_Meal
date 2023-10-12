import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/models/categories.dart';
import 'package:aqua_meal/models/products.dart';
import 'package:aqua_meal/providers/category_provider.dart';
import 'package:aqua_meal/providers/product_provider.dart';
import 'package:aqua_meal/screens/home/components/cart_badge.dart';
import 'package:aqua_meal/screens/home/components/category_tile.dart';
import 'package:aqua_meal/screens/home/components/category_view_all.dart';
import 'package:aqua_meal/screens/home/components/search_box.dart';
import 'package:aqua_meal/widgets/custom_page_route.dart';
import 'package:aqua_meal/widgets/product_card.dart';
import 'package:aqua_meal/widgets/view_all_with_label_strip.dart';
import 'package:aqua_meal/screens/view%20all/view_all.dart';
import 'package:aqua_meal/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static const String routeName = "/Home";
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double appBarHeight = 65 + AppBar().preferredSize.height;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
    List<ProductModel> topRatedProducts = productProviders.getTopRatedProducts;
    final categoryProvider = Provider.of<CategoryProvider>(context);
    List<CategoryModel> allCategories = categoryProvider.getCategories;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(SizeConfig.screenWidth,
              getProportionateScreenHeight(appBarHeight)),
          child: Container(
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(getProportionateScreenWidth(60)),
                bottomRight: Radius.circular(getProportionateScreenWidth(60)),
              ),
            ),
            child: Column(
              children: [
                AppBar(
                  title: Text(
                    "Home",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                    ),
                  ),
                  bottomOpacity: 0,
                  elevation: 0.0,
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: getProportionateScreenWidth(10)),
                      child: const CartBadge(),
                    ),
                  ],
                ),
                const HomeScreenSearchWidget(),
              ],
            ),
          ),
        ),
        drawer: const MyDrawer(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ViewAllWithLabelStrip(
                label: "Categories",
                onTapViewAll: () {
                  Navigator.of(
                    context,
                  ).pushNamed(CategoryViewAll.routeName);
                },
              ),
              SizedBox(
                height: getProportionateScreenHeight(50),
                width: SizeConfig.screenWidth,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemExtent: getProportionateScreenWidth(140),
                  itemCount: allCategories.length,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(10)),
                  itemBuilder: (context, index) => ChangeNotifierProvider.value(
                    value: allCategories[index],
                    child: const CategoryTile(),
                  ),
                ),
              ),
              ViewAllWithLabelStrip(
                label: "On Sales",
                onTapViewAll: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(CustomPageRoute(
                          direction: AxisDirection.right,
                          child: const ViewAll(
                            screenView: "onSales",
                            appBarTitle: "On Sales Products",
                          )));
                },
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.305,
                width: SizeConfig.screenWidth,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      productsOnSale.length < 5 ? productsOnSale.length : 5,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(10)),
                  itemExtent: getProportionateScreenWidth(170),
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: productsOnSale[index],
                      child: const ProductCard(),
                    );
                  },
                ),
              ),
              ViewAllWithLabelStrip(
                label: "Top Rated",
                onTapViewAll: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(CustomPageRoute(
                          direction: AxisDirection.right,
                          child: const ViewAll(
                            screenView: "topRated",
                            appBarTitle: "Top Rated Products",
                          )));
                },
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.305,
                width: SizeConfig.screenWidth,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      topRatedProducts.length < 5 ? topRatedProducts.length : 5,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(10)),
                  itemExtent: getProportionateScreenWidth(170),
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: topRatedProducts[index],
                      child: const ProductCard(),
                    );
                  },
                ),
              ),
              ViewAllWithLabelStrip(
                label: "All Products",
                onTapViewAll: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(CustomPageRoute(
                          direction: AxisDirection.right,
                          child: const ViewAll(
                            screenView: "allProducts",
                            appBarTitle: "All Products",
                          )));
                },
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              GridView.builder(
                shrinkWrap: true,
                itemCount: allProducts.length < 6 ? allProducts.length : 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: SizeConfig.screenHeight * 0.305,
                  mainAxisSpacing: getProportionateScreenHeight(5),
                  crossAxisSpacing: getProportionateScreenHeight(5),
                ),
                padding: EdgeInsets.fromLTRB(
                  getProportionateScreenWidth(10),
                  0,
                  getProportionateScreenWidth(10),
                  getProportionateScreenHeight(10),
                ),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: allProducts[index],
                    child: const ProductCard(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
