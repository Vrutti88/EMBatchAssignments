import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(const ArcadeLaunch());

class ArcadeLaunch extends StatelessWidget {
  const ArcadeLaunch({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xFF0D0E15)),
    home: const LaunchpadScreen(),
  );
}

class LaunchpadScreen extends StatefulWidget {
  const LaunchpadScreen({super.key});
  @override
  State<LaunchpadScreen> createState() => _LaunchpadScreenState();
}
class _LaunchpadScreenState extends State<LaunchpadScreen> {
  int credits = 3, power = 85;
  bool turbo = false;
  void _launch() {
    if (credits < 1) return;
    setState(() => credits--);
    Navigator.push(context, MaterialPageRoute(builder: (_) => GameScreen(power: power)));
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('ARCADE LAUNCH', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2)),
      actions: [
        Center(child: Text('🪙 $credits CREDITS', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.cyanAccent))), Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: ClipOval(child: CachedNetworkImage(imageUrl: 'https://images.unsplash.com/photo-1566492031773-4f4e44671857?w=200', width: 34, height: 34, fit: BoxFit.cover, placeholder: (c, u) => const CircularProgressIndicator(strokeWidth: 2), errorWidget: (c, u, e) => const Icon(Icons.person, color: Colors.cyanAccent)))),
      ],
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: const Color(0xFF161926), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)),
          child: Row(children: [
            ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset('assets/game_icon.png', width: 48, height: 48, fit: BoxFit.cover)),
            const SizedBox(width: 12),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('NEON STRIKER V2', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), Text('STAGE 01 // ONLINE', style: TextStyle(color: Colors.cyanAccent, fontSize: 11))])),
            ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network('https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=200', width: 48, height: 48, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.shield, color: Colors.cyanAccent))),
          ]),
        ),
        const SizedBox(height: 14),
        Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(color: const Color(0xFF161926), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(width: 54, height: 54, child: Lottie.asset('assets/arcade.json')),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('CORE: $power% POWER', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.amberAccent)), Text(turbo ? 'OVERDRIVE ⚡' : 'STANDARD MODE', style: const TextStyle(fontSize: 12, color: Colors.white70))]),
            IconButton(icon: Icon(turbo ? Icons.bolt : Icons.flash_off, color: Colors.amberAccent), onPressed: () => setState(() { turbo = !turbo; power = turbo ? 100 : 85; })),
          ]),
        ),
        const SizedBox(height: 16),
        Hero(tag: 'arcadeHero',
          child: Container(
            height: 72, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.purpleAccent, Colors.cyanAccent]), borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: Colors.cyanAccent.withValues(alpha: 0.3), blurRadius: 16)]),
            child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent), onPressed: _launch, icon: const Icon(Icons.rocket_launch, size: 28, color: Colors.black), label: const Text('LAUNCH BATTLE', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 2))),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(onPressed: () => setState(() => credits += 2), icon: const Icon(Icons.add_circle_outline, color: Colors.cyanAccent), label: const Text('INSERT COIN (+2 CREDITS)', style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold))),
      ]),
    ),
  );
}
class GameScreen extends StatefulWidget {
  final int power;
  const GameScreen({super.key, required this.power});
  @override
  State<GameScreen> createState() => _GameScreenState();
}
class _GameScreenState extends State<GameScreen> {
  int score = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF08090E),
    appBar: AppBar(title: const Text('LIVE ARENA'), backgroundColor: Colors.transparent),
    body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Hero(tag: 'arcadeHero',
          child: Container(
            width: 140, height: 140, decoration: BoxDecoration(shape: BoxShape.circle, gradient: const RadialGradient(colors: [Colors.cyanAccent, Colors.purpleAccent]), boxShadow: [BoxShadow(color: Colors.cyanAccent.withValues(alpha: 0.4), blurRadius: 25)]),
            child: const Icon(Icons.sports_esports, size: 70, color: Colors.black),
          ),
        ),
        const SizedBox(height: 24),
        Text('SCORE: $score', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.cyanAccent, letterSpacing: 2)),
        Text('CORE OUTPUT: ${widget.power} GW', style: const TextStyle(color: Colors.amberAccent, letterSpacing: 1)),
        const SizedBox(height: 28),
        FilledButton.icon(onPressed: () => setState(() => score += 100), icon: const Icon(Icons.bolt, color: Colors.black), label: const Text('FIRE LASER (+100)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      ]),
    ),
  );
}