import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:login/control/Controller.dart';
import 'package:login/view/LoginPage.dart';
import 'package:login/view/RegisterPage.dart';
import 'package:login/view/ShopPage.dart';
import 'package:login/view/MyApp.dart';
import 'package:login/view/ProfilePage.dart';
import 'package:login/view/ShoppingCartPage.dart';
import 'package:login/view/CatalogPage.dart';
import 'package:login/view/InformationPage.dart';
import 'package:login/view/CommentsPage.dart';

void main() {

  testWidgets('Controlador compartido con LoginPage', (WidgetTester tester) async {
    // Crea una instancia de MyApp
    final app = MyApp();

    // Arranca la aplicación
    await tester.pumpWidget(app);

    // Obtiene una referencia al controlador de MyApp
    final Controller appController = app.controller;

    // Obtiene una referencia al controlador de LoginPage
    final LoginPage loginPage = tester.widget(find.byType(LoginPage));
    final Controller loginController = loginPage.controller;
    expect(loginController, equals(appController));
  });

  testWidgets('navegar a RegisterPage, controlador compartido', (WidgetTester tester) async {
    final app = MyApp();
    await tester.pumpWidget(app);

    // Navegar a RegisterPage
    await tester.tap(find.text('¿No tienes una cuenta? Regístrate'));
    await tester.pumpAndSettle();

    // Comprobar que se encuentra en RegisterPage
    expect(find.byType(RegisterPage), findsOneWidget);

    // Obtén una referencia al controlador de RegisterPage
    final RegisterPage registerPage = tester.widget(find.byType(RegisterPage));
    final Controller registerController = registerPage.controller;

    // Obtiene una referencia al controlador de MyApp
    final Controller appController = app.controller;

    // Comprueba que el controlador de RegisterPage es el mismo que el de MyApp
    expect(registerController, equals(appController));
  });

  testWidgets('iniciar sesion, navegar a ShopPage + controlador compartido', (WidgetTester tester) async {
    final app = MyApp();
    await tester.pumpWidget(app);

    // Iniciar sesion con un usuario valido
    // Busca los campos de texto para el email y la contraseña y escribe en ellos
    await tester.enterText(find.byType(TextFormField).at(0), 'user1.com');
    await tester.enterText(find.byType(TextFormField).at(1), '1');

    // Toca el botón para iniciar sesión
    // await tester.tap(find.text('Iniciar sesión'));
    final button = find.widgetWithText(ElevatedButton, 'Iniciar sesión');
    await tester.tap(button);


    // Espera a que se complete la animación de transición
    await tester.pumpAndSettle();

    // Comprobar que se encuentra en RegisterPage
    expect(find.byType(ShopPage), findsOneWidget);

    // Obtén una referencia al controlador de RegisterPage
    final ShopPage shopPage = tester.widget(find.byType(ShopPage));
    final Controller shopController = shopPage.controller;

    // Obtiene una referencia al controlador de MyApp
    final Controller appController = app.controller;

    // Comprueba que el controlador de RegisterPage es el mismo que el de MyApp
    expect(shopController, equals(appController));
  });

  testWidgets('Navegacion entre paginas de la tienda(ShopPage) + controlador compartido', (WidgetTester tester) async {
    final controller = Controller();
    controller.iniciarSesion("user1.com", "1");
    await tester.pumpWidget(
      MaterialApp(
        home: ShopPage(controller: controller),
      ),
    );

    final catalogFinder = find.byType(CatalogPage);
    expect((tester.widget<CatalogPage>(catalogFinder)).controller, controller);

    // Navegamos a la pagina del carrito
    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();
    final cartFinder = find.byType(ShoppingCartPage);
    expect((tester.widget<ShoppingCartPage>(cartFinder)).controller, controller);

    // Navegamos a la pagina de comentarios
    await tester.tap(find.byIcon(Icons.comment_rounded));
    await tester.pumpAndSettle();
    final commentsFinder = find.byType(CommentPage);
    expect((tester.widget<CommentPage>(commentsFinder)).controller, controller);


    // Navegamos a la página de informacion
    await tester.tap(find.byIcon(Icons.info_rounded));
    await tester.pumpAndSettle();
    final infoFinder = find.byType(InformationPage);
    expect((tester.widget<InformationPage>(infoFinder)).controller, controller);

    // Navegamos a la página de perfil
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();
    final profileFinder = find.byType(ProfilePage);
    expect((tester.widget<ProfilePage>(profileFinder)).controller, controller);

  });

}
