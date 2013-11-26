// Some interpolation functions

float smoothStep(float t)
{
  return (t * t * (3 - 2 * t));
}

float accelLerp(float a, float b, float t)
{
  t = t * t;
  return lerp(a,b,t);
}

float clampStepLast(float current, float maximum, float diff)
{
  return min(max((current - maximum + diff) / diff,0),1);
}

// Quadratic formula
float quadratic(float a,float b,float c)
{
  float determinant = b*b - 4*a*c;
  return (-b + sqrt(determinant))/(2*a);
}
