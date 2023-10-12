import 'package:aqua_meal/constraints.dart';
import 'package:aqua_meal/my_routes.dart';
import 'package:aqua_meal/my_themes.dart';
import 'package:aqua_meal/providers/cart_provider.dart';
import 'package:aqua_meal/providers/category_provider.dart';
import 'package:aqua_meal/providers/order_details_provider.dart';
import 'package:aqua_meal/providers/orders_provider.dart';
import 'package:aqua_meal/providers/product_provider.dart';
import 'package:aqua_meal/providers/seller_provider.dart';
import 'package:aqua_meal/providers/terms_and_condition_provider.dart';
import 'package:aqua_meal/providers/wishlist_provider.dart';
import 'package:aqua_meal/screens/splash_screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    loadPreCacheImages(context); //load pre cache images.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ProductsProvider()),
              ChangeNotifierProvider(create: (_) => SellerProvider()),
              ChangeNotifierProvider(create: (_) => CategoryProvider()),
              ChangeNotifierProvider(create: (_) => CartProvider()),
              ChangeNotifierProvider(create: (_) => WishlistProvider()),
              ChangeNotifierProvider(create: (_) => OrdersProvider()),
              ChangeNotifierProvider(create: (_) => OrderDetailsProvider()),
              ChangeNotifierProvider(
                  create: (_) => TermsAndConditionProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Aqua Meal',
              themeMode: ThemeMode.system,
              theme: MyThemes.lightTheme(context),
              darkTheme: MyThemes.darkTheme(context),
              initialRoute: Splash.routeName,
              onGenerateRoute: CustomRoute.onGenerateRoute,
            ),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

loadPreCacheImages(BuildContext context) {
  Future.wait([
    precacheImage(
        Image.asset(lightThemeLogo!).image, context), //png image pre cache
    precacheImage(
        Image.asset(darkThemeLogo!).image, context), //png image pre cache
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, loadingFishImage!),
      null,
    ),
  ]);
}
