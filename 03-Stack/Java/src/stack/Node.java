package stack;

public abstract class Node {
	protected Node next;
	protected Node previous;

	//testing
	public abstract boolean isNilNode();
	
	//Setters
	public abstract void setNextNode( Node node );
	public abstract void setPreviousNode( Node node );
	
	//Getters
	public abstract Node getPreviousNode();
	public abstract Object getValue() throws Exception;
}