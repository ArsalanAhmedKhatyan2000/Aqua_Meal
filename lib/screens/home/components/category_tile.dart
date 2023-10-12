import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/helper/general_methods.dart';
import 'package:aqua_meal/helper/size_configuration.dart';
import 'package:aqua_meal/models/categories.dart';
import 'package:aqua_meal/screens/view%20all/view_all.dart';
import 'package:aqua_meal/widgets/custom_page_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryModel = Provider.of<CategoryModel>(context);
    return Card(
      color: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenWidth(100))),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(CustomPageRoute(
            direction: AxisDirection.right,
            child: ViewAll(
              screenView: categoryModel.categoryName!,
              appBarTitle: categoryModel.categoryName!,
            ),
          ));
        },
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenWidth(100))),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.all(
                  Radius.circular(getProportionateScreenWidth(100)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    categoryModel.categoryImage!,
                  ),
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(5)),
              Flexible(
                child: Text(
                  categoryModel.categoryName!.capitalize(),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: getProportionateScreenWidth(13)),
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(10)),
            ],
          ),
        ),
      ),
    );
  }
}
