public class Book {

  private final String title;
  private final String author;
  private double cost;

  public Book(String title, String author, double cost) {
    this.title = title;
    this.author = author;
    this.cost = cost;
  }

  public String getTitle() {
    return title;
  }

  public String getAuthor() {
    return author;
  }

  public double getCost() {
    return cost;
  }

  public void setCost(final double cost) {
    this.cost = cost;
  }
}