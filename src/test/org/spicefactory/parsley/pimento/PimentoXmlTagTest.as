package org.spicefactory.parsley.pimento {

import org.spicefactory.parsley.cinnamon.CinnamonXmlSupport;
import org.spicefactory.parsley.context.ContextBuilder;
import org.spicefactory.parsley.core.context.Context;
import org.spicefactory.parsley.xml.XmlConfig;

public class PimentoXmlTagTest extends PimentoTestBase {

	
	CinnamonXmlSupport.initialize();
	PimentoXmlSupport.initialize();
	
	
	private function newContext (xml:XML) : Context {
		return ContextBuilder.newBuilder().config(XmlConfig.forInstance(xml)).build();
	}
	
	public override function get pimentoContext () : Context {
		return newContext(pimentoXml);
	}
	
	public override function get cinnamonContext () : Context {
		return newContext(cinnamonXml);
	}
	
	public var cinnamonXml:XML = <objects 
		xmlns="http://www.spicefactory.org/parsley"
		xmlns:cinnamon="http://www.spicefactory.org/parsley/cinnamon"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xsi:schemaLocation="http://www.spicefactory.org/parsley http://www.spicefactory.org/parsley/schema/2.0/parsley-core.xsd http://www.spicefactory.org/parsley/cinnamon http://www.spicefactory.org/parsley/schema/2.0/parsley-cinnamon.xsd"
		>
		<cinnamon:channel 
		    id="mainChannel"
		    url="http://localhost:8080/Pimento_Server/cinnamon/"
		    timeout="3000"
		/>
		<cinnamon:service
		    name="echoService"
		    type="org.spicefactory.parsley.pimento.model.EchoServiceImpl"
		/>
	</objects>;
		
	public var pimentoXml:XML = <objects 
		xmlns="http://www.spicefactory.org/parsley"
		xmlns:pimento="http://www.spicefactory.org/parsley/pimento"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xsi:schemaLocation="http://www.spicefactory.org/parsley http://www.spicefactory.org/parsley/schema/2.0/parsley-core.xsd http://www.spicefactory.org/parsley/pimento http://www.spicefactory.org/parsley/schema/2.0/parsley-pimento.xsd"
		>
		<pimento:config 
		    url="http://localhost:8080/Pimento_Server/cinnamon/"
		    timeout="3000"
		/>
		<pimento:service
		    name="echoService"
		    type="org.spicefactory.parsley.pimento.model.EchoServiceImpl"
		/>
	</objects>;
	
}

}