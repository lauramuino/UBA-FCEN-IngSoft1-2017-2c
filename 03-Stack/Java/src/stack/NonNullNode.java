package stack;

public final class NonNullNode extends Node{
	private final Object value;

	public NonNullNode( final Object value ){
		this.value = value;
		this.next = new NullNode();
		this.previous = new NullNode();
	}

	public boolean isNilNode(){
		return false;
	}

	public void setNextNode( final Node node ){
		this.next = node;
	}

	public void setPreviousNode( final Node node ){
		this.previous = node;
	}

	public Node getPreviousNode(){
		return previous;
	}

	public final Object getValue(){
		return this.value;
	}
}

