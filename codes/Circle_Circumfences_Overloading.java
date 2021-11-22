public static double getCircumferences(double[] radii) {
  double circumferences = 0;
  for (double radius : radii) {
    circumferences += Circle.PI * 2 * radius
  }
  return circumference;
}