import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/models/products.dart';
import 'package:aqua_meal/providers/product_provider.dart';
import 'package:aqua_meal/widgets/product_card.dart';
import 'package:aqua_meal/widgets/build_empty_screen.dart';
import 'package:aqua_meal/widgets/build_search_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAll extends StatefulWidget {
  final String? _screenView;
  final bool _isFromHomeSearch;
  static const String routeName = "/ViewAll";
  final String? _appBarTitle;
  const ViewAll({
    Key? key,
    required String? screenView,
    required String? appBarTitle,
    bool isFromHomeSearch = false,
  })  : _screenView = screenView,
        _appBarTitle = appBarTitle,
        _isFromHomeSearch = isFromHomeSearch,
        super(key: key);

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  List<ProductModel> listProdcutSearch = [];
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void initState() {
    if (widget._isFromHomeSearch == true) {
      _searchTextFocusNode.requestFocus();
    }
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = 65 + AppBar().preferredSize.height;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
    List<ProductModel> topRatedProducts = productProviders.getTopRatedProducts;
    List<ProductModel> productsByCategory =
        productProviders.findProdByCategory(widget._screenView!);
    SizeConfig().init(context);
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
                    _searchTextController.text.isNotEmpty
                        ? "${widget._appBarTitle!.capitalize()} (${listProdcutSearch.length})"
                        : widget._screenView == "onSales"
                            ? "${widget._appBarTitle!.capitalize()} (${productsOnSale.length})"
                            : widget._screenView == "topRated"
                                ? "${widget._appBarTitle!.capitalize()} (${topRatedProducts.length})"
                                : widget._screenView == "allProducts"
                                    ? "${widget._appBarTitle!.capitalize()} (${allProducts.length})"
                                    : "${widget._appBarTitle!.capitalize()} (${productsByCategory.length})",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                    ),
                  ),
                  bottomOpacity: 0,
                  elevation: 0.0,
                ),
                BuildSearchField(
                  focusNode: _searchTextFocusNode,
                  controller: _searchTextController,
                  iconOnTap: () {
                    _searchTextFocusNode.unfocus();
                  },
                  onChanged: (value) {
                    if (widget._screenView == "onSales") {
                      setState(() {
                        listProdcutSearch = productProviders.searchQuery(
                            value.trim(), productsOnSale);
                      });
                    } else if (widget._screenView == "topRated") {
                      setState(() {
                        listProdcutSearch = productProviders.searchQuery(
                            value.trim(), topRatedProducts);
                      });
                    } else if (widget._screenView == "allProducts") {
                      setState(() {
                        listProdcutSearch = productProviders.searchQuery(
                            value.trim(), allProducts);
                      });
                    } else {
                      setState(() {
                        listProdcutSearch = productProviders.searchQuery(
                            value.trim(), productsByCategory);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        body:
            (_searchTextController.text.isNotEmpty && listProdcutSearch.isEmpty)
                ? const EmptyScreen(
                    svgImagePath: "assets/images/emptyProductBox.svg",
                    title: "Oops! No Product Found",
                    description: "Sorry, there are no products with this name.",
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    itemCount: _searchTextController.text.isNotEmpty
                        ? listProdcutSearch.length
                        : widget._screenView == "onSales"
                            ? productsOnSale.length
                            : widget._screenView == "topRated"
                                ? topRatedProducts.length
                                : widget._screenView == "allProducts"
                                    ? allProducts.length
                                    : productsByCategory.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: SizeConfig.screenHeight * 0.305,
                      mainAxisSpacing: getProportionateScreenHeight(5),
                      crossAxisSpacing: getProportionateScreenHeight(5),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(10),
                      horizontal: getProportionateScreenWidth(10),
                    ),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: _searchTextController.text.isNotEmpty
                            ? listProdcutSearch[index]
                            : widget._screenView == "onSales"
                                ? productsOnSale[index]
                                : widget._screenView == "topRated"
                                    ? topRatedProducts[index]
                                    : widget._screenView == "allProducts"
                                        ? allProducts[index]
                                        : productsByCategory[index],
                        child: const ProductCard(),
                      );
                    },
                  ),
      ),
    );
  }
}
