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
package org.spicefactory.parsley.cinnamon {
import org.spicefactory.cinnamon.service.ServiceChannel;
import org.spicefactory.cinnamon.service.ServiceProxy;
import org.spicefactory.parsley.core.errors.ContextError;
import org.spicefactory.parsley.core.lifecycle.ManagedObject;
import org.spicefactory.parsley.core.registry.ObjectProcessor;
import org.spicefactory.parsley.core.registry.ObjectProcessorFactory;
import org.spicefactory.parsley.processor.util.ObjectProcessorFactories;

/**
 * Processes a service and creates the proxy for the corresponding channel.
 * 
 * @author Jens Halm
 */
public class ServiceProcessor implements ObjectProcessor {
	
    
    private var target:ManagedObject;
	private var name:String;
	private var channel:String;
	private var timeout:uint;
	
	
	/**
	 * Creates a new instance.
	 * 
	 * @param target the target service object
	 * @param name the name to register the service with
	 * @param channel the id of the channel to use for this service
	 * @param timeout the timeout to apply
	 */
	function ServiceProcessor (target:ManagedObject, name:String, channel:String, timeout:uint) {
		this.target = target;
		this.name = name;
		this.channel = channel;
		this.timeout = timeout;
	}

	/**
	 * @inheritDoc
	 */
	public function preInit () : void {
		var channelInstance:ServiceChannel;
		if (channel != null) {
			var channelRef:Object = target.context.getObject(channel);
			if (!(channelRef is ServiceChannel)) {
				throw new ContextError("Object with id " + channel + " does not implement ServiceChannel");
			}
			channelInstance = channelRef as ServiceChannel;
		}
		else {
			channelInstance = target.context.getObjectByType(ServiceChannel) as ServiceChannel;
		}
		var proxy:ServiceProxy = channelInstance.createProxy(name, target.instance);
		if (timeout != 0) proxy.timeout = timeout;
	}
	
	/**
	 * @inheritDoc
	 */
	public function postDestroy() : void {
		/* nothing to do */
	}
	
	
	/**
	 * Creates a new processor factory.
	 * 
	 * @param name the name to register the service with
	 * @param channel the id of the channel to use for this service
	 * @param timeout the timeout to apply
	 * @return a new processor factory
	 */
	public static function newFactory (name:String, channel:String, timeout:uint) : ObjectProcessorFactory {
		return ObjectProcessorFactories.newFactory(ServiceProcessor, [name, channel, timeout]);
	}
	
	/**
	 * @private
	 */
	public function toString () : String {
		return "[CinnamonService(name=" + name + ")]";
	}
	
	
}

}
