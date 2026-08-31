import 'package:flutter/material.dart';
import 'async_dart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Async & Null Safety',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _displayMessage = 'Press a button to fetch API data.';
  bool _isLoading = false;

  // Calls the async function from async_dart.dart
  Future<void> _handleFetch({bool hasError = false, bool isNull = false}) async {
    setState(() {
      _isLoading = true;
    });

    // Await the response
    String result = await getUserData(hasError: hasError, isNull: isNull);

    setState(() {
      _displayMessage = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Async & Null Safety App'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Result / Status Display
              if (_isLoading)
                const Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Wait for 2 secs...'),
                  ],
                )
              else
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.deepPurple.shade200),
                  ),
                  child: Text(
                    _displayMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),

              const SizedBox(height: 30),

              // Buttons to test each case
              ElevatedButton(
                onPressed: _isLoading ? null : () => _handleFetch(hasError: false, isNull: false),
                child: const Text('1. Fetch Success Data'),
              ),
              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: _isLoading ? null : () => _handleFetch(hasError: false, isNull: true),
                child: const Text('2. Fetch Null Data'),
              ),
              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: _isLoading ? null : () => _handleFetch(hasError: true, isNull: false),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                child: const Text('3. Fetch Error Case'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}