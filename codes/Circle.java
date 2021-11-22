public class Circle {

  private static final double PI = 3.14159265358979323846;
  private final double radius;

  public Circle(double radius) {
    this.radius = radius;
  }

  public double getRadius() {
    return radius;
  }

  public double getCircumference() {
    return Circle.PI * 2 * radius;
  }

  public double getArea() {
    return Circle.PI * radius * radius;
  }
}