import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlavorCraft Dashboard',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF800020),
          primary: const Color(0xFF800020),
          secondary: const Color(0xFF78350F),
          surface: const Color(0xFFFAF7F5),
        ),
        scaffoldBackgroundColor: const Color(0xFFFAF7F5),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFAF7F5),
          foregroundColor: Color(0xFF2C1810),
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Color(0xFF2C1810),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF800020),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

class CartItem {
  final String name;
  final int price;
  final IconData icon;
  final String? imageUrl;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.icon,
    this.imageUrl,
    this.quantity = 1,
  });
}

class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<CartItem> items = [];
  final ValueNotifier<int> totalCountNotifier = ValueNotifier<int>(0);

  void addItem(String name, int price, IconData icon, {String? imageUrl}) {
    int index = items.indexWhere((item) => item.name == name);
    if (index >= 0) {
      items[index].quantity++;
    } else {
      items.add(
        CartItem(name: name, price: price, icon: icon, imageUrl: imageUrl),
      );
    }
    _notify();
  }

  void removeItem(String name) {
    int index = items.indexWhere((item) => item.name == name);
    if (index >= 0) {
      if (items[index].quantity > 1) {
        items[index].quantity--;
      } else {
        items.removeAt(index);
      }
    }
    _notify();
  }

  void clearCart() {
    items.clear();
    _notify();
  }

  int get totalAmount {
    int sum = 0;
    for (var item in items) {
      sum += item.price * item.quantity;
    }
    return sum;
  }

  void _notify() {
    int count = 0;
    for (var item in items) {
      count += item.quantity;
    }
    totalCountNotifier.value = count;
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openCartSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CartBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    bool isDesktop = screenWidth >= 1024;

    return Scaffold(
      key: _scaffoldKey,

      appBar: isMobile
          ? AppBar(
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF800020).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.outdoor_grill_sharp,
                      color: Color(0xFF800020),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'FlavorCraft',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF2C1810),
                    ),
                  ),
                ],
              ),
              actions: [
                ValueListenableBuilder<int>(
                  valueListenable: CartManager().totalCountNotifier,
                  builder: (context, count, child) {
                    return IconButton(
                      icon: Badge(
                        isLabelVisible: count > 0,
                        label: Text('$count'),
                        backgroundColor: const Color(0xFF800020),
                        child: const Icon(Icons.shopping_bag_outlined),
                      ),
                      onPressed: _openCartSheet,
                    );
                  },
                ),
                const SizedBox(width: 8),
              ],
            )
          : null,

      drawer: isMobile ? const Drawer(child: SideMenu(isDrawer: true)) : null,

      body: Row(
        children: [
          if (!isMobile)
            SizedBox(width: isDesktop ? 240 : 200, child: const SideMenu()),

          Expanded(
            child: DashboardContent(
              isMobile: isMobile,
              isTablet: isTablet,
              isDesktop: isDesktop,
              onCartPressed: _openCartSheet,
            ),
          ),
        ],
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  final bool isDrawer;
  const SideMenu({super.key, this.isDrawer = false});

  @override
  Widget build(BuildContext context) {
    final themePrimary = Theme.of(context).primaryColor;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Color(0xFFEFE8E2), width: 1)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisSize: isDrawer ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: isDrawer
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF800020), Color(0xFF9E1B32)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF800020).withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: const Icon(
                      Icons.outdoor_grill_sharp,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Flexible(
                    child: Text(
                      'FlavorCraft',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                        color: Color(0xFF2C1810),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: Color(0xFFEFE8E2),
            ),
            const SizedBox(height: 15),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: const [
                  MenuItem(
                    icon: Icons.dashboard_rounded,
                    title: 'Dashboard',
                    isActive: true,
                  ),
                  MenuItem(icon: Icons.shopping_cart_rounded, title: 'Orders'),

                  MenuItem(
                    icon: Icons.local_offer_rounded,
                    title: 'Offers',
                    badge: 'HOT',
                  ),
                  MenuItem(icon: Icons.restaurant_rounded, title: 'Menu'),
                  MenuItem(icon: Icons.settings_rounded, title: 'Settings'),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: themePrimary.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEFE8E2)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: themePrimary.withValues(alpha: 0.15),
                      child: Icon(Icons.person, color: themePrimary, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Admin Chef',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C1810),
                            ),
                          ),
                          Text(
                            'Gourmet Master',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF786259),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final String? badge;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.isActive = false,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final themePrimary = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (Scaffold.of(context).isDrawerOpen) {
              Navigator.pop(context);
            }

            if (title == 'Offers') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OffersScreen()),
              );
            } else if (!isActive) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(title: title),
                ),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: isActive
                  ? themePrimary.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: isActive ? themePrimary : const Color(0xFF786259),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                      color: isActive ? themePrimary : const Color(0xFF4A342B),
                    ),
                  ),
                ),
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF800020),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      badge!,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final String? subtitle;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor = const Color(0xFF800020),
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE8E2)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C1810).withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 26, color: iconColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF786259),
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C1810),
                    letterSpacing: -0.5,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FoodGrid extends StatefulWidget {
  final bool isMobile;
  final bool isTablet;

  const FoodGrid({super.key, required this.isMobile, required this.isTablet});

  @override
  State<FoodGrid> createState() => _FoodGridState();
}

class _FoodGridState extends State<FoodGrid> {
  final TextEditingController searchController = TextEditingController();
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Pizza',
    'Burgers',
    'Mains',
    'Desserts',
    'Beverages',
  ];

  final List<Map<String, dynamic>> foods = [
    {
      'name': 'Margherita Pizza',
      'category': 'Pizza',
      'icon': Icons.local_pizza_rounded,
      'image': 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=500&auto=format&fit=crop&q=60',
      'price': 249,
      'rating': 4.8,
    },
    {
      'name': 'Classic Cheeseburger',
      'category': 'Burgers',
      'icon': Icons.lunch_dining_rounded,
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500&auto=format&fit=crop&q=60',
      'price': 199,
      'rating': 4.5,
    },
    {
      'name': 'Creamy Alfredo Pasta',
      'category': 'Mains',
      'icon': Icons.ramen_dining_rounded,
      'image': 'https://images.unsplash.com/photo-1546549032-9571cd6b27df?w=600&auto=format&fit=crop&q=80',
      'price': 279,
      'rating': 4.7,
    },
    {
      'name': 'Grilled Club Sandwich',
      'category': 'Burgers',
      'icon': Icons.breakfast_dining_rounded,
      'image': 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=600&auto=format&fit=crop&q=80',
      'price': 169,
      'rating': 4.3,
    },
    {
      'name': 'Hyderabadi Dum Biryani',
      'category': 'Mains',
      'icon': Icons.rice_bowl_rounded,
      'image': 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=600&auto=format&fit=crop&q=80',
      'price': 349,
      'rating': 4.9,
    },
    {
      'name': 'Hakka Noodles Platter',
      'category': 'Mains',
      'icon': Icons.dinner_dining_rounded,
      'image': 'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=600&auto=format&fit=crop&q=80',
      'price': 219,
      'rating': 4.4,
    },
    {
      'name': 'Chicken Tikka Kebab',
      'category': 'Mains',
      'icon': Icons.kebab_dining_rounded,
      'image': 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600&auto=format&fit=crop&q=80',
      'price': 319,
      'rating': 4.6,
    },
    {
      'name': 'Choco Lava Cake Delight',
      'category': 'Desserts',
      'icon': Icons.cake_rounded,
      'image': 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=600&auto=format&fit=crop&q=80',
      'price': 159,
      'rating': 4.9,
    },

    {
      'name': 'Paneer Tikka Roll',
      'category': 'Mains',
      'icon': Icons.tapas_rounded,
      'image': 'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?w=600&auto=format&fit=crop&q=80',
      'price': 189,
      'rating': 4.7,
    },

    {
      'name': 'Loaded Mexican Tacos',
      'category': 'Mains',
      'icon': Icons.fastfood_rounded,
      'image': 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=500&auto=format&fit=crop&q=60',
      'price': 229,
      'rating': 4.6,
    },

    {
      'name': 'Iced Caramel Frappe',
      'category': 'Beverages',
      'icon': Icons.local_cafe_rounded,
      'image': 'https://images.unsplash.com/photo-1517256064527-09c73fc73e38?w=500&auto=format&fit=crop&q=60',
      'price': 149,
      'rating': 4.8,
    },

    {
      'name': 'Extra Cheese Paneer Tandoori Pizza',
      'category': 'Pizza',
      'icon': Icons.local_pizza_rounded,
      'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500&auto=format&fit=crop&q=60',
      'price': 399,
      'rating': 4.9,
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themePrimary = Theme.of(context).primaryColor;
    String searchText = searchController.text.trim().toLowerCase();

    List<Map<String, dynamic>> filteredFoods = foods.where((food) {
      final name = food['name'].toString().toLowerCase();
      final category = food['category'].toString().toLowerCase();
      final matchesSearch = searchText.isEmpty || name.contains(searchText);
      final matchesCategory =
          selectedCategory == 'All' ||
          category == selectedCategory.toLowerCase();
      return matchesSearch && matchesCategory;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEFE8E2)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2C1810).withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: 'Search food (e.g. Pizza, Burger, Biryani)...',
              hintStyle: const TextStyle(
                color: Color(0xFF9E8E87),
                fontSize: 14,
              ),
              prefixIcon: Icon(Icons.search_rounded, color: themePrimary),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 20),
                      onPressed: () {
                        searchController.clear();
                        setState(() {});
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((cat) {
              final isSelected = selectedCategory == cat;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(cat),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      selectedCategory = cat;
                    });
                  },
                  selectedColor: themePrimary,
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF4A342B),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 13,
                  ),
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: isSelected ? themePrimary : const Color(0xFFE5DDD6),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 18),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Showing ${filteredFoods.length} items',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF786259),
              ),
            ),
            if (searchController.text.isNotEmpty || selectedCategory != 'All')
              GestureDetector(
                onTap: () {
                  setState(() {
                    searchController.clear();
                    selectedCategory = 'All';
                  });
                },
                child: Text(
                  'Reset Filters',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: themePrimary,
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: 14),

        if (filteredFoods.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredFoods.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.isMobile
                  ? 2
                  : widget.isTablet
                  ? 3
                  : 4,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,

              childAspectRatio: widget.isMobile
                  ? 0.90
                  : widget.isTablet
                  ? 1.02
                  : 1.10,
            ),
            itemBuilder: (context, index) {
              final food = filteredFoods[index];
              return FoodCard(
                foodName: food['name'],
                category: food['category'],
                icon: food['icon'],
                imageUrl: food['image'],
                price: food['price'],
                rating: food['rating'],
              );
            },
          ),

        if (filteredFoods.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFEFE8E2)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF800020).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.search_off_rounded,
                    size: 48,
                    color: Color(0xFF800020),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'No food available',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C1810),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'No matching dishes found for "$searchText".\nTry checking the spelling or resetting filters.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF786259),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      searchController.clear();
                      selectedCategory = 'All';
                    });
                  },
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: const Text('View All Menu'),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class FoodCard extends StatelessWidget {
  final String foodName;
  final String category;
  final int price;
  final IconData icon;
  final String? imageUrl;
  final double rating;

  const FoodCard({
    super.key,
    required this.foodName,
    required this.category,
    required this.price,
    required this.icon,
    this.imageUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE8E2), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C1810).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (imageUrl != null && imageUrl!.isNotEmpty)
                  Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFF800020).withValues(alpha: 0.08),
                      child: Center(
                        child: Icon(
                          icon,
                          size: 36,
                          color: const Color(0xFF800020),
                        ),
                      ),
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: const Color(0xFFFAF7F5),
                        child: Center(
                          child: Icon(
                            icon,
                            size: 32,
                            color: const Color(0xFF800020)
                                .withValues(alpha: 0.4),
                          ),
                        ),
                      );
                    },
                  )
                else
                  Container(
                    color: const Color(0xFF800020).withValues(alpha: 0.08),
                    child: Center(
                      child: Icon(
                        icon,
                        size: 36,
                        color: const Color(0xFF800020),
                      ),
                    ),
                  ),

                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.12),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.20),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.94),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: Color(0xFF800020),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          category,
                          style: const TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF5A433A),
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.94),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFD97706),
                          size: 12,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB45309),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  foodName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C1810),
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '₹$price',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF800020),
                        letterSpacing: -0.5,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: () {
                          CartManager().addItem(
                            foodName,
                            price,
                            icon,
                            imageUrl: imageUrl,
                          );
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '$foodName added to cart!',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: const Color(0xFF2C1810),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF800020), Color(0xFF9E1B32)],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF800020)
                                    .withValues(alpha: 0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 1.5),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_rounded,
                                size: 15,
                                color: Colors.white,
                              ),
                              SizedBox(width: 2),
                              Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RecentOrders extends StatelessWidget {
  const RecentOrders({super.key});

  static Color getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return const Color(0xFF15803D);
      case 'Preparing':
        return const Color(0xFFB45309);
      case 'Cancelled':
        return const Color(0xFFBE123C);
      case 'Out for Delivery':
        return const Color(0xFF1D4ED8);
      case 'Pending':
        return const Color(0xFF800020);
      default:
        return const Color(0xFF786259);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> orders = [
      {
        'id': '#1001',
        'food': 'Margherita Pizza + Coke',
        'status': 'Delivered',
        'customer': 'Rahul Verma',
        'time': '10:30 AM',
        'amount': '₹299',
        'image': 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=500&auto=format&fit=crop&q=60',
      },
      {
        'id': '#1002',
        'food': 'Classic Cheeseburger + Fries',
        'status': 'Preparing',
        'customer': 'Pooja Hegde',
        'time': '11:15 AM',
        'amount': '₹249',
        'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500&auto=format&fit=crop&q=60',
      },
      {
        'id': '#1003',
        'food': 'Creamy Alfredo Pasta + Garlic Bread',
        'status': 'Delivered',
        'customer': 'Aman Gupta',
        'time': '11:45 AM',
        'amount': '₹359',
        'image': 'https://images.unsplash.com/photo-1546549032-9571cd6b27df?w=600&auto=format&fit=crop&q=80',
      },
      {
        'id': '#1004',
        'food': 'Hyderabadi Dum Biryani + Raita',
        'status': 'Cancelled',
        'customer': 'Vikas Malhotra',
        'time': '12:00 PM',
        'amount': '₹399',
        'image': 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=600&auto=format&fit=crop&q=80',
      },
      {
        'id': '#1005',
        'food': 'Chicken Tikka Kebab + Butter Naan',
        'status': 'Out for Delivery',
        'customer': 'Sneha Kapoor',
        'time': '12:20 PM',
        'amount': '₹429',
        'image': 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600&auto=format&fit=crop&q=80',
      },
      {
        'id': '#1006',
        'food': 'Choco Lava Cake + Brownie Sundae',
        'status': 'Preparing',
        'customer': 'Karan Johar',
        'time': '12:35 PM',
        'amount': '₹269',
        'image': 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=600&auto=format&fit=crop&q=80',
      },

      {
        'id': '#1007',
        'food': 'Paneer Tikka Roll + Masala Lemonade',
        'status': 'Pending',
        'customer': 'Rohit Sharma',
        'time': '12:45 PM',
        'amount': '₹239',
        'image': 'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?w=600&auto=format&fit=crop&q=80',
      },

      {
        'id': '#1008',
        'food': 'Loaded Mexican Tacos + Salsa Dip',
        'status': 'Preparing',
        'customer': 'Ananya Roy',
        'time': '01:10 PM',
        'amount': '₹289',
        'image': 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=500&auto=format&fit=crop&q=60',
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final order = orders[index];
        final statusColor = getStatusColor(order['status']!);

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFEFE8E2)),
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailsScreen(
                      orderId: order['id']!,
                      foodName: order['food']!,
                      status: order['status']!,
                      customer: order['customer'] ?? 'Customer',
                      time: order['time'] ?? 'Just now',
                      amount: order['amount'] ?? '₹299',
                      imageUrl: order['image'],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: statusColor.withValues(alpha: 0.12),
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Order ${order['id']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFF2C1810),
                              ),
                              children: [
                                TextSpan(
                                  text: '  • ${order['time']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11,
                                    color: Color(0xFF9E8E87),
                                  ),
                                ),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            order['food']!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF5A433A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            order['status']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: statusColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          order['amount'] ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2C1810),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF9E8E87),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DashboardContent extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;
  final VoidCallback? onCartPressed;

  const DashboardContent({
    super.key,
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
    this.onCartPressed,
  });

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour < 17) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }

  IconData _getGreetingIcon() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return Icons.wb_sunny_rounded;
    } else if (hour < 17) {
      return Icons.wb_sunny_outlined;
    } else {
      return Icons.nights_stay_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themePrimary = Theme.of(context).primaryColor;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _getGreetingIcon(),
                            color: const Color(0xFFB45309),
                            size: isMobile ? 22 : 28,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              _getGreeting(),
                              style: TextStyle(
                                fontSize: isMobile ? 22 : 30,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF2C1810),
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Welcome back to your FlavorCraft kitchen dashboard',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF786259),
                        ),
                      ),
                    ],
                  ),
                ),

                if (!isMobile) ...[
                  ValueListenableBuilder<int>(
                    valueListenable: CartManager().totalCountNotifier,
                    builder: (context, count, child) {
                      return ElevatedButton.icon(
                        onPressed: onCartPressed,
                        icon: Badge(
                          isLabelVisible: count > 0,
                          label: Text('$count'),
                          backgroundColor: Colors.white,
                          textColor: themePrimary,
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            size: 20,
                          ),
                        ),
                        label: Text(
                          count > 0 ? 'Cart ($count)' : 'Cart',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 14),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: themePrimary.withValues(alpha: 0.12),
                    child: Icon(Icons.person, color: themePrimary, size: 22),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'Popular Dishes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C1810),
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 14),

            FoodGrid(isMobile: isMobile, isTablet: isTablet),

            const SizedBox(height: 34),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Text(
                    'Recent Orders',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C1810),
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (!isMobile)
                  Text(
                    'Tap order for details',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 14),

            const RecentOrders(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  final String foodName;
  final String status;
  final String customer;
  final String time;
  final String amount;
  final String? imageUrl;

  const OrderDetailsScreen({
    super.key,
    required this.orderId,
    required this.foodName,
    required this.status,
    required this.customer,
    required this.time,
    required this.amount,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = RecentOrders.getStatusColor(status);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F5),
      appBar: AppBar(
        title: Text('Order Details ($orderId)'),
        backgroundColor: const Color(0xFFFAF7F5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFEFE8E2)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2C1810).withValues(alpha: 0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      if (imageUrl != null && imageUrl!.isNotEmpty)
                        SizedBox(
                          height: 160,
                          width: double.infinity,
                          child: Image.network(
                            imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox.shrink(),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                status == 'Delivered'
                                    ? Icons.check_circle_rounded
                                    : status == 'Preparing'
                                    ? Icons.outdoor_grill_rounded
                                    : status == 'Cancelled'
                                    ? Icons.cancel_rounded
                                    : Icons.delivery_dining_rounded,
                                size: 44,
                                color: statusColor,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'Order $orderId',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C1810),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                status,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: statusColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFEFE8E2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order Summary',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C1810),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildDetailRow(
                        Icons.fastfood_rounded,
                        'Food Item',
                        foodName,
                      ),
                      const Divider(height: 24, color: Color(0xFFEFE8E2)),
                      _buildDetailRow(
                        Icons.person_rounded,
                        'Customer',
                        customer,
                      ),
                      const Divider(height: 24, color: Color(0xFFEFE8E2)),
                      _buildDetailRow(
                        Icons.access_time_rounded,
                        'Order Time',
                        time,
                      ),
                      const Divider(height: 24, color: Color(0xFFEFE8E2)),
                      _buildDetailRow(
                        Icons.currency_rupee_rounded,
                        'Total Amount',
                        amount,
                        isBold: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text(
                    'Go Back',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value, {
    bool isBold = false,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF786259)),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Color(0xFF786259)),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: isBold ? const Color(0xFF800020) : const Color(0xFF2C1810),
          ),
        ),
      ],
    );
  }
}

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themePrimary = Theme.of(context).primaryColor;

    final List<Map<String, dynamic>> offers = [
      {
        'title': '50% OFF up to ₹150',
        'code': 'FLAVOR50',
        'desc': 'Valid on all pizza and burger orders above ₹299.',
        'color': const Color(0xFF800020),
        'icon': Icons.local_pizza_rounded,
      },
      {
        'title': 'Flat 20% Discount',
        'code': 'TASTY20',
        'desc': 'Special weekday discount on full menu dishes.',
        'color': const Color(0xFF78350F),
        'icon': Icons.lunch_dining_rounded,
      },
      {
        'title': 'Free Express Delivery',
        'code': 'FREESHIP',
        'desc': 'Enjoy zero delivery fees on orders above ₹199.',
        'color': const Color(0xFF92400E),
        'icon': Icons.delivery_dining_rounded,
      },
      {
        'title': 'Buy 1 Get 1 Dessert',
        'code': 'SWEETTREAT',
        'desc': 'Order any dessert and get one Choco Lava free.',
        'color': const Color(0xFF9F1239),
        'icon': Icons.cake_rounded,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F5),
      appBar: AppBar(
        title: const Text('Exclusive Offers & Deals'),
        backgroundColor: const Color(0xFFFAF7F5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: offers.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final offer = offers[index];
          final Color cardColor = offer['color'];

          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: cardColor.withValues(alpha: 0.3)),
              boxShadow: [
                BoxShadow(
                  color: cardColor.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: cardColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(offer['icon'], size: 30, color: cardColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C1810),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        offer['desc'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF786259),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAF7F5),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFE5DDD6),
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: Text(
                              offer['code'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: cardColor,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Coupon code "${offer['code']}" applied!',
                                  ),
                                  backgroundColor: themePrimary,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            icon: const Icon(Icons.copy_rounded, size: 14),
                            label: const Text('Apply Code'),
                            style: TextButton.styleFrom(
                              foregroundColor: cardColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CartBottomSheet extends StatefulWidget {
  const CartBottomSheet({super.key});

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final cart = CartManager();
    final themePrimary = Theme.of(context).primaryColor;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Order Cart',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C1810),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(color: Color(0xFFEFE8E2)),
            if (cart.items.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Text(
                    'Your cart is empty.\nAdd delicious dishes from the menu!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF786259)),
                  ),
                ),
              )
            else ...[
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 280),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: cart.items.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 12, color: Color(0xFFEFE8E2)),
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: 44,
                            height: 44,
                            child: item.imageUrl != null
                                ? Image.network(
                                    item.imageUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                              color: const Color(0xFF800020)
                                                  .withValues(alpha: 0.1),
                                              child: Icon(
                                                item.icon,
                                                color: themePrimary,
                                                size: 22,
                                              ),
                                            ),
                                  )
                                : Container(
                                    color: const Color(0xFF800020)
                                        .withValues(alpha: 0.1),
                                    child: Icon(
                                      item.icon,
                                      color: themePrimary,
                                      size: 22,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Color(0xFF2C1810),
                                ),
                              ),
                              Text(
                                '₹${item.price}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF786259),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              cart.removeItem(item.name);
                            });
                          },
                        ),
                        Text(
                          '${item.quantity}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C1810),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline, size: 20),
                          onPressed: () {
                            setState(() {
                              cart.addItem(
                                item.name,
                                item.price,
                                item.icon,
                                imageUrl: item.imageUrl,
                              );
                            });
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              const Divider(height: 20, color: Color(0xFFEFE8E2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C1810),
                    ),
                  ),
                  Text(
                    '₹${cart.totalAmount}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF800020),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  cart.clearCart();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Order placed successfully! Kitchen notified.',
                      ),
                      backgroundColor: Color(0xFF800020),
                    ),
                  );
                },
                child: const Text(
                  'Confirm & Place Order',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String title;

  const DetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F5),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFFAF7F5),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF800020).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.outdoor_grill_sharp,
                  size: 60,
                  color: Color(0xFF800020),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '$title Screen',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C1810),
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
