/*
 * Copyright 2009 the original author or authors.
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
import org.spicefactory.parsley.config.Configuration;
import org.spicefactory.parsley.config.RootConfigurationElement;
import org.spicefactory.parsley.core.registry.ObjectDefinition;
import org.spicefactory.parsley.dsl.ObjectDefinitionBuilder;
import org.spicefactory.pimento.config.PimentoConfig;
import org.spicefactory.pimento.service.EntityManager;

[XmlMapping(elementName="config")]
/**
 * Represents the Config MXML or XML tag, defining the configuration for a Pimento EntityManager.
 * 
 * @author Jens Halm
 */
public class ConfigTag implements RootConfigurationElement {

	
	/**
	 * The id of the Pimento configuration produced by this tag in the Parsley Context. Usually no need to be specified explicitly.
	 */
	public var id:String;

	
	[Required]
	/**
	 * The service URL the EntityManager produced by this tag should connect to.
	 */
	public var url:String;
	
	/**
	 * The request timeout in milliseconds.
	 */
	public var timeout:uint;
	
	
	/**
	 * @inheritDoc
	 */
	public function process (config:Configuration) : void {
		var builder:ObjectDefinitionBuilder = config.builders.forClass(PimentoConfig);
		builder.property("serviceUrl").value(url);
		if (timeout != 0) builder.property("defaultTimeout").value(timeout);
		var def:ObjectDefinition = builder.asSingleton().id(id).register();
		
		builder = config.builders.forClass(EntityManager);
		builder.lifecycle().instantiator(new EntityManagerInstantiator(def.id));
		builder.asSingleton().id(def.id + "_entityManager").register();
	}
}
}

import org.spicefactory.parsley.core.lifecycle.ManagedObject;
import org.spicefactory.parsley.core.registry.ObjectInstantiator;
import org.spicefactory.pimento.config.PimentoConfig;

class EntityManagerInstantiator implements ObjectInstantiator {
	
	private var configId:String;

	function EntityManagerInstantiator (id:String) { this.configId = id; }

	public function instantiate (target:ManagedObject) : Object {
		return PimentoConfig(target.context.getObject(configId)).entityManager;
	}
	
}
