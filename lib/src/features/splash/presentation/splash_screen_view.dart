import 'dart:async';
import 'dart:io';

import 'package:algo_pilates/src/features/home/presentation/home_view.dart';
import 'package:algo_pilates/src/features/home/presentation/widget/custom_button.dart';
import 'package:algo_pilates/src/features/home/provider/home_provider.dart';
import 'package:algo_pilates/src/utilities/utilities.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pod_player/pod_player.dart';
import 'package:provider/provider.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/route_services.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});
  static String route = 'splash';
  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> with TickerProviderStateMixin {
  AnimationController? _progressController;
  bool _showMedia = false;
  PodPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {});
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigateAfterDelay());
  }

  @override
  void dispose() {
    super.dispose();
    _progressController?.dispose();
    _videoPlayerController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final splashMedia = context.watch<HomeProvider>().homeModel?.splashData;
    return Scaffold(
      appBar: _showMedia ? AppBar(toolbarHeight: 0, backgroundColor: Colors.black) : null,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(child: SvgPicture.asset(AppImages.logoSvg)),
          if (_showMedia && splashMedia != null)
            Column(
              children: [
                if (_progressController != null)
                  AnimatedBuilder(
                    animation: _progressController!,
                    builder: (context, _) {
                      return Container(
                        decoration: BoxDecoration(border: Border.all(color: AppColors.textColor, width: 0.2)),
                        child: LinearProgressIndicator(
                          value: _progressController!.value,
                          color: AppColors.iconColor,
                          backgroundColor: AppColors.backgroundColor,
                        ),
                      );
                    },
                  ),
                Expanded(
                  child:
                      splashMedia.type == 'video'
                          ? AspectRatio(
                            aspectRatio: 9 / 16,
                            child: InkWell(
                              onTap: () {
                                if (_videoPlayerController!.isInitialised) {
                                  if (_videoPlayerController!.isMute) {
                                    _videoPlayerController!.unMute();
                                  } else {
                                    _videoPlayerController!.mute();
                                  }
                                }
                              },
                              child: PodVideoPlayer(
                                controller: _videoPlayerController!,
                                videoAspectRatio: 9 / 16,
                                frameAspectRatio: 9 / 16,
                                podProgressBarConfig: PodProgressBarConfig(
                                  playingBarColor: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                  circleHandlerColor: Colors.transparent,
                                ),
                                alwaysShowProgressBar: false,
                                overlayBuilder: (overlayBuilder) {
                                  return const SizedBox.shrink(); // removes all overlay controls
                                },
                              ),
                            ),
                          )
                          : SizedBox.expand(child: CachedNetworkImage(imageUrl: splashMedia.mediaUrl!, fit: BoxFit.cover)),
                ),
              ],
            ),
          if (_showMedia && splashMedia != null && ((splashMedia.type == 'video') || splashMedia.type == 'image'))
            Positioned(
              top: 16,
              right: 16,
              child: CustomButton(
                title: "\t\tSKIP",
                onTap: () {
                  _hasNavigated = true;
                  context.goNamed(HomeView.route);
                },
              ),
            ),
        ],
      ),
    );
  }

  bool _hasNavigated = false;

  Future<void> _navigateAfterDelay() async {
    final stopwatch = Stopwatch()..start();

    final provider = context.read<HomeProvider>();
    await provider.getJsons();

    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final version = Version.parse(packageInfo.version);

      final androidVersion = Version.parse(normalizeVersion(provider.homeModel!.version!.androidVersion!));
      final iosVersion = Version.parse(normalizeVersion(provider.homeModel!.version!.iosVersion!));

      if (Platform.isAndroid && androidVersion > version) {
        await showVersionAlertDialog(provider.homeModel!.version!.isAndroidUpdateMandatory!, provider.homeModel!.version!.androidLink!);
      }
      if (Platform.isIOS && iosVersion > version) {
        await showVersionAlertDialog(provider.homeModel!.version!.isIosUpdateMandatory!, provider.homeModel!.version!.iosLink!);
      }
    } catch (e) {
      debugPrint("Version check failed: $e");
    }

    stopwatch.stop();
    final remainingTime = 2000 - stopwatch.elapsedMilliseconds;
    if (remainingTime > 0) {
      await Future.delayed(Duration(milliseconds: remainingTime));
    }

    final splashMedia = provider.homeModel!.splashData;
    if (splashMedia != null) {
      if (splashMedia.type == 'video') {
        _videoPlayerController = PodPlayerController(
          playVideoFrom: PlayVideoFrom.network(splashMedia.mediaUrl!),
          podPlayerConfig: const PodPlayerConfig(autoPlay: true),
        );

        debugPrint('initialising video...');
        try {
          // Add a timeout so we don't hang forever if video fails
          await _videoPlayerController!.initialise().timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception("Video init timeout");
            },
          );
        } catch (e) {
          debugPrint("Video init failed: $e");
          if (mounted && !_hasNavigated) {
            _hasNavigated = true;
            context.goNamed(HomeView.route);
          }
          return;
        }

        debugPrint('video initialised');

        if (splashMedia.isMuted == true) {
          _videoPlayerController!.mute();
        }

        if (!mounted) return;
        setState(() => _showMedia = true);

        // Attach listener immediately
        _videoPlayerController!.addListener(() {
          if (!mounted) return;

          // Create animation controller when playback starts
          if (_videoPlayerController!.isVideoPlaying && _videoPlayerController!.isInitialised && _progressController == null) {
            final totalDuration = _videoPlayerController!.videoPlayerValue?.duration;
            if (totalDuration != null) {
              _progressController = AnimationController(vsync: this, duration: totalDuration)..forward();
              setState(() {});
            }
          }

          final position = _videoPlayerController!.currentVideoPosition;
          final totalDuration = _videoPlayerController!.videoPlayerValue?.duration;

          // Detect video end
          if (!_videoPlayerController!.isVideoPlaying &&
              _videoPlayerController!.isInitialised &&
              totalDuration != null &&
              position >= totalDuration) {
            if (_hasNavigated) return;
            _hasNavigated = true;
            context.goNamed(HomeView.route);
          }
        });

        return;
      } else {
        // Fallback to splash image
        await _preloadImage(splashMedia.mediaUrl!);
        _progressController = AnimationController(vsync: this, duration: const Duration(seconds: 4))..forward();
        _showMedia = true;
        setState(() {});
        await Future.delayed(const Duration(seconds: 4));
      }
    }

    // Final navigation
    if (_hasNavigated) return;
    _hasNavigated = true;
    if (mounted) {
      context.goNamed(HomeView.route);
    }
  }

  showVersionAlertDialog(bool isMandatory, String url) async {
    return await showAdaptiveDialog(
      context: context,
      barrierDismissible: !isMandatory,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text("Update Available", style: AppStyles.getMediumTextStyle(fontSize: 18)),
          content: Text(
            "A new version of the app is available. Please update to continue.",
            style: AppStyles.getRegularTextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(onPressed: () => launchUrl(Uri.parse(url)), child: Text("Update", style: AppStyles.getBoldTextStyle(fontSize: 14))),
            TextButton(
              onPressed: () {
                // Exit the app
                if (isMandatory) {
                  exit(0);
                } else {
                  context.pop();
                }
              },
              child: Text(isMandatory ? "Exit" : "Cancel", style: AppStyles.getBoldTextStyle(fontSize: 14)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _preloadImage(String imageUrl) async {
    await precacheImage(CachedNetworkImageProvider(imageUrl), context);
  }
}
