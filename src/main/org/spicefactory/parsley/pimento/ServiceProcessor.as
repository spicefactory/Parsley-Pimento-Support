/*
 * Copyright 2010 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.spicefactory.parsley.pimento {

import org.spicefactory.cinnamon.service.ServiceProxy;
import org.spicefactory.parsley.core.errors.ContextError;
import org.spicefactory.parsley.core.lifecycle.ManagedObject;
import org.spicefactory.parsley.core.processor.ObjectProcessor;
import org.spicefactory.pimento.config.PimentoConfig;

/**
 * Processes a service and adds it to the corresponding PimentoConfig.
 * 
 * @author Jens Halm
 */
public class ServiceProcessor implements ObjectProcessor {
	
    
    private var target:ManagedObject;
	private var name:String;
	private var config:String;
	private var timeout:uint;
	
	
	/**
	 * Creates a new instance.
	 * 
	 * @param target the target service object
	 * @param name the name to register the service with
	 * @param config the id of the PimentoConfig instance to use for this service
	 * @param timeout the timeout to apply
	 */
	function ServiceProcessor (name:String, config:String, timeout:uint) {
		this.target = target;
		this.name = name;
		this.config = config;
		this.timeout = timeout;
	}

	/**
	 * @inheritDoc
	 */
	public function init (target:ManagedObject) : void {
		var configInstance:PimentoConfig;
		if (config != null) {
			var configRef:Object = target.context.getObject(config);
			if (!(configRef is PimentoConfig)) {
				throw new ContextError("Object with id " + config + " is not a PimentoConfig instance");
			}
			configInstance = configRef as PimentoConfig;
		}
		else {
			configInstance = target.context.getObjectByType(PimentoConfig) as PimentoConfig;
		}
		configInstance.addService(name, target.instance);
		var proxy:ServiceProxy = ServiceProxy.forService(target.instance);
		if (timeout != 0) proxy.timeout = timeout;
	}
	
	/**
	 * @inheritDoc
	 */
	public function destroy (target:ManagedObject) : void {
		/* nothing to do */
	}
	
	/**
	 * @private
	 */
	public function toString () : String {
		return "[PimentoService(name=" + name + ")]";
	}
	
	
}

}
