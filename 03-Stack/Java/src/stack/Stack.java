/*
 * Developed by 10Pines SRL
 * License: 
 * This work is licensed under the 
 * Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ 
 * or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, 
 * California, 94041, USA.
 *  
 */
package stack;

public class Stack {
	public static final String STACK_EMPTY_DESCRIPTION = "Stack is Empty";
	
	private Node top = new NullNode();
	private Integer size = 0;

	public void push (Object anObject)
	{
		NonNullNode newNode = new NonNullNode( anObject );
		top.setNextNode(newNode);
		newNode.setPreviousNode(top);
		top = newNode;
		size++;
	}
	
	public Object pop() throws Exception
	{
		Object currentNode = top.getValue();
		Node nodeBeforeCurrent = top.getPreviousNode();
		nodeBeforeCurrent.setNextNode( new NullNode() );
		top = nodeBeforeCurrent;
		size--;
		return currentNode;
	}
	
	public Object top() throws Exception
	{
		return top.getValue();
	}

	public Boolean isEmpty()
	{
		return top.isNilNode();
	}

	public Integer size()
	{
		return size;
	}	
}
