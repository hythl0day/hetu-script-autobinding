import 'package:hetu_script/hetu_script.dart';
import 'package:flutter/material.dart';
import 'dart:math'as math;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


class InkRippleClassBinding extends HT_ExternNamespace {
  @override
  dynamic fetch(String id) {
    switch (id) {
      case 'InkRipple':
        return ({controller, referenceBox, position, color, textDirection, containedInkWell = false, rectCallback, borderRadius, customBorder, radius, onRemoved}) => InkRippleObjectBinding(InkRipple(controller : controller, referenceBox : referenceBox, position : position, color : color, textDirection : textDirection, containedInkWell : containedInkWell, rectCallback : rectCallback, borderRadius : borderRadius, customBorder : customBorder, radius : radius, onRemoved : onRemoved));
      case 'InkRipple.splashFactory':
        return InkRipple.splashFactory;
      default:
        throw HTErr_Undefined(id);
    }
  }
}

class InkRippleObjectBinding extends HT_ExternObject<InkRipple> {
  InkRippleObjectBinding(InkRipple value) : super(value);

  @override
  final typeid = HT_TypeId('InkRipple');

  @override
  dynamic fetch(String id) {
    switch (id) {
      case 'confirm':
        return externObject.confirm;
      case 'cancel':
        return externObject.cancel;
      case 'dispose':
        return externObject.dispose;
      case 'paintFeature':
        return externObject.paintFeature;
      default:
        throw HTErr_Undefined(id);
    }
  }

}

