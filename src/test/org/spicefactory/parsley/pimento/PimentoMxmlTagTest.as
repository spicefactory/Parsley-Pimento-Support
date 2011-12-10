package org.spicefactory.parsley.pimento {

import org.spicefactory.parsley.asconfig.ActionScriptContextBuilder;
import org.spicefactory.parsley.core.context.Context;
import org.spicefactory.parsley.pimento.config.CinnamonMxmlConfig;
import org.spicefactory.parsley.pimento.config.PimentoMxmlConfig;

public class PimentoMxmlTagTest extends PimentoTestBase {

	
	public override function get pimentoContext () : Context {
		return ActionScriptContextBuilder.build(PimentoMxmlConfig);
	}
	
	public override function get cinnamonContext () : Context {
		return ActionScriptContextBuilder.build(CinnamonMxmlConfig);
	}
	
	
}

}