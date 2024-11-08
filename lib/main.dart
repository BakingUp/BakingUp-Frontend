import 'package:bakingup_frontend/constants/routes.dart';
import 'package:bakingup_frontend/firebase_options.dart';
import 'package:bakingup_frontend/screens/add_edit_ingredient_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_ingredient_stock_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_instore_order_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_recipe_ingredient_screen.dart';
import 'package:bakingup_frontend/screens/add_recipe_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_stock_information_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_stock_screen.dart';
import 'package:bakingup_frontend/screens/add_ingredient_receipt_screen.dart';
import 'package:bakingup_frontend/screens/change_password_screen.dart';
import 'package:bakingup_frontend/screens/edit_recipe_screen.dart';
import 'package:bakingup_frontend/screens/home_screen.dart';
import 'package:bakingup_frontend/screens/ingredient_detail_screen.dart';
import 'package:bakingup_frontend/screens/ingredient_stock_detail_screen.dart';
import 'package:bakingup_frontend/screens/auth/login_screen.dart';
import 'package:bakingup_frontend/screens/notification_screen.dart';
import 'package:bakingup_frontend/screens/instore_order_detail_screen.dart';
import 'package:bakingup_frontend/screens/order_screen.dart';
import 'package:bakingup_frontend/screens/profile_screen.dart';
import 'package:bakingup_frontend/screens/recipe_detail_screen.dart';
import 'package:bakingup_frontend/screens/auth/register_screen.dart';
import 'package:bakingup_frontend/screens/setting_screen.dart';
import 'package:bakingup_frontend/screens/stock_detail_information_screen.dart';
import 'package:bakingup_frontend/screens/stock_detail_screen.dart';
import 'package:bakingup_frontend/screens/stock_screen.dart';
import 'package:bakingup_frontend/screens/warehouse_screen.dart';
import 'package:bakingup_frontend/services/auth/auth_gate.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  await NetworkService.instance.initClient();

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
      home: const AuthGate(),
      // Generating routes for each screen in the app
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case loginRoute:
            return MaterialPageRoute(builder: (context) => const LoginScreen());
          case registerRoute:
            return MaterialPageRoute(
                builder: (context) => const RegisterScreen());
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
                builder: (context) => const InStoreOrderDetailScreen());
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
          case addRecipeRoute:
            return MaterialPageRoute(
                builder: (context) => const AddRecipeScreen());
          case addEditOrderRoute:
            return MaterialPageRoute(
                builder: (context) => const AddEditInstoreOrderScreen());
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
          case editRecipeRoute:
            return MaterialPageRoute(
                builder: (context) => const EditRecipeScreen());
          default:
            return null;
        }
      },
    );
  }
}
