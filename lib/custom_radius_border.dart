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

      if (left.strokeAlign == BorderSide.strokeAlignInside) {
        if (borderRadius != null && borderRadius.topLeft != Radius.zero) {
          canvas.drawArc(
            Rect.fromCircle(
                center: rect.topLeft
                    .translate(borderRadius.topLeft.x, borderRadius.topLeft.y),
                radius: borderRadius.topLeft.x - left.width / 2),
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
                radius: borderRadius.bottomLeft.x - left.width / 2),
            0.75 * 3.14,
            0.25 * 3.14,
            false,
            paint,
          );
        }
        canvas.drawLine(
            rect.topLeft + Offset(left.width / 2, borderRadius?.topLeft.y ?? 0),
            rect.bottomLeft -
                Offset(-left.width / 2, borderRadius?.bottomLeft.y ?? 0),
            paint);
      }
    }
    if (top.width > 0.0) {
      paint.color = top.color;
      paint.strokeWidth = top.width;
      paint.style = PaintingStyle.stroke;
      if (borderRadius != null) {
        if (top.strokeAlign == BorderSide.strokeAlignInside) {
          canvas.drawArc(
            Rect.fromCircle(
                center: rect.topLeft
                    .translate(borderRadius.topLeft.x, borderRadius.topLeft.y),
                radius: borderRadius.topLeft.y - top.width / 2),
            1.25 * 3.14,
            0.25 * 3.14,
            false,
            paint,
          );
          canvas.drawArc(
            Rect.fromCircle(
                center: rect.topRight.translate(
                    -borderRadius.topRight.x, borderRadius.topRight.y),
                radius: borderRadius.topRight.y - top.width / 2),
            1.5 * 3.14,
            0.25 * 3.14,
            false,
            paint,
          );
          canvas.drawLine(
              rect.topLeft + Offset(borderRadius.topLeft.x, top.width / 2),
              rect.topRight - Offset(borderRadius.topRight.x, -top.width / 2),
              paint);
        }
      }
    }
    if (right.width > 0.0) {
      paint.color = right.color;
      paint.strokeWidth = right.width;
      paint.style = PaintingStyle.stroke;
      if (borderRadius != null) {
        if (right.strokeAlign == BorderSide.strokeAlignInside) {
          canvas.drawArc(
            Rect.fromCircle(
                center: rect.topRight.translate(
                    -borderRadius.topRight.x, borderRadius.topRight.y),
                radius: borderRadius.topRight.x - right.width / 2),
            1.75 * 3.14,
            0.25 * 3.14,
            false,
            paint,
          );
          canvas.drawArc(
            Rect.fromCircle(
                center: rect.bottomRight.translate(
                    -borderRadius.bottomRight.x, -borderRadius.bottomRight.y),
                radius: borderRadius.bottomRight.x - right.width / 2),
            0 * 3.14,
            0.25 * 3.14,
            false,
            paint,
          );
          canvas.drawLine(
              rect.topRight + Offset(-right.width / 2, borderRadius.topRight.y),
              rect.bottomRight -
                  Offset(right.width / 2, borderRadius.bottomRight.y),
              paint);
        }
      }
    }
    if (bottom.width > 0.0) {
      paint.color = bottom.color;
      paint.strokeWidth = bottom.width;
      paint.style = PaintingStyle.stroke;

      if (borderRadius != null) {
        if (bottom.strokeAlign == BorderSide.strokeAlignInside) {
          canvas.drawArc(
            Rect.fromCircle(
                center: rect.bottomLeft.translate(
                    borderRadius.bottomLeft.x, -borderRadius.bottomLeft.y),
                radius: borderRadius.bottomLeft.y - bottom.width / 2),
            0.5 * 3.14,
            0.25 * 3.14,
            false,
            paint,
          );
          canvas.drawArc(
            Rect.fromCircle(
                center: rect.bottomRight.translate(
                    -borderRadius.bottomRight.x, -borderRadius.bottomRight.y),
                radius: borderRadius.bottomRight.y - bottom.width / 2),
            0.25 * 3.14,
            0.25 * 3.14,
            false,
            paint,
          );
          canvas.drawLine(
              rect.bottomLeft +
                  Offset(borderRadius.bottomLeft.x, -bottom.width / 2),
              rect.bottomRight -
                  Offset(borderRadius.bottomRight.x, bottom.width / 2),
              paint);
        }
      }
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
