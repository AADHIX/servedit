
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import carousel_slider
import 'package:provider/provider.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => LanguageController(),
    child: const MarketingApp(),
  ),
);

class MarketingApp extends StatelessWidget {
  const MarketingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoSpace Marketing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0x00B9FF66),
        scaffoldBackgroundColor: const Color(0xF3F3F3F3),
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const LandingPage(),
    );
  }
}

class LanguageController extends ChangeNotifier {
  String _currentLanguage = 'en';
  
  String get currentLanguage => _currentLanguage;

  void setLanguage(String language) {
    _currentLanguage = language;
    notifyListeners();
  }
}





class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: ClipOval(
                child: Image.asset('assets/images/logo1.png', height: 32),
              ),
            ),
            const SizedBox(width: 8),
            const Text('AutoSpace',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(context),
            const SizedBox(height: 80),
            _buildGridSection( context, 'Our Services', services),
            const SizedBox(height: 80),
            _buildOfferCarddsSection(),// Updated Offer Cards 
            const SizedBox(height: 80),
            _buildYoutubeSection(),
            const SizedBox(height: 100),
            _buildReviewSection(),
            const SizedBox(height: 80),
            _buildMoreOffersSection(), // Updated More Offers Section with Carousel
            const SizedBox(height: 80),
            _buildFooterSection(),

          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Navigating the\n',
                      style: GoogleFonts.openSans(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'digital landscape\n',
                      style: GoogleFonts.openSans(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'for success',
                      style: GoogleFonts.openSans(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(227, 144, 240, 70),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Our digital marketing agency helps businesses\ngrow and succeed online through a range of\nservices including SEO, PPC, social media marketing.',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 1.6,
                  letterSpacing: 0.5,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/hero.png',
                    width: 670,
                    height: 670,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

 Widget _buildGridSection(BuildContext context, String title, List<Map<String, dynamic>> items) {
  if (items.isEmpty) {
    return Center(
      child: Text(
        'No services available.',
        style: GoogleFonts.inter(fontSize: 16, color: Colors.black54),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(185, 225, 255, 202),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Our comprehensive services are designed to streamline your parking experience, offering real-time information, navigation assistance, and advanced features like pre-booking and automatic entry/exit.',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: constraints.maxWidth > 600 ? 2 : 1,
              crossAxisSpacing: 30,
              mainAxisSpacing: 20,
              childAspectRatio: 2.3,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildInfoCard(
                item['title'] ?? 'No Title',
                item['icon'] as IconData? ?? Icons.info,
                item['description'] ?? 'No description available',
                item['imagePath'] ?? 'assets/cards/default.png', // Unique image for each card
              );
            },
          );
        },
      ),
    ],
  );
}

Widget _buildInfoCard(String title, IconData icon, String description, String imagePath) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade600),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 5,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Stack(
      children: [
        // Image background with BoxFit.cover
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover, // Ensures each image fully covers its container
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.black45,
              alignment: Alignment.center,
              child: const Icon(Icons.image_not_supported, color: Colors.white, size: 50),
            ),
          ),
        ),
        // Dark overlay to improve text visibility
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.6), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 32, color: Colors.greenAccent),
              const SizedBox(height: 12),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


Widget _buildYoutubeSection() {
  return Consumer<LanguageController>(
    builder: (context, languageController, child) {
      // Define video IDs for different languages
      final Map<String, String> videoIds = {
        'en': 'U5fcrFz6Ma0', // Example video ID for English
        'ml': '46IpbQ_0FUw', // Example video ID for Malayalam
      };

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(185, 225, 255, 202),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  youtubeTranslations[languageController.currentLanguage]!['channel_title']!,
                  style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  youtubeTranslations[languageController.currentLanguage]!['subscribe_text']!,
                  style: GoogleFonts.inter(fontSize: 16, color: Colors.black87),
                ),
              ),
              // Language Selector
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(185, 225, 255, 202),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: languageController.currentLanguage,
                    icon: const Icon(Icons.language, color: Colors.green),
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text('English', 
                          style: GoogleFonts.inter(fontSize: 14, color: Colors.black87)),
                      ),
                      DropdownMenuItem(
                        value: 'ml',
                        child: Text('മലയാളം', 
                          style: GoogleFonts.inter(fontSize: 14, color: Colors.black87)),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        languageController.setLanguage(newValue);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 300,
                      width: 500,
                      color: Colors.grey.shade200,
                      child: YoutubePlayerWidget(videoId: videoIds[languageController.currentLanguage]!),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      );
    },
  );
}
  Widget _buildFooterSection() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/cards/backContact.png', // Add your background image asset
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          color: const Color.fromARGB(185, 225, 255, 202).withOpacity(0.9), // Adjust opacity to blend with background
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(185, 225, 255, 202),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text('Contact Us',
                    style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              Text('Email: info@autospace.com',
                  style: GoogleFonts.inter(fontSize: 18, color: Colors.black87)),
              const SizedBox(height: 10),
              Text('Phone: +1 234 567 890',
                  style: GoogleFonts.inter(fontSize: 18, color: Colors.black87)),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey),
              const SizedBox(height: 20),
              Text('© 2023 AutoSpace. All rights reserved.',
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Row to place "Reviews" and its description side by side
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container for "Reviews" text
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(185, 225, 255, 202),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              'Reviews',
              style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16), // Add spacing between "Reviews" and description
          // Expanded widget to allow the description to take remaining space
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12), // Adjust vertical alignment
              child: Text(
                'Read what our customers have to say about their experiences with AutoSpace.',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20), // Add spacing below the row
      // Horizontal list of reviews
      SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return Container(
              width: 320,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(185, 225, 255, 202),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(185, 225, 255, 202).withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: DottedBorder(
                color: Colors.green,
                strokeWidth: 2,
                borderType: BorderType.RRect,
                radius: const Radius.circular(16),
                dashPattern: const [6, 3],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.green.shade100,
                            child: Text(
                              review['name']![0],
                              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                          const SizedBox(width: 12),
                          Text(
                            review['name'] ?? 'No Name',
                            style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        review['feedback'] ?? 'No Feedback',
                        style: GoogleFonts.inter(fontSize: 14, color: Colors.black87)),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: List.generate(5, (index) {
                          return Icon(Icons.star, color: Colors.yellow.shade700, size: 20);
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}


//-------------------//
 Widget _buildOfferCarddsSection() {
    final offers = [
      {
        'title': '50% Off on First Booking',
        'description': 'Get 50% off on your first parking slot booking.',
        'image': 'assets/cards/offer1.png',
      },
      {
        'title': 'Free Parking on Weekends',
        'description': 'Enjoy free parking on weekends for the first month.',
        'image': 'assets/cards/offer2.png',
      },
      {
        'title': 'Refer & Earn',
        'description': 'Refer a friend and earn free parking credits.',
        'image': 'assets/cards/offer3.png',
      },
      {
        'title': 'Monthly Subscription Discount',
        'description': 'Get 20% off on monthly subscription plans.',
        'image': 'assets/cards/offer4.png',
      },
    ];

    return Column(
      children: [
        const Text(
          'UPCOMING OFFERS',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        CarouselSlider.builder(
          itemCount: offers.length,
          itemBuilder: (context, index, realIndex) {
            final offer = offers[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 5,
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      image: DecorationImage(
                        image: AssetImage(offer['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withOpacity(0.3), Colors.black.withOpacity(0.7)],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          offer['title']!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          offer['description']!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 3.5,
            viewportFraction: 0.6,
          ),
        ),
      ],
    );
  }
}


//-------------------------//



  // Updated More Offers Section with Carousel Slider
  Widget _buildMoreOffersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color.fromARGB(185, 225, 255, 202),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            'More Offers',
            style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 24),
        CarouselSlider.builder(
          itemCount: moreOffers.length,
          options: CarouselOptions(
            autoPlay: true, // Enable auto-play
            enlargeCenterPage: true, // Enlarge the center page
            aspectRatio: 3.3, // Aspect ratio of the carousel
            viewportFraction: 3.3, // Fraction of the viewport to show
          ),
          itemBuilder: (context, index, realIndex) {
            final offer = moreOffers[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(offer['icon'], size: 32, color: Colors.green),
                    const SizedBox(height: 12),
                    Text(
                      offer['title'],
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      offer['description'],
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }


class YoutubePlayerWidget extends StatefulWidget {
  final String videoId;

  const YoutubePlayerWidget({super.key, required this.videoId});

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(showControls: true, showFullscreenButton: true),
    )..loadVideoById(videoId: widget.videoId);
  }

  @override
  void didUpdateWidget(YoutubePlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoId != widget.videoId) {
      _controller.loadVideoById(videoId: widget.videoId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(controller: _controller, aspectRatio: 16 / 9);
  }
}




List<Map<String, dynamic>> services = [
  {
    'title': 'Real-time Parking Info',
    'icon': Icons.directions_car,
    'description': 'Get real-time updates on parking availability.',
    'imagePath': 'assets/cards/Cardgrey.png'
  },
  {
    'title': 'Pre-Booking',
    'icon': Icons.book_online,
    'description': 'Reserve a parking spot in advance.',
    'imagePath': 'assets/cards/Cardgreen.png'
  },
  {
    'title': 'Automatic Entry & Exit',
    'icon': Icons.sensor_door,
    'description': 'Seamless parking access with automated barriers.',
    'imagePath': 'assets/cards/Cardblue.png'
  },
  {
    'title': 'Automatic ',
    'icon': Icons.sensor_door,
    'description': 'Seamless parking access with automated barriers.',
    'imagePath': 'assets/cards/Cardgreen.png'
  },
  {
    'title': 'Auto ',
    'icon': Icons.sensor_door,
    'description': 'Seamless parking access with automated barriers.',
    'imagePath': 'assets/cards/Cardgrey.png'
  },
  {
    'title': 'Auto ',
    'icon': Icons.sensor_door,
    'description': 'Seamless parking access with automated barriers.',
    'imagePath': 'assets/cards/Cardgrey.png'
  },


];


final List<Map<String, String>> reviews = [
  {'name': 'John Doe', 'feedback': 'Great SEO services!'},
  {'name': 'Rahul Smith', 'feedback': 'Social media marketing success!'},
  {'name': 'Madhu S', 'feedback': 'Social media marketing success!'},
];

// New More Offers Data
final List<Map<String, dynamic>> moreOffers = [
  {'title': 'Elecric Charging Station', 'icon': Icons.code, 'description': 'Build responsive websites.'},
  {'title': 'Subscription for Parking Slots', 'icon': Icons.phone_android, 'description': 'Develop custom mobile apps.'},
  {'title': 'Nearby Preferences', 'icon': Icons.search, 'description': 'Optimize your website for search engines.'},
  {'title': '24/7 Customer Care Support', 'icon': Icons.thumb_up, 'description': 'Engage customers via social media.'},
];


final Map<String, Map<String, String>> youtubeTranslations = {
  'en': {
    'channel_title': 'Auto Spaze Channel',
    'subscribe_text': 'Subscribe to our channel for the latest updates and tutorials.',
    'language_select': 'Select Language'
  },
  'ml': {
    'channel_title': 'ഓട്ടോ സ്പേസ് ചാനൽ',
    'subscribe_text': 'ഏറ്റവും പുതിയ അപ്ഡേറ്റുകൾക്കും ട്യൂട്ടോറിയലുകൾക്കുമായി ഞങ്ങളുടെ ചാനൽ സബ്സ്ക്രൈബ് ചെയ്യൂ.',
    'language_select': 'ഭാഷ തിരഞ്ഞെടുക്കുക'
     
  }


  
};
