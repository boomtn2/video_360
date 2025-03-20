import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:video_360/video_360.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Video360Controller? controller;

  String durationText = '';
  String totalText = '';

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video 360 Plugin example app'),
      ),
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Video360View(
                url:
              'https://video3.mobion.vn/uploads/2025/03/13/1741860442226/7d502bd003d5_abr.m3u8' ,               onVideo360ViewCreated: _onVideo360ViewCreated,
                onPlayInfo: (Video360PlayInfo info) {
                  setState(() {
                    durationText = info.duration.toString();
                    totalText = info.total.toString();
                  });
                },
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      controller?.play();
                    },
                    color: Colors.grey[100],
                    child: const Text('Play'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller?.stop();
                    },
                    color: Colors.grey[100],
                    child: const Text('Stop'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller?.reset();
                    },
                    color: Colors.grey[100],
                    child: const Text('Reset'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller?.jumpTo(80000);
                    },
                    color: Colors.grey[100],
                    child: const Text('1:20'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      controller?.seekTo(-2000);
                    },
                    color: Colors.grey[100],
                    child: const Text('<<'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller?.seekTo(2000);
                    },
                    color: Colors.grey[100],
                    child: const Text('>>'),
                  ),
                  Flexible(
                    child: MaterialButton(
                      onPressed: () {},
                      color: Colors.grey[100],
                      child: Text('$durationText / $totalText'),
                    ),
                  ),
                ],
              ),
              Row(
                children:[
                  MaterialButton(
                    onPressed: () {
                      controller?.scrollCamera(false, 0,30);
                    },
                    color: Colors.grey[100],
                    child: const Text('>>'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      fakeSwipe(context);                    },
                    color: Colors.grey[100],
                    child: const Text('<<'),
                  ),

                ]
              )
            ],
          )
        ],
      ),
    );
  }

  double x = 10;
  double y = 20;

  // void rolationCamera(){
  //   setState(){
  //     x +=10;
  //     y +=20;
  //   }
  //
  // }
  void fakeSwipe(BuildContext context, {double dx = -100, double dy = 0}) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset start = box.localToGlobal(Offset(box.size.width / 2, box.size.height / 2));
    final Offset end = start.translate(dx, dy);

    final PointerEvent down = PointerDownEvent(position: start);
    final PointerEvent move = PointerMoveEvent(position: end);
    final PointerEvent up = PointerUpEvent(position: end);

    GestureBinding.instance.handlePointerEvent(down);
    GestureBinding.instance.handlePointerEvent(move);
    GestureBinding.instance.handlePointerEvent(up);
  }
  void _onVideo360ViewCreated(Video360Controller controller) {
    this.controller = controller;
    this.controller?.play();
  }
}
