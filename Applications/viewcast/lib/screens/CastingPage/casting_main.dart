import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viewcast/components/animated_wave.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/models/display.dart';
import 'package:viewcast/screens/ConnectPage/connect_main.dart';
import 'package:viewcast/services/file_service.dart';
import 'package:viewcast/services/socket_manager.dart';
import 'package:viewcast/styles.dart';
import 'package:viewcast/utils/cache_image_provider.dart';

class CastingPage extends StatelessWidget {
  const CastingPage({Key? key, this.display}) : super(key: key);

  final Display? display;

  @override
  Widget build(BuildContext context) {
    if (display != null) {
      _handleSocket(context);
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //const WaveBackground(),
            SizedBox(
              width: double.infinity,
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                    child: Consumer(
                      builder: (context, watch, child) {
                        final responseAsyncValue = watch(filesBuffer);
                        final fileId = watch(filesBufferRecentId).state;
                        return responseAsyncValue.map(
                          data: (data) {
                            if (fileId != null) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: CacheImageProvider(
                                      data.value[fileId]!.name!,
                                      data.value[fileId]!.bytes!,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Stack(
                                children: const [
                                  WaveBackground(),
                                  SizedBox(
                                    width: double.infinity,
                                    child: WaitingScreen(),
                                  ),
                                ],
                              );
                            }
                          },
                          loading: (_) => Container(
                            color: Colors.black,
                          ),
                          error: (_) => Center(
                            child: Text(CustomLocalizations.of(context).error),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Flex(
                direction: Axis.vertical,
                children: [
                  const Header(),
                  Expanded(flex: 9, child: Container()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSocket(BuildContext context) {
    SocketManager().connectToServer();
    SocketManager().startListening(context);
    SocketManager().displayConnection(display!.id!);
  }
}

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(child: Container()),
        Expanded(
          flex: 8,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 2,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/viewcast.svg',
                    width: 400,
                    height: 200,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Sharing together",
                    style: TextStyle(
                      fontSize: 40,
                      color: viewCastColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: 400,
                  alignment: Alignment.topCenter,
                  child: Text(
                    CustomLocalizations.of(context).waiting,
                    style: TextStyle(
                      fontSize: 20,
                      color: viewCastColor,
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: Center(child: const LinearProgressIndicator()),
              // ),
              Expanded(flex: 2, child: Container()),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              CustomLocalizations.of(context).powered,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  //final Display? display;

  @override
  Widget build(BuildContext context) {
    double size = 40;
    return Expanded(
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(top: 16.0, left: 48.0),
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: 200,
          height: 50,
          child: TextButton(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_left, color: viewCastColor, size: size),
                ]),
            onPressed: () => _navigateToConnectPage(context),
          ),
        ),
      ),
    );
  }

  void _navigateToConnectPage(BuildContext context) {
    SocketManager().logout(context);
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) => const ConnectPage(),
      ),
    );
  }
}
