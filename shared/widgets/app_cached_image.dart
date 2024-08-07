import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/service/urls.dart';
import '../utils/colors.dart';

class CachedImage extends StatelessWidget {
  const CachedImage(
      {super.key,
      this.radius = 6.0,
      required this.imageUrl,
      this.height,
      this.width,
      this.bgClr,
      this.isAssetImg = false,
      this.padding,
      this.fit});

  final double radius;
  final String? imageUrl;
  final double? height, width;
  final Color? bgClr;

  final bool isAssetImg;
  final EdgeInsetsGeometry? padding;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        padding: padding,
        color: bgClr ?? Colors.transparent,
        child: isAssetImg
            ? Image.file(
                File(imageUrl ?? ""),
                fit: fit ?? BoxFit.cover,
                height: height,
                width: width,
              )
            : CachedNetworkImage(
                fit: fit ?? BoxFit.fill,
                height: height,
                width: width,
                imageUrl: imageUrl != null ? "$baseUrl/$imageUrl" : "",
                errorWidget: (_, __, ___) =>Image.asset(
               "assets/images/default_image.png",
                fit: fit ?? BoxFit.cover,
                height: height,
                width: width,
              ),
                placeholder: (_, __) => ColoredBox(
                    color: inputBorderClr.withOpacity(0.4), child: const Center(child: CupertinoActivityIndicator()))),
      ),
    );
  }
}
