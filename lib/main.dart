import 'package:bakingup_frontend/constants/routes.dart';
import 'package:bakingup_frontend/firebase_options.dart';
import 'package:bakingup_frontend/screens/add_ingredient_screen.dart';
import 'package:bakingup_frontend/screens/add_ingredient_stock_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_instore_order_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_recipe_ingredient_screen.dart';
import 'package:bakingup_frontend/screens/add_recipe_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_stock_information_screen.dart';
import 'package:bakingup_frontend/screens/add_edit_stock_screen.dart';
import 'package:bakingup_frontend/screens/add_ingredient_receipt_screen.dart';
import 'package:bakingup_frontend/screens/auth/login_screen.dart';
import 'package:bakingup_frontend/screens/auth/register_screen.dart';
import 'package:bakingup_frontend/screens/change_password_screen.dart';
import 'package:bakingup_frontend/screens/edit_ingredient_screen.dart';
import 'package:bakingup_frontend/screens/edit_ingredient_stock_screen.dart';
import 'package:bakingup_frontend/screens/edit_recipe_screen.dart';
import 'package:bakingup_frontend/screens/home_screen.dart';
import 'package:bakingup_frontend/screens/ingredient_detail_screen.dart';
import 'package:bakingup_frontend/screens/ingredient_stock_detail_screen.dart';
import 'package:bakingup_frontend/screens/instore_order_detail_screen.dart';
import 'package:bakingup_frontend/screens/notification_screen.dart';
import 'package:bakingup_frontend/screens/order_screen.dart';
import 'package:bakingup_frontend/screens/preorder_order_detail_screen.dart';
import 'package:bakingup_frontend/screens/profile_screen.dart';
import 'package:bakingup_frontend/screens/recipe_detail_screen.dart';
import 'package:bakingup_frontend/screens/setting_screen.dart';
import 'package:bakingup_frontend/screens/stock_detail_information_screen.dart';
import 'package:bakingup_frontend/screens/stock_detail_screen.dart';
import 'package:bakingup_frontend/screens/stock_screen.dart';
import 'package:bakingup_frontend/screens/warehouse_screen.dart';
import 'package:bakingup_frontend/services/auth/auth_gate.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/services/noti_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

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
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService(navigatorKey: navigatorKey).showNotification(
          id: DateTime.now().millisecond,
          title: message.notification!.title,
          body: message.notification!.body);
    });

    NotificationService(navigatorKey: navigatorKey).initNotification();
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
          case instoreOrderDetailRoute:
            return MaterialPageRoute(
                builder: (context) => const InStoreOrderDetailScreen());
          case preorderOrderDetailRoute:
            return MaterialPageRoute(
                builder: (context) => const PreorderOrderDetailScreen());
          case notificationRoute:
            return MaterialPageRoute(
                builder: (context) => const NotificationScreen());
          case profileRoute:
            return MaterialPageRoute(
                builder: (context) => const ProfileScreen());
          case addIngredientReceiptRoute:
            return MaterialPageRoute(
                builder: (context) => const AddIngredientReceiptScreen());
          case addIngredientRoute:
            return MaterialPageRoute(
                builder: (context) => const AddIngredientScreen());
          case addIngredientStockRoute:
            return MaterialPageRoute(
                builder: (context) => const AddIngredientStockScreen());
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
          case editIngredientRoute:
            return MaterialPageRoute(
                builder: (context) => const EditIngredientScreen());
          case editIngredientStockRoute:
            return MaterialPageRoute(
                builder: (context) => const EditIngredientStockScreen());
          default:
            return null;
        }
      },
    );
  }
}
