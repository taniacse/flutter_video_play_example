import 'dart:async';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player Demo',
      home: VideoPlayerNormal(),
    );
  }
}
// This widget just for play a normal video
class VideoPlayerNormal extends StatefulWidget {
  VideoPlayerNormal({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerNormal> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      'https://vdo.bdjobs.com/Videos/Corporate//909911/185264754/185264754_2.webm',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);


    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Butterfly Video'),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return
              // Use the VideoPlayer widget to display the video.
             Center(
               child: Column(
                 children: [
                   Container(
                        height: 200,
                        width: double.maxFinite,
                        child: VideoPlayer(_controller)),
                   RaisedButton(onPressed: () {
                     _controller.setVolume(.50);


                   },)
                 ],
               ),
             );

          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

  // This Widget for making custom video view
class SamplePlayerWithFlick extends StatefulWidget {
  SamplePlayerWithFlick({Key key}) : super(key: key);

  @override
  _SamplePlayerState createState() => _SamplePlayerState();
}

class _SamplePlayerState extends State<SamplePlayerWithFlick> {
  FlickManager flickManager;
  var office_url = 'https://vdo.bdjobs.com/Videos/Corporate//909911/185264754/185264754_2.webm';
  var new_url = 'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4';
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
      VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Play Example'),
      ),
      body: Center(
        child: Container(
          child: Container(
            height: 300,
            width: 500,
            child: FlickVideoPlayer(
                flickManager: flickManager
            ),
          ),
        ),
      ),
    );
  }
}