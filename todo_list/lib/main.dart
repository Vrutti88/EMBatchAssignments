import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Tasks',
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B5FEF),
        ),
        useMaterial3: true,
      ),
      home: const TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> _tasks = [];

  // Add task
  void _addTask() {
    final task = _controller.text.trim();

    if (task.isEmpty) return;

    setState(() {
      _tasks.add({
        'title': task,
        'completed': false,
      });
    });

    _controller.clear();
    FocusScope.of(context).unfocus();
  }

  // Delete task
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  // Complete / uncomplete task
  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['completed'] = !_tasks[index]['completed'];
    });
  }

  int get completedTasks {
    return _tasks.where((task) => task['completed'] == true).length;
  }

  int get pendingTasks {
    return _tasks.length - completedTasks;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ---------------- HEADER ----------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              decoration: const BoxDecoration(
                color: Color(0xFF5B5FEF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white24,
                        child: Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'My Tasks',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Text(
                    _tasks.isEmpty
                        ? 'Let’s get things done!'
                        : '$pendingTasks tasks remaining',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Statistics
                  Row(
                    children: [
                      _statCard(
                        'Total',
                        _tasks.length.toString(),
                        Icons.list_alt_rounded,
                      ),
                      const SizedBox(width: 10),
                      _statCard(
                        'Done',
                        completedTasks.toString(),
                        Icons.check_circle_outline_rounded,
                      ),
                      const SizedBox(width: 10),
                      _statCard(
                        'Pending',
                        pendingTasks.toString(),
                        Icons.pending_actions_rounded,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ---------------- ADD TASK ----------------
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _controller,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _addTask(),
                        decoration: const InputDecoration(
                          hintText: 'What needs to be done?',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.edit_note_rounded,
                            color: Color(0xFF5B5FEF),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 17,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Add button
                  Container(
                    height: 54,
                    width: 54,
                    decoration: BoxDecoration(
                      color: const Color(0xFF5B5FEF),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF5B5FEF)
                              .withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: _addTask,
                      icon: const Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ---------------- TITLE ----------------
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Tasks',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF202124),
                    ),
                  ),
                  Text(
                    '${_tasks.length} tasks',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // ---------------- TASK LIST ----------------
            Expanded(
              child: _tasks.isEmpty
                  ? _emptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        5,
                        20,
                        20,
                      ),
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        final bool completed = task['completed'];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 7,
                            ),

                            // Checkbox
                            leading: GestureDetector(
                              onTap: () => _toggleTask(index),
                              child: AnimatedContainer(
                                duration:
                                    const Duration(milliseconds: 200),
                                height: 28,
                                width: 28,
                                decoration: BoxDecoration(
                                  color: completed
                                      ? const Color(0xFF5B5FEF)
                                      : Colors.transparent,
                                  borderRadius:
                                      BorderRadius.circular(9),
                                  border: Border.all(
                                    color: completed
                                        ? const Color(0xFF5B5FEF)
                                        : Colors.grey.shade400,
                                    width: 2,
                                  ),
                                ),
                                child: completed
                                    ? const Icon(
                                        Icons.check_rounded,
                                        color: Colors.white,
                                        size: 19,
                                      )
                                    : null,
                              ),
                            ),

                            // Task title
                            title: Text(
                              task['title'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: completed
                                    ? Colors.grey
                                    : const Color(0xFF252525),
                                decoration: completed
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),

                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                completed
                                    ? 'Completed'
                                    : 'In progress',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: completed
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                              ),
                            ),

                            // Delete button
                            trailing: IconButton(
                              onPressed: () {
                                _deleteTask(index);
                              },
                              icon: Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.red.shade400,
                              ),
                              tooltip: 'Delete',
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Statistics card
  Widget _statCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 11,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Empty state
  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF5B5FEF).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.task_alt_rounded,
              size: 45,
              color: Color(0xFF5B5FEF),
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'No tasks yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 7),

          const Text(
            'Add your first task above',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}