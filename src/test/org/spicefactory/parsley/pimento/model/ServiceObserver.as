package org.spicefactory.parsley.pimento.model {
import org.spicefactory.cinnamon.service.ServiceResponse;

/**
 * @author Jens Halm
 */
public class ServiceObserver {
	
	
	public var response:ServiceResponse;
	public var resultString:String;
	
	
	[CommandResult(selector="test1")]
	public function observeWithResponseParam (response:ServiceResponse) : void {
		this.response = response;
	}

	[CommandResult(selector="test1")]
	public function observeWithResultParam (result:String) : void {
		resultString = result;
	}
	
	
}
}
