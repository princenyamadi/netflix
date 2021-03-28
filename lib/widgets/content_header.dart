import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/models/content_model.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class ContentHeader extends StatefulWidget {
  final Content featuredContent;

  const ContentHeader({Key key, this.featuredContent}) : super(key: key);

  @override
  _ContentHeaderState createState() => _ContentHeaderState();
}

class _ContentHeaderState extends State<ContentHeader> {
  VideoPlayerController _videoController;
  bool isMuted = true;
  bool isPlaying = true;
  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/images/ul.mp4')
      ..initialize().then((_) => setState(() {}))
      ..setVolume(0)
      ..play()
      ..setLooping(true);
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoController.value.isPlaying
          ? _videoController.pause()
          : _videoController.play(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          _videoController.value.initialized
              ? AspectRatio(
                  aspectRatio: 4 / 3,
                  child: VideoPlayer(_videoController),
                )
              : Container(
                  height: 500.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.featuredContent.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          Container(
            height: 500.0,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
              bottom: 110.0,
              child: SizedBox(
                width: 250.0,
                child: Text(
                  'RWANDA IS CLEAN',
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                ),
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VerticalIconButton(
                  icon: Icons.add,
                  title: 'List',
                  onTap: () => print('My list'),
                ),
                // GestureDetector(
                //   onTap: () => setState(() {
                //     isPlaying = !isPlaying;
                //     _videoController.value.isPlaying
                //         ? _videoController.pause()
                //         : _videoController.play();
                //   }),
                //   child: _PlayButton(
                //     isPlaying: isPlaying,
                //   ),
                // ),
                VerticalIconButton(
                  icon: Icons.info_outline,
                  title: 'List',
                  onTap: () => print('My list'),
                ),
              ],
            ),
          ),
          Positioned(
            top: 110,
            right: 20,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isMuted = !isMuted;
                  isMuted
                      ? _videoController.setVolume(0)
                      : _videoController.setVolume(100);
                });
              },
              child: Icon(
                isMuted ? Icons.volume_off : Icons.volume_up,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  final bool isPlaying;

  const _PlayButton({Key key, this.isPlaying}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0),
        child: TextButton.icon(
          onPressed: () => print('Play'),
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            size: 30.0,
            color: Colors.black,
          ),
          label: Text(
            isPlaying ? 'Pause' : 'Play',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
