public class Student {

  private static long ID = 0;

  public final long id;
  private String name;

  public Student(String name) {
    this.id = ID++;
    this.name = name;
  }

  public long getID() {
    return id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }
}