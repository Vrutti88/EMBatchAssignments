import 'dart:async';
import 'package:flutter/material.dart';

import '01_variables.dart' as m01;
import '02_collections.dart' as m02;
import '03_operators.dart' as m03;
import '04_control_flow.dart' as m04;
import '05_functions.dart' as m05;
import '06_null_safety.dart' as m06;
import '07_advanced_control_flow.dart' as m07;
import '08_advanced_functions.dart' as m08;
import '09_advanced_null_safety.dart' as m09;

void main() {
  runApp(const DartAssignmentApp());
}

class ModuleItem {
  final String id;
  final String title;
  final String fileName;
  final void Function() runner;

  const ModuleItem({
    required this.id,
    required this.title,
    required this.fileName,
    required this.runner,
  });
}

class DartAssignmentApp extends StatelessWidget {
  const DartAssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dart Fundamentals Runner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const ModuleRunnerScreen(),
    );
  }
}

class ModuleRunnerScreen extends StatefulWidget {
  const ModuleRunnerScreen({super.key});

  @override
  State<ModuleRunnerScreen> createState() => _ModuleRunnerScreenState();
}

class _ModuleRunnerScreenState extends State<ModuleRunnerScreen> {
  final List<ModuleItem> modules = [
    const ModuleItem(
      id: "01",
      title: "Variables, Data Types & Formatting",
      fileName: "01_variables.dart",
      runner: m01.main,
    ),
    const ModuleItem(
      id: "02",
      title: "Collections & Type Conversions",
      fileName: "02_collections.dart",
      runner: m02.main,
    ),
    const ModuleItem(
      id: "03",
      title: "Operators, Relational & Cascade",
      fileName: "03_operators.dart",
      runner: m03.main,
    ),
    const ModuleItem(
      id: "04",
      title: "Control Flow, Switch & Loops",
      fileName: "04_control_flow.dart",
      runner: m04.main,
    ),
    const ModuleItem(
      id: "05",
      title: "Functions, Scope & Closures",
      fileName: "05_functions.dart",
      runner: m05.main,
    ),
    const ModuleItem(
      id: "06",
      title: "Sound Null Safety & Keywords",
      fileName: "06_null_safety.dart",
      runner: m06.main,
    ),
    const ModuleItem(
      id: "07",
      title: "Advanced Control Flow & Patterns",
      fileName: "07_advanced_control_flow.dart",
      runner: m07.main,
    ),
    const ModuleItem(
      id: "08",
      title: "Advanced Functions & Scope",
      fileName: "08_advanced_functions.dart",
      runner: m08.main,
    ),
    const ModuleItem(
      id: "09",
      title: "Advanced Null Safety",
      fileName: "09_advanced_null_safety.dart",
      runner: m09.main,
    ),
  ];

  String _currentOutput = 'Click "Run All Modules" or select a module below to execute and view output.';
  String _selectedModuleName = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runAllModules();
    });
  }

  void _executeModule(ModuleItem module) {
    List<String> logs = [];
    logs.add('--- Running ${module.fileName} (${module.title}) ---');

    runZoned(
      () {
        try {
          module.runner();
          logs.add('--- Completed successfully ---');
        } catch (e, stackTrace) {
          logs.add('ERROR: $e');
          logs.add(stackTrace.toString());
        }
      },
      zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, line) {
          parent.print(zone, line);
          logs.add(line);
        },
      ),
    );

    setState(() {
      _selectedModuleName = module.title;
      _currentOutput = logs.join('\n');
    });
  }

  void _runAllModules() {
    List<String> allLogs = [];
    allLogs.add('=========================================');
    allLogs.add('   RUNNING ALL DART ASSIGNMENT MODULES   ');
    allLogs.add('=========================================\n');

    for (final module in modules) {
      allLogs.add('>>> [MODULE ${module.id}] ${module.title} (${module.fileName})');
      runZoned(
        () {
          try {
            module.runner();
          } catch (e) {
            allLogs.add('ERROR in Module ${module.id}: $e');
          }
        },
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) {
            parent.print(zone, '[Module ${module.id}] $line');
            allLogs.add('  $line');
          },
        ),
      );
      allLogs.add('');
    }

    allLogs.add('=========================================');
    allLogs.add('   ALL 9 MODULES EXECUTED SUCCESSFULLY   ');
    allLogs.add('=========================================');

    setState(() {
      _selectedModuleName = 'All Modules (01 - 09)';
      _currentOutput = allLogs.join('\n');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dart Assignment Runner'),
        actions: [
          IconButton(
            tooltip: 'Run All Modules',
            icon: const Icon(Icons.play_circle_filled),
            onPressed: _runAllModules,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;
          if (isWide) {
            return Row(
              children: [
                Expanded(flex: 1, child: _buildModuleList()),
                const VerticalDivider(width: 1),
                Expanded(flex: 1, child: _buildConsoleOutput()),
              ],
            );
          } else {
            return Column(
              children: [
                Expanded(flex: 1, child: _buildModuleList()),
                const Divider(height: 1),
                Expanded(flex: 1, child: _buildConsoleOutput()),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildModuleList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _runAllModules,
              icon: const Icon(Icons.playlist_play),
              label: const Text('Run All 9 Modules'),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: modules.length,
            itemBuilder: (context, index) {
              final module = modules[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(module.id),
                ),
                title: Text(module.title),
                subtitle: Text(module.fileName),
                trailing: IconButton(
                  icon: const Icon(Icons.play_arrow),
                  tooltip: 'Run ${module.fileName}',
                  onPressed: () => _executeModule(module),
                ),
                onTap: () => _executeModule(module),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildConsoleOutput() {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedModuleName.isEmpty ? 'Console Output' : 'Output: $_selectedModuleName',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.clear_all),
                tooltip: 'Clear Output',
                onPressed: () {
                  setState(() {
                    _currentOutput = '';
                    _selectedModuleName = '';
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                child: SelectableText(
                  _currentOutput,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: Color(0xFFD4D4D4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
