import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokedex/presentation/ui/resources/colors.dart';

class RemoteImage extends StatelessWidget {
  final double? height;
  final double? width;
  final String? src;
  final String? placeholder;
  final BoxFit? fit;

  const RemoteImage({
    Key? key,
    required this.src,
    this.placeholder,
    this.height,
    this.width,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      child: src != null
          ? Image.network(
              src!,
              height: height,
              width: width,
              fit: fit,
              errorBuilder: (_, __, ___) => placeholder != null
                  ? Image.asset(
                      placeholder!,
                      height: height,
                      width: width,
                    )
                  : SizedBox(
                      height: height,
                      width: width,
                    ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return SizedBox(
                  height: height,
                  width: width,
                  child: Center(
                    child: SizedBox(
                      height: height != null ? height! / 4 : null,
                      width: width != null ? width! / 4 : null,
                      child: CircularProgressIndicator(
                        strokeWidth: width != null && height != null
                            ? [width!, height!].reduce(min) / 24
                            : 2,
                        color: colorPrimary,
                      ),
                    ),
                  ),
                );
              },
            )
          : placeholder != null
              ? Image.asset(
                  placeholder!,
                  height: height,
                  width: width,
                )
              : SizedBox(
                  height: height,
                  width: width,
                ),
    );
  }
}
