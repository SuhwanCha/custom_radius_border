library custom_radius_border;

import 'package:flutter/material.dart';

class CustomBorder extends BoxBorder {
  const CustomBorder({
    this.left = BorderSide.none,
    this.top = BorderSide.none,
    this.right = BorderSide.none,
    this.bottom = BorderSide.none,
  });

  factory CustomBorder.all({
    required Color color,
    double width = 1.0,
  }) {
    final BorderSide side = BorderSide(color: color, width: width);
    return CustomBorder(
      left: side,
      top: side,
      right: side,
      bottom: side,
    );
  }

  @override
  final BorderSide bottom;

  final BorderSide left;

  final BorderSide right;

  @override
  final BorderSide top;

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.only(
      left: left.width,
      top: top.width,
      right: right.width,
      bottom: bottom.width,
    );
  }

  @override
  bool get isUniform => left == top && top == right && right == bottom;

  double _radius(double width, double align) {
    if (align == 1.0) {
      return 0;
    } else if (align == -1.0) {
      return width * 0.5;
    } else {
      return width * 0.25;
    }
  }

  double _offset(double width, double align) {
    if (align == -1.0) {
      return 0;
    } else if (align == 1.0) {
      return width * -0.5;
    } else {
      return width * -0.25;
    }
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    // stroke align should be uniform
    assert(
      left.strokeAlign == top.strokeAlign &&
          top.strokeAlign == right.strokeAlign &&
          right.strokeAlign == bottom.strokeAlign,
    );
    final Paint paint = Paint();
    if (left.width > 0.0) {
      paint.color = left.color;
      paint.strokeWidth = left.width;
      paint.style = PaintingStyle.stroke;

      if (borderRadius != null && borderRadius.topLeft != Radius.zero) {
        canvas.drawArc(
          Rect.fromCircle(
              center: rect.topLeft
                  .translate(borderRadius.topLeft.x, borderRadius.topLeft.y),
              radius: borderRadius.topLeft.x -
                  _radius(left.width, left.strokeAlign)),
          1.0 * 3.14,
          0.25 * 3.14,
          false,
          paint,
        );
      }
      if (borderRadius != null && borderRadius.bottomLeft != Radius.zero) {
        canvas.drawArc(
          Rect.fromCircle(
              center: rect.bottomLeft.translate(
                  borderRadius.bottomLeft.x, -borderRadius.bottomLeft.y),
              radius: borderRadius.bottomLeft.x -
                  _radius(left.width, left.strokeAlign)),
          0.75 * 3.14,
          0.25 * 3.14,
          false,
          paint,
        );
      }

      canvas.drawLine(
          rect.topLeft +
              Offset(
                _radius(left.width, left.strokeAlign),
                borderRadius?.topLeft.y ??
                    _offset(left.width, left.strokeAlign),
              ),
          rect.bottomLeft -
              Offset(
                  -_radius(left.width, left.strokeAlign),
                  borderRadius?.bottomLeft.y ??
                      _offset(left.width, left.strokeAlign)),
          paint);
    }
    if (top.width > 0.0) {
      paint.color = top.color;
      paint.strokeWidth = top.width;
      paint.style = PaintingStyle.stroke;
      if (borderRadius != null && borderRadius.topLeft != Radius.zero) {
        canvas.drawArc(
          Rect.fromCircle(
              center: rect.topLeft
                  .translate(borderRadius.topLeft.x, borderRadius.topLeft.y),
              radius:
                  borderRadius.topLeft.y - _radius(top.width, top.strokeAlign)),
          1.25 * 3.14,
          0.25 * 3.14,
          false,
          paint,
        );
      }
      if (borderRadius != null && borderRadius.topRight != Radius.zero) {
        canvas.drawArc(
          Rect.fromCircle(
              center: rect.topRight
                  .translate(-borderRadius.topRight.x, borderRadius.topRight.y),
              radius: borderRadius.topRight.y -
                  _radius(top.width, top.strokeAlign)),
          1.5 * 3.14,
          0.25 * 3.14,
          false,
          paint,
        );
      }

      canvas.drawLine(
          rect.topLeft +
              Offset(
                  borderRadius?.topLeft.x ??
                      _offset(top.width, top.strokeAlign),
                  _radius(top.width, top.strokeAlign)),
          rect.topRight -
              Offset(
                  borderRadius?.topRight.x ??
                      _offset(top.width, top.strokeAlign),
                  -_radius(top.width, top.strokeAlign)),
          paint);
    }
    if (right.width > 0.0) {
      paint.color = right.color;
      paint.strokeWidth = right.width;
      paint.style = PaintingStyle.stroke;
      if (borderRadius != null && borderRadius.topRight != Radius.zero) {
        canvas.drawArc(
          Rect.fromCircle(
              center: rect.topRight
                  .translate(-borderRadius.topRight.x, borderRadius.topRight.y),
              radius: borderRadius.topRight.x -
                  _radius(right.width, right.strokeAlign)),
          1.75 * 3.14,
          0.25 * 3.14,
          false,
          paint,
        );
      }
      if (borderRadius != null && borderRadius.bottomRight != Radius.zero) {
        canvas.drawArc(
          Rect.fromCircle(
              center: rect.bottomRight.translate(
                  -borderRadius.bottomRight.x, -borderRadius.bottomRight.y),
              radius: borderRadius.bottomRight.x -
                  _radius(right.width, right.strokeAlign)),
          0 * 3.14,
          0.25 * 3.14,
          false,
          paint,
        );
      }
      canvas.drawLine(
          rect.topRight +
              Offset(
                  -_radius(right.width, right.strokeAlign),
                  borderRadius?.topRight.y ??
                      _offset(right.width, right.strokeAlign)),
          rect.bottomRight -
              Offset(
                  _radius(right.width, right.strokeAlign),
                  borderRadius?.bottomRight.y ??
                      _offset(right.width, right.strokeAlign)),
          paint);
    }
    if (bottom.width > 0.0) {
      paint.color = bottom.color;
      paint.strokeWidth = bottom.width;
      paint.style = PaintingStyle.stroke;

      if (borderRadius != null && borderRadius.bottomLeft != Radius.zero) {
        canvas.drawArc(
          Rect.fromCircle(
              center: rect.bottomLeft.translate(
                  borderRadius.bottomLeft.x, -borderRadius.bottomLeft.y),
              radius: borderRadius.bottomLeft.y -
                  _radius(bottom.width, bottom.strokeAlign)),
          0.5 * 3.14,
          0.25 * 3.14,
          false,
          paint,
        );
      }

      if (borderRadius != null && borderRadius.bottomRight != Radius.zero) {
        canvas.drawArc(
          Rect.fromCircle(
              center: rect.bottomRight.translate(
                  -borderRadius.bottomRight.x, -borderRadius.bottomRight.y),
              radius: borderRadius.bottomRight.y -
                  _radius(bottom.width, bottom.strokeAlign)),
          0.25 * 3.14,
          0.25 * 3.14,
          false,
          paint,
        );
      }

      canvas.drawLine(
          rect.bottomLeft +
              Offset(
                  borderRadius?.bottomLeft.x ??
                      _offset(bottom.width, bottom.strokeAlign),
                  -_radius(bottom.width, bottom.strokeAlign)),
          rect.bottomRight -
              Offset(
                  (borderRadius?.bottomRight.x ??
                      _offset(bottom.width, bottom.strokeAlign)),
                  _radius(bottom.width, bottom.strokeAlign)),
          paint);
    }
  }

  @override
  ShapeBorder scale(double t) {
    return CustomBorder(
      left: left.scale(t),
      top: top.scale(t),
      right: right.scale(t),
      bottom: bottom.scale(t),
    );
  }
}
