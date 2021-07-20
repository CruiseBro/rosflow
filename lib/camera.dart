import 'package:flutter/cupertino.dart';

class Camera
{

  double x = 0.0;
  double y = 0.0;
  double _scale = 1.0;

  void set scale (double val)
  {
    if(val > 0.2 && val < 1.8)
      {
        _scale = val;
      }
  }

  double get scale
  {
    return _scale;
  }
}