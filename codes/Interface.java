public interface Swimming {

  void swim(double distance);
}

public interface Flying {

  double SPEED = 2;

  public abstract void fly(double distance);
}

public class Swan implements Swimming, Flying {

  private double distance = 0;

  @Override
  public void swim(final double distance) {
    this.distance += distance;
  }

  @Override
  public void fly(final double distance) {
    this.distance += Flying.SPEED * distance;
  }
}