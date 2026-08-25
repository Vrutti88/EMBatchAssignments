import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        backgroundColor: Colors.white,

        title: const Text(
          'Instagram',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border,
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.send_outlined,
            ),
          ),
        ],
      ),

      // =====================================================
      // FEED
      // =====================================================

      body: SingleChildScrollView(
        child: Column(
          children: [

            // =================================================
            // POST 1 - FLUTTER GRADIENT
            // =================================================

            const PostWidget(
              username: 'flutter_student',
              subtitle: 'Learning Flutter',

              title: 'Flutter',
              description: 'Build beautiful apps',

              caption:
                  'Learning Flutter one widget at a time! 🚀',

              likes: 120,

              colors: [
                Color(0xFFFFD54F),
                Color(0xFFFF7043),
                Color(0xFFE91E63),
                Color(0xFF673AB7),
              ],
            ),

            const Divider(
              height: 30,
              thickness: 8,
            ),

            // =================================================
            // POST 2 - IMAGE
            // =================================================

            const PostWidget(
              username: 'nature_pics',
              subtitle: 'Finding beauty in every moment 🌿',

              title: '',
              description: '',

              caption:
                  'A little escape into nature 🌿✨ Sometimes, all we need is a peaceful view.',

              likes: 245,

              colors: [],

              imagePath: 'assets/images/post2.jpg',
            ),

            const Divider(
              height: 30,
              thickness: 8,
            ),

            // =================================================
            // POST 3 - IMAGE
            // =================================================

            const PostWidget(
              username: 'vrutti_patil',
              subtitle: 'CSE Student',

              title: '',
              description: '',

              caption:
                  'Building something new every single day! 🔥',

              likes: 389,

              colors: [],

              imagePath: 'assets/images/post3.jpg',
            ),

            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}


// ===========================================================
// REUSABLE POST WIDGET
// ===========================================================

class PostWidget extends StatefulWidget {
  final String username;
  final String subtitle;

  final String title;
  final String description;

  final String caption;

  final int likes;

  final List<Color> colors;

  final String? imagePath;

  const PostWidget({
    super.key,

    required this.username,
    required this.subtitle,

    required this.title,
    required this.description,

    required this.caption,

    required this.likes,

    required this.colors,

    this.imagePath,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}


// ===========================================================
// POST STATE
// ===========================================================

class _PostWidgetState extends State<PostWidget> {
  late int likes;

  bool isLiked = false;

  bool isFollowing = false;


  @override
  void initState() {
    super.initState();

    likes = widget.likes;
  }


  // =========================================================
  // LIKE
  // =========================================================

  void toggleLike() {
    setState(() {
      if (isLiked) {
        likes--;
        isLiked = false;
      } else {
        likes++;
        isLiked = true;
      }
    });
  }


  // =========================================================
  // FOLLOW
  // =========================================================

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        // ===================================================
        // PROFILE SECTION
        // ===================================================

        Padding(
          padding: const EdgeInsets.all(16),

          child: Row(
            children: [

              // PROFILE IMAGE / ICON
              Container(
                width: 50,
                height: 50,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  border: Border.all(
                    width: 2,
                  ),
                ),

                child: const Icon(
                  Icons.person,
                  size: 30,
                ),
              ),

              const SizedBox(
                width: 12,
              ),

              // USERNAME
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      widget.username,

                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 3,
                    ),

                    Text(
                      widget.subtitle,

                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              // FOLLOW BUTTON
              ElevatedButton(
                onPressed: toggleFollow,

                style: ElevatedButton.styleFrom(
                  backgroundColor: isFollowing
                      ? Colors.grey.shade300
                      : Colors.blue,

                  foregroundColor: isFollowing
                      ? Colors.black
                      : Colors.white,
                ),

                child: Text(
                  isFollowing
                      ? 'Following'
                      : 'Follow',
                ),
              ),
            ],
          ),
        ),


        // ===================================================
        // POST CONTENT
        // ===================================================

        widget.imagePath != null

            // ------------------------------------------------
            // IMAGE POST
            // ------------------------------------------------

            ? SizedBox(
                width: double.infinity,

                child: Image.asset(
                  widget.imagePath!,

                  // Keep original aspect ratio
                  fit: BoxFit.contain,

                  // Image uses available width
                  width: double.infinity,
                ),
              )

            // ------------------------------------------------
            // GRADIENT POST
            // ------------------------------------------------

            : Container(
                width: double.infinity,

                height: 350,

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,

                    colors: widget.colors,
                  ),
                ),

                child: Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      const Icon(
                        Icons.code,

                        size: 100,

                        color: Colors.white,
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      Text(
                        widget.title,

                        style: const TextStyle(
                          color: Colors.white,

                          fontSize: 40,

                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      Text(
                        widget.description,

                        style: const TextStyle(
                          color: Colors.white,

                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),


        // ===================================================
        // POST ACTIONS
        // ===================================================

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),

          child: Row(
            children: [

              // LIKE
              IconButton(
                onPressed: toggleLike,

                icon: Icon(
                  isLiked
                      ? Icons.favorite
                      : Icons.favorite_border,

                  size: 30,

                  color: isLiked
                      ? Colors.red
                      : Colors.black,
                ),
              ),

              // COMMENT
              IconButton(
                onPressed: () {},

                icon: const Icon(
                  Icons.chat_bubble_outline,

                  size: 28,
                ),
              ),

              // SHARE
              IconButton(
                onPressed: () {},

                icon: const Icon(
                  Icons.send_outlined,

                  size: 28,
                ),
              ),

              const Spacer(),

              // SAVE
              IconButton(
                onPressed: () {},

                icon: const Icon(
                  Icons.bookmark_border,

                  size: 28,
                ),
              ),
            ],
          ),
        ),


        // ===================================================
        // LIKE COUNT
        // ===================================================

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),

          child: Text(
            '$likes likes',

            style: const TextStyle(
              fontSize: 16,

              fontWeight: FontWeight.bold,
            ),
          ),
        ),


        const SizedBox(
          height: 8,
        ),


        // ===================================================
        // CAPTION
        // ===================================================

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),

          child: RichText(
            text: TextSpan(
              children: [

                TextSpan(
                  text: widget.username,

                  style: const TextStyle(
                    color: Colors.black,

                    fontWeight: FontWeight.bold,

                    fontSize: 15,
                  ),
                ),

                TextSpan(
                  text: ' ${widget.caption}',

                  style: const TextStyle(
                    color: Colors.black,

                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),


        const SizedBox(
          height: 15,
        ),


        // ===================================================
        // LIKE BUTTON
        // ===================================================

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),

          child: SizedBox(
            width: double.infinity,

            child: ElevatedButton.icon(
              onPressed: toggleLike,

              icon: Icon(
                isLiked
                    ? Icons.favorite
                    : Icons.favorite_border,

                color: isLiked
                    ? Colors.red
                    : null,
              ),

              label: Text(
                isLiked
                    ? 'Liked'
                    : 'Like this post',
              ),
            ),
          ),
        ),


        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}