import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


// ======================================================
// TASK 1: APP SETUP
// ======================================================
//
// Answer:
// - MaterialApp → application ka root widget
// - DashboardScreen → home screen
// - Theme → basic application styling
// ======================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Dashboard',

      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),

      home: const DashboardScreen(),
    );
  }
}


// ======================================================
// TASK 2: RESPONSIVE DASHBOARD SCREEN
// ======================================================
//
// Answer:
// - MediaQuery → screen width find karne ke liye
// - Row → sidebar + dashboard ko side-by-side rakhne ke liye
// - Expanded → remaining space dashboard ko dene ke liye
// - Mobile par sidebar hide
// ======================================================

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Screen ki width find kar rahe hain
    double screenWidth = MediaQuery.of(context).size.width;

    // Responsive breakpoints
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    bool isDesktop = screenWidth >= 1024;

    return Scaffold(

      // Mobile ke liye AppBar
      appBar: isMobile
          ? AppBar(
              title: const Text('Food Dashboard'),
            )
          : null,

      body: Row(
        children: [

          // Mobile par Sidebar nahi dikhega
          if (!isMobile)
            SizedBox(
              width: isDesktop ? 230 : 180,
              child: const SideMenu(),
            ),

          // Remaining space Dashboard lega
          Expanded(
            child: DashboardContent(
              isMobile: isMobile,
              isTablet: isTablet,
              isDesktop: isDesktop,
            ),
          ),
        ],
      ),
    );
  }
}


// ======================================================
// TASK 3: SIDEBAR
// ======================================================
//
// Answer:
// - Column → menu items vertical
// - Reusable MenuItem widget
// - ListTile → icon + title + tap action
// ======================================================

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,

      child: Column(
        children: [

          const SizedBox(height: 30),

          const Icon(
            Icons.fastfood,
            size: 50,
            color: Colors.orange,
          ),

          const SizedBox(height: 10),

          const Text(
            'Food App',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          MenuItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
          ),

          MenuItem(
            icon: Icons.shopping_cart,
            title: 'Orders',
          ),

          MenuItem(
            icon: Icons.people,
            title: 'Customers',
          ),

          MenuItem(
            icon: Icons.settings,
            title: 'Settings',
          ),
        ],
      ),
    );
  }
}


// ======================================================
// REUSABLE MENU ITEM
// ======================================================

class MenuItem extends StatelessWidget {

  final IconData icon;
  final String title;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(

      leading: Icon(
        icon,
        color: Colors.orange,
      ),

      title: Text(title),

      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DetailScreen(
                title: title,
              );
            },
          ),
        );
      },
    );
  }
}


// ======================================================
// TASK 4: STATISTICS CARDS
// ======================================================
//
// Answer:
// - Row → cards horizontally
// - Expanded → equal available width
// - Reusable StatCard
// ======================================================

class StatCard extends StatelessWidget {

  final String title;
  final String value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(15),

        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
          ),
        ],
      ),

      child: Row(
        children: [

          Icon(
            icon,
            size: 30,
            color: Colors.orange,
          ),

          const SizedBox(width: 10),

          // Flexible prevents text overflow
          Flexible(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 5),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// ======================================================
// TASK 5: FOOD GRID
// ======================================================
//
// Answer:
// - GridView.builder → dynamic food items
// - MediaQuery → responsive columns
//
// Mobile  → 2 columns
// Tablet  → 3 columns
// Desktop → 4 columns
// ======================================================

class FoodGrid extends StatelessWidget {

  final bool isMobile;
  final bool isTablet;

  const FoodGrid({
    super.key,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {

    final List<String> foods = [
      'Pizza',
      'Burger',
      'Pasta',
      'Sandwich',
      'Biryani',
      'Noodles',
    ];

    return GridView.builder(

      // Parent scroll karega
      shrinkWrap: true,

      // Grid ka separate scrolling nahi chahiye
      physics:
          const NeverScrollableScrollPhysics(),

      itemCount: foods.length,

      // Responsive grid
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(

        crossAxisCount: isMobile
            ? 2
            : isTablet
                ? 3
                : 4,

        crossAxisSpacing: 12,
        mainAxisSpacing: 12,

        childAspectRatio: 1,
      ),

      itemBuilder: (context, index) {

        return FoodCard(
          foodName: foods[index],
          price: '₹${199 + index * 50}',
        );
      },
    );
  }
}


// ======================================================
// REUSABLE FOOD CARD
// ======================================================

class FoodCard extends StatelessWidget {

  final String foodName;
  final String price;

  const FoodCard({
    super.key,
    required this.foodName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(15),

        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
          ),
        ],
      ),

      child: Column(

        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          const Icon(
            Icons.local_pizza,
            size: 50,
            color: Colors.orange,
          ),

          const SizedBox(height: 10),

          Text(
            foodName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            price,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}


// ======================================================
// TASK 6: RECENT ORDERS
// ======================================================
//
// Answer:
// - ListView.builder → dynamic list
// - ListTile → order information
// - Reusable UI
// ======================================================

class RecentOrders extends StatelessWidget {
  const RecentOrders({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, String>> orders = [

      {
        'id': '#1001',
        'food': 'Pizza + Coke',
        'status': 'Delivered',
      },

      {
        'id': '#1002',
        'food': 'Burger + Fries',
        'status': 'Preparing',
      },

      {
        'id': '#1003',
        'food': 'Pasta + Coke',
        'status': 'Delivered',
      },

      {
        'id': '#1004',
        'food': 'Biryani + Raita',
        'status': 'Cancelled',
      },
    ];

    return ListView.builder(

      shrinkWrap: true,

      physics:
          const NeverScrollableScrollPhysics(),

      itemCount: orders.length,

      itemBuilder: (context, index) {

        final order = orders[index];

        return Card(

          child: ListTile(

            leading: CircleAvatar(
              child: Text(
                '${index + 1}',
              ),
            ),

            title: Text(
              'Order ${order['id']}',
            ),

            subtitle: Text(
              order['food']!,
            ),

            trailing: Text(
              order['status']!,
            ),
          ),
        );
      },
    );
  }
}


// ======================================================
// TASK 7 + MAIN DASHBOARD CONTENT
// ======================================================

class DashboardContent extends StatelessWidget {

  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;

  const DashboardContent({
    super.key,
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: Padding(
        padding: EdgeInsets.all(
          isMobile ? 15 : 25,
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // ==================================================
            // HEADER
            // ==================================================

            Row(
              children: [

                // Expanded because text should take
                // available space
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(
                        'Good Morning!',
                        style: TextStyle(
                          fontSize:
                              isMobile ? 22 : 30,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        'Welcome to your food dashboard',
                      ),
                    ],
                  ),
                ),

                if (!isMobile)
                  const CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.person),
                  ),
              ],
            ),

            const SizedBox(height: 25),

            // ==================================================
            // STATISTICS
            // ==================================================

            const Text(
              "Today's Statistics",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child: StatCard(
                    title: 'Orders',
                    value: '120',
                    icon: Icons.shopping_cart,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: StatCard(
                    title: 'Customers',
                    value: '85',
                    icon: Icons.people,
                  ),
                ),

                // Desktop par Revenue card
                if (!isMobile) ...[

                  const SizedBox(width: 10),

                  Expanded(
                    child: StatCard(
                      title: 'Revenue',
                      value: '₹25K',
                      icon: Icons.currency_rupee,
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 30),

            // ==================================================
            // FOOD GRID
            // ==================================================

            const Text(
              'Popular Food',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            FoodGrid(
              isMobile: isMobile,
              isTablet: isTablet,
            ),

            const SizedBox(height: 30),

            // ==================================================
            // RECENT ORDERS
            // ==================================================

            const Text(
              'Recent Orders',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const RecentOrders(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}


// ======================================================
// TASK 7: DETAIL SCREEN / NAVIGATION
// ======================================================

class DetailScreen extends StatelessWidget {

  final String title;

  const DetailScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(title),
      ),

      body: Center(

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.check_circle,
              size: 70,
              color: Colors.green,
            ),

            const SizedBox(height: 20),

            Text(
              '$title Screen',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {

                // Previous screen par wapas
                Navigator.pop(context);
              },

              child: const Text(
                'Go Back',
              ),
            ),
          ],
        ),
      ),
    );
  }
}