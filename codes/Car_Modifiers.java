public class Car {

  private String name;
  double mileage;

  public Car(String name) {
    this.name = name;
    mileage = 0;
  }


  public void drive(double distance) {
    mileage += distance;
  }
}