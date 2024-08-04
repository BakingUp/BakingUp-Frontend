import 'package:bakingup_frontend/constants/routes.dart';
import 'package:bakingup_frontend/screens/add_edit_ingredient_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_ingredient_stock_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_order_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_recipe_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_stock_screen.dart';
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
import 'package:bakingup_frontend/screens/stock_detail_screen.dart';
import 'package:bakingup_frontend/screens/stock_screen.dart';
import 'package:bakingup_frontend/screens/warehouse_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Setting the initial routes
      initialRoute: loginRoute,
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
                builder: (context) => const ReceipeDetailScreen());
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
          default:
            return null;
        }
      },
    );
  }
}
