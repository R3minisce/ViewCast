import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/components/animated_wave.dart';
import 'package:flutter/material.dart';
import 'package:viewcast/models/user.dart';
import 'package:viewcast/screens/GroupMgmtPage/components/body.dart';
import 'package:viewcast/screens/NotAuthPage/not_auth_main.dart';
import 'package:viewcast/screens/components/footer.dart';
import 'package:viewcast/screens/components/menu.dart';
import 'package:viewcast/services/user_service.dart';

class GroupMgmtPage extends StatelessWidget {
  const GroupMgmtPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: (context, watch, child) {
            User? user = context.read(currentUserProvider).state;
            bool isLogged = (user != null);
            return Stack(
              children: [
                const WaveBackground(),
                if (!isLogged) const NotAuthPage(),
                if (isLogged)
                  SizedBox(
                    width: double.infinity,
                    child: Flex(
                      direction: Axis.vertical,
                      children: const [
                        Menu(),
                        Body(flex: 10),
                        Footer(),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
