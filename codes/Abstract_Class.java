public abstract class FlyingBird implements Flying {

  protected double distance = 0;
  private final String name;

  public FlyingBird(String name) {
    this.name = name;
  }

  @Override
  public abstract void fly(final double distance);

  public String getName() {
    return name;
  }
}

public class Swan extends FlyingBird implements Swimming {

  public Swan(String name) {
    super(name);
  }

  @Override
  public void swim(final double distance) {
    this.distance += distance;
  }

  @Override
  public void fly(final double distance) {
    this.distance += Flying.SPEED * distance;
  }
}