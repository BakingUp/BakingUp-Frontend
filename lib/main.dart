import 'package:bakingup_frontend/constants/routes.dart';
import 'package:bakingup_frontend/screens/add_edit_ingredient_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_ingredient_stock_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_order_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_recipe_ingredient_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_recipe_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_stock_information_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_stock_screen.dart';
import 'package:bakingup_frontend/screens/add_ingredient_receipt_screen.dart';
import 'package:bakingup_frontend/screens/change_password_screen.dart';
import 'package:bakingup_frontend/screens/home_screen.dart';
import 'package:bakingup_frontend/screens/ingredient_detail_screen.dart';
import 'package:bakingup_frontend/screens/ingredient_stock_detail_screen.dart';
import 'package:bakingup_frontend/screens/login_screen.dart';
import 'package:bakingup_frontend/screens/notification_screen.dart';
import 'package:bakingup_frontend/screens/order_detail_screen.dart';
import 'package:bakingup_frontend/screens/order_screen.dart';
import 'package:bakingup_frontend/screens/profile_screen.dart';
import 'package:bakingup_frontend/screens/recipe_detail_screen.dart';
import 'package:bakingup_frontend/screens/register_screen.dart';
import 'package:bakingup_frontend/screens/reset_password_screen.dart';
import 'package:bakingup_frontend/screens/setting_screen.dart';
import 'package:bakingup_frontend/screens/stock_detail_information_screen.dart';
import 'package:bakingup_frontend/screens/stock_detail_screen.dart';
import 'package:bakingup_frontend/screens/stock_screen.dart';
import 'package:bakingup_frontend/screens/warehouse_screen.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await NetworkService.instance.initClient();
  await Firebase.initializeApp();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Widget _initialScreen;

  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  void _checkAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          _initialScreen = const LoginScreen(); 
        });
      } else {
        setState(() {
          _initialScreen = const HomeScreen();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _initialScreen,
      // Generating routes for each screen in the app
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case loginRoute:
            return MaterialPageRoute(builder: (context) => const LoginScreen());
          case registerRoute:
            return MaterialPageRoute(
                builder: (context) => const RegisterScreen());
          case resetPasswordRoute:
            return MaterialPageRoute(
                builder: (context) => const ResetPasswordScreen());
          case changePasswordRoute:
            return MaterialPageRoute(
                builder: (context) => const ChangePasswordScreen());
          case homeRoute:
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          case warehouseRoute:
            return MaterialPageRoute(
                builder: (context) => const WarehouseScreen());
          case recipeDetailRoute:
            return MaterialPageRoute(
                builder: (context) => const RecipeDetailScreen());
          case ingredientDetailRoute:
            return MaterialPageRoute(
                builder: (context) => const IngredientDetailScreen());
          case ingredientStockDetailRoute:
            return MaterialPageRoute(
                builder: (context) => const IngredientStockDetailScreen());
          case orderRoute:
            return MaterialPageRoute(builder: (context) => const OrderScreen());
          case orderDetailRoute:
            return MaterialPageRoute(
                builder: (context) => const OrderDetailScreen());
          case notificationRoute:
            return MaterialPageRoute(
                builder: (context) => const NotificationScreen());
          case profileRoute:
            return MaterialPageRoute(
                builder: (context) => const ProfileScreen());
          case addIngredientReceiptRoute:
            return MaterialPageRoute(
                builder: (context) => const AddIngredientReceiptScreen());
          case addEditIngredientRoute:
            return MaterialPageRoute(
                builder: (context) => const AddEditIngredientScreen());
          case addEditIngredientStockRoute:
            return MaterialPageRoute(
                builder: (context) => const AddEditIngredientStockScreen());
          case addEditRecipeRoute:
            return MaterialPageRoute(
                builder: (context) => const AddEditRecipeScreen());
          case addEditOrderRoute:
            return MaterialPageRoute(
                builder: (context) => const AddEditOrderScreen());
          case addEditRecipeIngredientRoute:
            return MaterialPageRoute(
                builder: (context) => const AddEditRecipeIngredientScreen());
          case addEditStockInformationRoute:
            return MaterialPageRoute(
                builder: (context) => const AddEditStockInformationScreen());
          case stockRoute:
            return MaterialPageRoute(builder: (context) => const StockScreen());
          case addEditStockRoute:
            return MaterialPageRoute(
                builder: (context) => const AddEditStockScreen());
          case settingsRoute:
            return MaterialPageRoute(
                builder: (context) => const SettingScreen());
          case stockDetailRoute:
            return MaterialPageRoute(
                builder: (context) => const StockDetailScreen());
          case stockDetailInformationRoute:
            return MaterialPageRoute(
                builder: (context) => const StockDetailInformationScreen());
          default:
            return null;
        }
      },
    );
  }
}
