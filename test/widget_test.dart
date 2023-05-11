import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

// Importar clases que vayan a ser probadas
import 'package:login/view/InformationPage.dart';
import 'package:login/view/LoginPage.dart';
import 'package:login/control/Controller.dart';
import 'package:login/view/ProfilePage.dart';

void main() {
  // Pruebas de componente de la página InformationPage
  group('pruebas componentes de InformationPage', () {
    testWidgets(
        'Comprobar si se muestra correctamente el nombre de la empresa', (
        WidgetTester tester) async {
      final controller = Controller();

      await tester.pumpWidget(MaterialApp(
        home: InformationPage(controller: controller),
      ));

      expect(find.text('mueblesIQUEA'), findsOneWidget);
    });
  });

  group('pruebas componentes de LoginPage', () {
    // Prueba que se muestra correctamente el texto "¡Bienvenido!".
    testWidgets('Comprobar si se muestra correctamente el texto de bienvenida', (WidgetTester tester) async {
      final controller = Controller();

      await tester.pumpWidget(MaterialApp(
        home: LoginPage(controller: controller),
      ));

      expect(find.text('¡Bienvenido!'), findsOneWidget);
    });

    testWidgets('Muestra los mensajes de error al enviar formularios vacíos', (WidgetTester tester) async {
      final controller = Controller();
      await tester.pumpWidget(MaterialApp(
        home: LoginPage(controller: controller),
      ));

      final buttonFinder = find.widgetWithText(ElevatedButton, 'Iniciar sesión');
      expect(buttonFinder, findsOneWidget);

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      expect(find.text('El email es requerido'), findsOneWidget);
      expect(find.text('La contraseña es requerida'), findsOneWidget);
    });
  });

  group('pruebas componentes de ProfilePage', () {
    testWidgets('AppBar Información de la cuenta', (WidgetTester tester) async {
      final controller = Controller();
      controller.iniciarSesion("user1.com", "1");
      await tester.pumpWidget(MaterialApp(home: ProfilePage(controller: controller,),));
      expect(find.text('Información de la cuenta'), findsOneWidget);
    });

    testWidgets('Cambiar datos de usuario', (WidgetTester tester) async {
      // Creamos una instancia del controlador que queremos probar
      final controller = Controller();
      controller.iniciarSesion("user1.com", "1");
      // Creamos la página de perfil y la añadimos al widget tree
      await tester.pumpWidget(MaterialApp(home: ProfilePage(controller: controller)));
      // Buscamos el widget que muestra el nombre actual
      final nombreWidget = find.text(controller.getUserName());
      // Comprobamos que el widget muestra el nombre actual
      expect(nombreWidget, findsOneWidget);
      // Hacemos clic en el botón que permite cambiar el nombre
      final cambiarNombreButton = find.byIcon(Icons.add_box_outlined).first;
      await tester.tap(cambiarNombreButton);
      await tester.pumpAndSettle();

      // Introducimos el nuevo nombre en el diálogo y hacemos clic en "Confirmar"
      final nuevoNombre = 'Nuevo nombre';
      final nuevoNombreField = find.byType(TextField);
      final confirmarButton = find.widgetWithText(TextButton, 'Confirmar');
      await tester.enterText(nuevoNombreField, nuevoNombre);
      await tester.tap(confirmarButton);
      await tester.pumpAndSettle();
      // Comprobamos que el widget que muestra el nombre actual ha cambiado al nuevo nombre
      expect(find.text(nuevoNombre), findsOneWidget);
    });
  });

  }
