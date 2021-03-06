/********************************************************************************
 * Copyright (c) 2018 Contributors to the ViewModel project
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * SPDX-License-Identifier: EPL-1.0
 ********************************************************************************/
package hu.bme.mit.inf.viewmodel.patternlanguage.validation

import org.eclipse.viatra.query.patternlanguage.annotations.IPatternAnnotationAdditionalValidator
import org.eclipse.viatra.query.patternlanguage.patternLanguage.Annotation
import org.eclipse.viatra.query.patternlanguage.patternLanguage.Pattern
import org.eclipse.viatra.query.patternlanguage.patternLanguage.PatternBody
import org.eclipse.viatra.query.patternlanguage.patternLanguage.PatternLanguagePackage
import org.eclipse.viatra.query.patternlanguage.validation.IIssueCallback

class TemplateAnnotationValidator implements IPatternAnnotationAdditionalValidator {
	static val ISSUE_CODE_PREFIX = "hu.bme.mit.inf.viewmodel.patternlanguage.validation.TemplateAnnotationValidator."
	public static val MULTIPLE_BODIES_CODE = ISSUE_CODE_PREFIX + "MULTIPLE_BODIES"

	override executeAdditionalValidation(Annotation annotation, IIssueCallback validator) {
		val container = annotation.eContainer
		if (container instanceof Pattern) {
			validatePattern(container, validator)
		}
	}

	protected def validatePattern(Pattern pattern, IIssueCallback validator) {
		if (pattern.bodies.size > 1) {
			validator.error("Templates may only have a single body.", pattern,
				PatternLanguagePackage.Literals.PATTERN__NAME, MULTIPLE_BODIES_CODE)
		}
		for (body : pattern.bodies) {
			validatePatternBody(body, validator)
		}
	}
	
	protected def validatePatternBody(PatternBody body, IIssueCallback validator) {
		for (constraint : body.constraints) {
			switch (constraint) {
				
			}
		}
	}
}
