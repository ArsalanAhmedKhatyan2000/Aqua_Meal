import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/models/categories.dart';
import 'package:aqua_meal/providers/category_provider.dart';
import 'package:aqua_meal/screens/view%20all/view_all.dart';
import 'package:aqua_meal/widgets/build_empty_screen.dart';
import 'package:aqua_meal/widgets/build_search_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryViewAll extends StatefulWidget {
  static const String routeName = "/CategoryViewAll";
  const CategoryViewAll({Key? key}) : super(key: key);

  @override
  State<CategoryViewAll> createState() => _CategoryViewAllState();
}

class _CategoryViewAllState extends State<CategoryViewAll> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  List<CategoryModel> listCategorySearch = [];
  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double appBarHeight = 65 + AppBar().preferredSize.height;
    final categoryProvider = Provider.of<CategoryProvider>(context);
    List<CategoryModel> allCategories = categoryProvider.getCategories;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
            SizeConfig.screenWidth, getProportionateScreenHeight(appBarHeight)),
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
                      ? "${"Categories".capitalize()} (${listCategorySearch.length})"
                      : "${"Categories".capitalize()} (${allCategories.length})",
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
                hintText: "Search Category",
                iconOnTap: () {
                  _searchTextFocusNode.unfocus();
                },
                onChanged: (value) {
                  setState(() {
                    listCategorySearch = categoryProvider.searchQuery(
                        value.trim(), allCategories);
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body:
          (_searchTextController.text.isNotEmpty && listCategorySearch.isEmpty)
              ? const EmptyScreen(
                  svgImagePath: "assets/images/empty_category.svg",
                  title: "Oops! No Category Found",
                  description: "Sorry, there is no category with this name.",
                )
              : GridView.builder(
                  shrinkWrap: true,
                  itemCount: _searchTextController.text.isNotEmpty
                      ? listCategorySearch.length
                      : allCategories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:
                        SizeConfig.screenWidth / (SizeConfig.screenHeight / 3),
                    mainAxisSpacing: getProportionateScreenHeight(10),
                    crossAxisSpacing: getProportionateScreenHeight(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10),
                    vertical: getProportionateScreenHeight(10),
                  ),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: _searchTextController.text.isNotEmpty
                          ? listCategorySearch[index]
                          : allCategories[index],
                      child: const CatTile(),
                    );
                  },
                ),
    );
  }
}

class CatTile extends StatelessWidget {
  const CatTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryModel = Provider.of<CategoryModel>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewAll(
                      screenView: categoryModel.categoryName!,
                      appBarTitle: categoryModel.categoryName!,
                    )));
      },
      borderRadius:
          BorderRadius.all(Radius.circular(getProportionateScreenWidth(10))),
      child: Card(
        margin: const EdgeInsets.all(0),
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(getProportionateScreenWidth(10))),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(getProportionateScreenWidth(10))),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    categoryModel.categoryImage!,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: getProportionateScreenHeight(30),
                width: getProportionateScreenWidth(130),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft:
                          Radius.circular(getProportionateScreenWidth(10)),
                      topRight:
                          Radius.circular(getProportionateScreenWidth(10))),
                ),
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(3)),
                  margin: EdgeInsets.all(getProportionateScreenWidth(1)),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft:
                            Radius.circular(getProportionateScreenWidth(10)),
                        topRight:
                            Radius.circular(getProportionateScreenWidth(10))),
                  ),
                  child: Text(
                    categoryModel.categoryName!.capitalize(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: getProportionateScreenWidth(15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
