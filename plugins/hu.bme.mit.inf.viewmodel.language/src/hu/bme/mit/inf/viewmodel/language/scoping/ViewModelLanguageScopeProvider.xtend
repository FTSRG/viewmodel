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
package hu.bme.mit.inf.viewmodel.language.scoping

import com.google.common.collect.Lists
import com.google.inject.Inject
import hu.bme.mit.inf.viewmodel.language.model.viewmodellanguage.RuleDefinition
import hu.bme.mit.inf.viewmodel.language.model.viewmodellanguage.ViewDefinitionModel
import hu.bme.mit.inf.viewmodel.language.model.viewmodellanguage.ViewModelLanguagePackage
import org.eclipse.emf.common.notify.Notifier
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EReference
import org.eclipse.xtext.EcoreUtil2
import org.eclipse.xtext.resource.EObjectDescription
import org.eclipse.xtext.resource.IResourceDescriptions
import org.eclipse.xtext.resource.IResourceDescriptionsProvider
import org.eclipse.xtext.scoping.IScope
import org.eclipse.xtext.scoping.Scopes
import org.eclipse.xtext.scoping.impl.SimpleScope

/**
 * This class contains custom scoping description.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#scoping
 * on how and when to use it.
 */
class ViewModelLanguageScopeProvider extends AbstractViewModelLanguageScopeProvider {

	@Inject IResourceDescriptionsProvider resourceDescriptionsProvider
	@Inject ViewModelImportedNamespaceProvider importedNamespaceProvider

	override getScope(EObject context, EReference reference) {
		val referenceType = reference.EReferenceType
		if (ViewModelLanguagePackage.Literals.VARIABLE.isSuperTypeOf(referenceType)) {
			getVariablesScope(context)
		} else if (ViewModelLanguagePackage.Literals.RULE_DEFINITION.isSuperTypeOf(referenceType)) {
			getRuleDefinitionsScope(context, reference)
		} else {
			super.getScope(context, reference)
		}
	}

	protected def getVariablesScope(EObject context) {
		val ruleDefinition = EcoreUtil2.getContainerOfType(context, RuleDefinition)
		if (ruleDefinition === null) {
			return IScope.NULLSCOPE
		}
		val variables = ruleDefinition.variables.filter [
			!name.startsWith("_")
		]
		Scopes.scopeFor(variables)
	}

	protected def getRuleDefinitionsScope(EObject context, EReference referece) {
		val viewDefinitionModel = EcoreUtil2.getContainerOfType(context, ViewDefinitionModel)
		if (viewDefinitionModel === null) {
			return IScope.NULLSCOPE
		}
		val resourceDescriptions = getResourceDescriptions(viewDefinitionModel)
		val ruleDefinitionDescriptions = toRuleDefinitionDescriptions(resourceDescriptions,
			viewDefinitionModel.ruleDefinitions)
		val ruleDefinitionsScope = new SimpleScope(IScope.NULLSCOPE, ruleDefinitionDescriptions)
		importedNamespaceProvider.createImportNormalizedScope(ruleDefinitionsScope, context, referece)
	}

	protected def toRuleDefinitionDescriptions(IResourceDescriptions resourceDescriptions,
		Iterable<? extends RuleDefinition> ruleDefinitions) {
		val ruleDefinitionDescriptions = Lists.newArrayListWithExpectedSize(ruleDefinitions.size)
		for (ruleDefinition : ruleDefinitions) {
			val pattern = ruleDefinition.precondition?.pattern
			if (pattern !== null) {
				val patternName = resourceDescriptions.getExportedObjectsByObject(pattern).head?.qualifiedName
				if (patternName !== null) {
					ruleDefinitionDescriptions += EObjectDescription.create(patternName, ruleDefinition)
				}
			}

		}
		ruleDefinitionDescriptions
	}

	def getResourceDescriptions(Notifier notifier) {
		val resourceSet = EcoreUtil2.getResourceSet(notifier)
		if (resourceSet === null) {
			new IResourceDescriptions.NullImpl
		} else {
			resourceDescriptionsProvider.getResourceDescriptions(resourceSet)
		}
	}
}
