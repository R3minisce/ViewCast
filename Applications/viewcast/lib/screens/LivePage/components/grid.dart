import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewcast/localization/l10n.dart';
import 'package:viewcast/screens/components/ex_padding.dart';
import 'package:viewcast/services/cast_service.dart';
import 'package:viewcast/services/file_service.dart';
import 'package:viewcast/services/socket_manager.dart';
import 'package:viewcast/services/user_service.dart';
import 'package:viewcast/styles.dart';
import 'package:viewcast/utils/cache_image_provider.dart';

class GridRow extends StatelessWidget {
  final int flex;

  const GridRow({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Flex(
        direction: Axis.horizontal,
        children: const [
          ExPadding(flex: 1),
          GridBody(
            flex: 24,
          ),
          ExPadding(flex: 1),
        ],
      ),
    );
  }
}

class GridBody extends StatelessWidget {
  final int flex;
  const GridBody({
    Key? key,
    required this.flex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _handleSocket(context);
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        child: Consumer(
          builder: (context, watch, child) {
            watch(castsDashboardRefreshProvider).state;
            final casts = watch(castsDashboardProvider.notifier).state;
            final user = watch(currentUserProvider).state;
            if (user != null) {
              var castsOfUser = watch(getCastsByNameProvider.call(user.uuid!));

              return castsOfUser.map(
                data: (data) {
                  List<int> filteredCasts;
                  if (!user.admin!) {
                    filteredCasts = casts.keys
                        .where(
                            (element) => data.value.any((e) => element == e.id))
                        .toList();
                  } else {
                    filteredCasts = casts.keys.toList();
                  }

                  return GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 1.7,
                    ),
                    itemCount: filteredCasts.length,
                    itemBuilder: (context, index) {
                      return GridViewItem(
                        castId: filteredCasts[index],
                      );
                    },
                  );
                },
                loading: (_) =>
                    const Center(child: CircularProgressIndicator()),
                error: (_) =>
                    Center(child: Text(CustomLocalizations.of(context).error)),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  void _handleSocket(BuildContext context) {
    SocketManager().connectToServer();
    SocketManager().startListening(context);
    SocketManager().dashboardConnection();
  }
}

class GridViewItem extends StatelessWidget {
  final int castId;
  const GridViewItem({
    required this.castId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        var casts = watch(castsDashboardProvider).state;
        final files = watch(filesDashboardProvider).state;
        var castsFull = watch(getCastsProvider);
        return castsFull.map(
          data: (data) {
            var currentCast = data.value.firstWhere((e) => e.id == castId);
            if (casts.isNotEmpty) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: CacheImageProvider(
                      files[casts[castId]]!.name!,
                      files[casts[castId]]!.bytes!,
                    ),
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16)),
                        ),
                        height: 30,
                        width: double.maxFinite,
                        child: Text(
                          currentCast.name!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: viewCastColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
              );
            } else {
              return Container();
            }
          },
          loading: (_) => const Center(child: CircularProgressIndicator()),
          error: (_) =>
              Center(child: Text(CustomLocalizations.of(context).error)),
        );
      },
    );
  }
}
