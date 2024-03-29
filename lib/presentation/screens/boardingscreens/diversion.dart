import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesneak/admin/presentation/adminlogin/adminlogin.dart';
import 'package:shoesneak/presentation/screens/auth/loginscreen.dart';
import 'package:shoesneak/presentation/widget/widgets.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() async {
    // ignore: deprecated_member_use
    _controller = VideoPlayerController.network(
      'https://player.vimeo.com/progressive_redirect/playback/454789471/rendition/720p/file.mp4?loc=external&oauth2_token_id=1747418641&signature=5d6d271835ca447ee8be9b7c719ce76dbd68cf05306f97bb3b04f3a1cabe3fc9',
    );

    try {
      await _controller.initialize();
      _controller.setLooping(true);
      _controller.play();
      setState(() {
        _isInitialized = true;
      });
    } catch (error) {
      print('Error initializing video: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              width: double.infinity,
              height: double.infinity,
              child: _isInitialized
                  ? AspectRatio(
                      aspectRatio: screenSize.width / screenSize.height,
                      child: VideoPlayer(_controller),
                    )
                  : const CircularProgressIndicator(),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [
                    Colors.black.withOpacity(0.9), // Start color
                    Colors.transparent, // End color (transparent)
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/nike-logo-15-3.png',
                        height: 90,
                        width: 90,
                      ),
                      Text(
                        "Free delivery, Members-only\nproducts, the best of Nike,\npersonalized for you.",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 23,
                            letterSpacing: 1),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      text: 'Admin',
                      onPressed: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const                             Adminlogin(),
                            ));
                      },
                    ),
                    const SizedBox(width: 40),
                    CustomButton(
                      text: 'User',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40)
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
