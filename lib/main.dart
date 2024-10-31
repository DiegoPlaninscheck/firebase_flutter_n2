import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/firebase_options.dart';
import 'package:firebase_flutter/pages/home_page.dart';
import 'package:flutter/material.dart';

// Função principal que inicializa o aplicativo
void main() async {
  // Garante que os widgets estejam vinculados e que a inicialização do Firebase ocorra antes de rodar o app
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase com as configurações especificadas para a plataforma atual
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Executa o app MyApp
  runApp(MyApp());
}

// Classe principal do aplicativo
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas em Casa', // Define o título do aplicativo

      // Define o tema principal do aplicativo
      theme: ThemeData(
        primaryColor: const Color(0xFF484848), // Cor principal do tema

        // Define o esquema de cores
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary:
              const Color(0xFF484848), // Cor para os componentes principais
          secondary:
              const Color(0xFF604848), // Cor de destaque para botões, etc.
          surface:
              const Color(0xFFD8D8D8), // Cor de fundo de elementos de entrada
          onPrimary: Colors.white, // Cor do texto em botões de cor primária
          onSecondary: Colors.white, // Cor do texto em botões de cor secundária
          onSurface: Colors.black, // Cor do texto em superfícies
        ),

        // Cor de fundo padrão para páginas
        scaffoldBackgroundColor: const Color(0xFFF0F0F0),

        // Estilo para a AppBar
        appBarTheme: const AppBarTheme(
          color: Color(0xFF484848), // Cor de fundo da AppBar
          iconTheme: IconThemeData(
              color: Color(0xFFC0C0A8)), // Cor dos ícones da AppBar
          titleTextStyle: TextStyle(
            color: Color(0xFFC0C0A8), // Cor do texto do título da AppBar
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Estilo do texto no aplicativo
        textTheme: const TextTheme(
          bodyLarge:
              TextStyle(color: Color(0xFF484848)), // Cor do texto grande (body)
          bodyMedium: TextStyle(color: Color(0xFF604848)), // Cor do texto médio
          titleMedium: TextStyle(
              color: Color(0xFF484848)), // Cor para títulos de tamanho médio
        ),

        // Estilo para botões elevados (ElevatedButton)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color(0xFFF0F0F0), // Cor do texto do botão
            backgroundColor: const Color(0xFF604848), // Cor de fundo do botão
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        // Estilo de decoração para campos de entrada de texto
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFD8D8D8), // Cor de fundo para o campo de entrada
          labelStyle:
              TextStyle(color: Color(0xFF484848)), // Cor do texto do rótulo
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xFF604848)), // Cor da borda ao focar no campo
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xFFD8D8D8)), // Cor da borda padrão do campo
          ),
        ),
      ),

      // Define a página inicial do aplicativo
      home: HomePage(),
    );
  }
}
