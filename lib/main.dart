import 'dart:async';
import 'package:decorated_icon/decorated_icon.dart';
import 'dart:typed_data';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as UI;
import 'package:image/image.dart' as img;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UI.Image? image;

  var image1;

  Future<UI.Image> getUiImage() async {
    final ByteData assetImageByteData =
        await rootBundle.load("assets/images/test.png");
    img.Image? baseSizeImage =
        img.decodeImage(assetImageByteData.buffer.asUint8List());
    img.Image resizeImage = img.copyResize(baseSizeImage!);
    UI.Codec codec = await UI.instantiateImageCodec(img.encodePng(resizeImage));
    UI.FrameInfo frameInfo = await codec.getNextFrame();
    image = frameInfo.image;
    return frameInfo.image;
  }

  Future<UI.Image> _loadImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final codec = await UI.instantiateImageCodec(data.buffer.asUint8List(),
        allowUpscaling: false);
    var frame = await codec.getNextFrame();
    image = frame.image;
    return frame.image;
  }

  @override
  void initState() {
    _loadImage("assets/images/test.png");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.black,
          child: Stack(
            children: [
              CustomPaint(
                painter: Chevron(),
                child: SizedBox(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02),
                          child: SizedBox(
                              height: 100,
                              width: 200,
                              child: Image.asset("assets/images/logo.png")),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Text("Juggle Challenge",
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: const Text("12:34",
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ClipPath(
                  clipper: _CustomClipper(),
                  child: Container(
                    child: Image.asset(
                      "assets/images/test.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ClipPath(
                  clipper: _CustomClipper4(),
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ClipPath(
                    clipper: _CustomClipper3(),
                    child: SizedBox(
                        height: 50,
                        width: 100,
                        child: Image.asset(
                          "assets/images/shoes.png",
                          fit: BoxFit.fill,
                        ))),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.82 + 10,
                    left: MediaQuery.of(context).size.width * 0.35 - 10),
                child: const Text(
                  "13",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.82 + 10,
                    left: MediaQuery.of(context).size.width * 0.60 + 10),
                child: const Text(
                  "5",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.82 + 10 + 10,
                    left: MediaQuery.of(context).size.width * 0.42),
                child: const Text(
                  "Juggles",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.95,
                    left: MediaQuery.of(context).size.width * 0.05),
                child: const SizedBox(
                  height: 25,
                  child: Icon(
                    Icons.stadium,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.95,
                    left: MediaQuery.of(context).size.width * 0.20),
                child: const DecoratedIcon(
                  Icons.stadium_rounded,
                  color: Colors.white,
                  size: 25.0,
                  shadows: [
                    BoxShadow(
                      blurRadius: 60.0,
                      color: Colors.redAccent,
                    ),
                    BoxShadow(
                      blurRadius: 12.0,
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.95,
                    left: MediaQuery.of(context).size.width * 0.35),
                child: const DecoratedIcon(
                  Icons.star,
                  color: Colors.white,
                  size: 25.0,
                  shadows: [
                    BoxShadow(
                      blurRadius: 60.0,
                      color: Colors.redAccent,
                    ),
                    BoxShadow(
                      blurRadius: 12.0,
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.95,
                    left: MediaQuery.of(context).size.width * 0.60),
                child: const DecoratedIcon(
                  Icons.supervisor_account,
                  color: Colors.white,
                  size: 25.0,
                  shadows: [
                    BoxShadow(
                      blurRadius: 60.0,
                      color: Colors.redAccent,
                    ),
                    BoxShadow(
                      blurRadius: 12.0,
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.95,
                    left: MediaQuery.of(context).size.width * 0.75),
                child: const DecoratedIcon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 25.0,
                  shadows: [
                    BoxShadow(
                      blurRadius: 60.0,
                      color: Colors.redAccent,
                    ),
                    BoxShadow(
                      blurRadius: 12.0,
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.82,
                    left: MediaQuery.of(context).size.width - 100),
                child: Material(
                  color: Colors.black,
                  clipBehavior: Clip.antiAlias,
                  shape: const BeveledRectangleBorder(
                      // side: BorderSide(color: Colors.blue), if you need
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(20.0))),
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      // borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Image.asset(
                      "assets/images/shoes.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.82),
                child: Material(
                  color: Colors.black,
                  clipBehavior: Clip.antiAlias,
                  shape: const BeveledRectangleBorder(
                      // side: BorderSide(color: Colors.blue), if you need
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(20.0))),
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      // borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Image.asset(
                      "assets/images/baby.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Chevron extends CustomPainter {
  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final Paint paint = Paint()..color = Colors.red;
    // ..shader = gradient.createShader(colorBounds);

    Path path = Path();

    path.moveTo(0, size.height * 0.2);

    // path.lineTo(x, y)
    // path.lineTo(150, 0);
    // path.lineTo(200, 50);
    // path.lineTo(300, 50);
    // path.lineTo(350, 0);
    // path.lineTo(100, 10);
    path.lineTo(size.width * 0.3, size.height * 0.2);
    path.lineTo(size.width * 0.4, size.height * 0.25);
    path.lineTo(size.width * 0.6, size.height * 0.25);
    path.lineTo(size.width * 0.7, size.height * 0.2);
    path.lineTo(size.width, size.height * 0.2);
    path.lineTo(size.width, size.height * 0.9);
    path.lineTo(size.width * 0.6, size.height * 0.9);
    path.lineTo(size.width * 0.5, size.height * 0.95);
    path.lineTo(size.width * 0.4, size.height * 0.9);

    path.lineTo(0, size.height * 0.9);

    // path.lineTo(size.width / 2, size.height - size.height / 2);
    // path.lineTo(0, size.height);

    // path.lineTo(size.width, size.height);

    // path.lineTo(size.width, 0);

    path.close();

    canvas.drawPath(path, paint);
    Image image = await Image.network("https://example.com/pic.png");
    Future<ImageInfo> getImageInfo(Image img) async {
      final c = Completer<ImageInfo>();
      img.image
          .resolve(const ImageConfiguration())
          .addListener(ImageStreamListener((ImageInfo i, bool _) {
        c.complete(i);
      }));
      return c.future;
    }

    // ImageInfo info = await getImageInfo(image);
    // canvas.drawImage(image, Offset(5, 3), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class Chevron2 extends CustomPainter {
  Chevron2({
    required this.image,
  });

  UI.Image? image;
  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final Paint paint = Paint();
    paint.filterQuality;

    // ..color = Colors.yellowAccent;
    // ..shader = gradient.createShader(colorBounds);

    Path path = Path();

    path.moveTo(0, size.height * 0.2 + 10);

    path.lineTo(size.width * 0.3, size.height * 0.2 + 10);
    path.lineTo(size.width * 0.4, size.height * 0.25 + 10);
    path.lineTo(size.width * 0.6, size.height * 0.25 + 10);
    path.lineTo(size.width * 0.7, size.height * 0.2 + 10);
    path.lineTo(size.width, size.height * 0.2 + 10);
    path.lineTo(size.width, size.height * 0.7);

    path.lineTo(0, size.height * 0.7);

    path.close();

    canvas.drawPath(path, paint);

    if (image != null) {
      // paintImage(
      //     canvas: canvas, rect: Rect.zero, image: image!, isAntiAlias: true);
      canvas.drawImage(image!, const Offset(5, 3), paint);
      // canvas.drawPicture(image);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

//Main Image
class _CustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height * 0.2 + 10);

    path.lineTo(size.width * 0.3, size.height * 0.2 + 10);
    path.lineTo(size.width * 0.4, size.height * 0.25 + 10);
    path.lineTo(size.width * 0.6, size.height * 0.25 + 10);
    path.lineTo(size.width * 0.7, size.height * 0.2 + 10);
    path.lineTo(size.width, size.height * 0.2 + 10);
    path.lineTo(size.width, size.height * 0.8);

    path.lineTo(0, size.height * 0.8);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

// For second Image
class _CustomClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    print("aksd");
    print(size.height * 0.80);
    path.moveTo(0, size.height * 0.82);
    path.lineTo(50, size.height * 0.82);

    path.lineTo(100, size.height * 0.82 + 25);

    path.lineTo(100, size.height * 0.82 + 50);
    path.lineTo(0, size.height * 0.82 + 50);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

//Third Image (Right Sided)
class _CustomClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width * 0.75, size.height * 0.82 + 25);
    path.lineTo(size.width * 0.75 + 25, size.height * 0.82);

    path.lineTo(size.width, size.height * 0.82);

    path.lineTo(size.width, size.height * 0.82 + 50);
    path.lineTo(size.width * 0.75, size.height * 0.82 + 50);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

//Mid Imagse
class _CustomClipper4 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width * 0.30, size.height * 0.82);

    path.lineTo(size.width * 0.70, size.height * 0.82);

    path.lineTo(size.width * 0.70, size.height * 0.82 + 50);
    path.lineTo(size.width * 0.60, size.height * 0.82 + 50);
    path.lineTo(size.width * 0.60 - 40, size.height * 0.82 + 50 + 50 - 10);
    path.lineTo(size.width * 0.40, size.height * 0.82 + 50);
    path.lineTo(size.width * 0.30, size.height * 0.82 + 50);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
