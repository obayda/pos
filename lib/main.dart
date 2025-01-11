import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/invoice_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('ar');

  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POS App',
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('he'),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: HomeScreen(onLocaleChange: _setLocale),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Function(Locale) onLocaleChange;
  
  const HomeScreen({super.key, required this.onLocaleChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () async {
              final firestore = FirebaseFirestore.instance;
              final itemsRef = firestore.collection('items');
              
              // Get last sync timestamp from drift DB
              final lastSync = await database.getLastSync();
              
              // Query items updated since last sync
              final snapshot = await itemsRef
                .where('updatedAt', isGreaterThan: lastSync)
                .get();

              // Insert new/updated items into drift DB
              final batch = database.batch();
              for (var doc in snapshot.docs) {
                batch.insert(
                  database.items,
                  ItemsCompanion.insert(
                    id: doc.id,
                    name: doc.data()['name'],
                    price: doc.data()['price'],
                    updatedAt: doc.data()['updatedAt'],
                  ),
                  mode: InsertMode.insertOrReplace,
                );
              }
              await batch.commit();
              
              // Update last sync timestamp
              await database.updateLastSync(DateTime.now());
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.invoice),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InvoiceScreen()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('English'),
                  onTap: () {
                    onLocaleChange(const Locale('en'));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Arabic'),
                  onTap: () {
                    onLocaleChange(const Locale('ar'));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Hebrew'),
                  onTap: () {
                    onLocaleChange(const Locale('he'));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.language),
      ),
    );
  }
}
