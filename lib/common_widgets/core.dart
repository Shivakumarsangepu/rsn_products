


import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class Core{
  ExtendedImage getNetworkImageFillWidth(String url,String placeHolder, double width, double? height,BoxFit fit) {
    return ExtendedImage.network(
      url,
      width: width,
      height: height,
      fit: fit,
      cache: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Image.asset(placeHolder,fit: BoxFit.fill,
            );
            break;

        ///if you don't want override completed widget
        ///please return null or state.completedWidget
        //return null;
        //return state.completedWidget;
          case LoadState.completed:
            return null;
          case LoadState.failed:
            return GestureDetector(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(placeHolder,fit: BoxFit.fill
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Text(
                      " ",
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              onTap: () {
                state.reLoadImage();
              },
            );
            break;
          default:
            return null;
        }
      },
    );
}
}

class VerticalSpace extends SizedBox {
  VerticalSpace({double height = 8.0}) : super(height: height);
}

class HorizontalSpace extends SizedBox {
  HorizontalSpace({double width = 8.0}) : super(width: width);
}
deviceWidth(context) => MediaQuery.of(context).size.width;
deviceHeight(context) => MediaQuery.of(context).size.height;

