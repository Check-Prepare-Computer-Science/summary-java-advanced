public class Counter{

	private int count;
	
	public Counter(){
		count = 0;
	}
	
	public int countUp(int steps){
		int localCount = 0;
		for(int i = 0; i < steps; i++){
			localCount++;
			count++;
		}
		return localCount;
	}
	
	public int getCount(){
		return count;
	}
}