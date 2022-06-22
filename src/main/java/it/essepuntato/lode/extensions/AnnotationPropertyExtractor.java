
package it.essepuntato.lode.extensions;

import net.sf.saxon.expr.XPathContext;
import net.sf.saxon.lib.ExtensionFunctionCall;
import net.sf.saxon.lib.ExtensionFunctionDefinition;
import net.sf.saxon.om.Sequence;
import net.sf.saxon.om.StructuredQName;
import net.sf.saxon.trans.XPathException;
import net.sf.saxon.value.Int64Value;
import net.sf.saxon.value.SequenceType;

public class AnnotationPropertyExtractor extends ExtensionFunctionDefinition {

	/**
	 *  <xsl:value-of select="lode-fn:getAnnotation(1)" />
	 */
	private static final long serialVersionUID = 1L;
	private static AnnotationPropertyExtractor instance;
	private String ontologyUrl;

	private AnnotationPropertyExtractor(String ontologyUrl) {
		this.ontologyUrl = ontologyUrl;
	}

	public static AnnotationPropertyExtractor getInstance(String ontologyUrl) {
		if (instance == null) {
			instance = new AnnotationPropertyExtractor(ontologyUrl);
		}
		return instance;
	}

	@Override
	public StructuredQName getFunctionQName() {
		return new StructuredQName("lode-fn", "https://w3id.org/lode/fn", "getAnnotation");
	}

	@Override
	public net.sf.saxon.value.SequenceType getResultType(net.sf.saxon.value.SequenceType[] suppliedArgumentTypes) {
		return SequenceType.SINGLE_INTEGER;
	}

	@Override
	public ExtensionFunctionCall makeCallExpression() {
		return new ExtensionFunctionCall() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 1L;

			@Override
			public Sequence call(XPathContext context, Sequence[] arguments) throws XPathException {
				return Int64Value.makeIntegerValue(42);
			}
		};
	}

	@Override
	public net.sf.saxon.value.SequenceType[] getArgumentTypes() {
		return new SequenceType[] { SequenceType.SINGLE_INTEGER };
	}

}
