package stack;

//This class could be singleton
public final class NullNode extends Node{
	
	public NullNode() {
		this.previous = this;
		this.next = this;
	}
	
	public boolean isNilNode(){
		return true;
	}

	public void setNextNode( final Node node ){

	}

	public void setPreviousNode( final Node node ){

	}

	public Node getPreviousNode() {
		return this;
	}

	public Object getValue() throws Exception{
		throw new Exception(Stack.STACK_EMPTY_DESCRIPTION);
	}

}