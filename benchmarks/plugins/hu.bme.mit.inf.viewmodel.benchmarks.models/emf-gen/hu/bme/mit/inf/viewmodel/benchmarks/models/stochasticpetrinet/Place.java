/**
 */
package hu.bme.mit.inf.viewmodel.benchmarks.models.stochasticpetrinet;


/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Place</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link hu.bme.mit.inf.viewmodel.benchmarks.models.stochasticpetrinet.Place#getTokens <em>Tokens</em>}</li>
 * </ul>
 *
 * @see hu.bme.mit.inf.viewmodel.benchmarks.models.stochasticpetrinet.StochasticPetriNetPackage#getPlace()
 * @model
 * @generated
 */
public interface Place extends Node {
	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	String copyright = "Copyright (c) 2018 Contributors to the ViewModel project\n\nAll rights reserved. This program and the accompanying materials\nare made available under the terms of the Eclipse Public License v1.0\nwhich accompanies this distribution, and is available at\nhttp://www.eclipse.org/legal/epl-v10.html\n\nSPDX-License-Identifier: EPL-1.0";

	/**
	 * Returns the value of the '<em><b>Tokens</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Tokens</em>' attribute isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Tokens</em>' attribute.
	 * @see #setTokens(int)
	 * @see hu.bme.mit.inf.viewmodel.benchmarks.models.stochasticpetrinet.StochasticPetriNetPackage#getPlace_Tokens()
	 * @model
	 * @generated
	 */
	int getTokens();

	/**
	 * Sets the value of the '{@link hu.bme.mit.inf.viewmodel.benchmarks.models.stochasticpetrinet.Place#getTokens <em>Tokens</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Tokens</em>' attribute.
	 * @see #getTokens()
	 * @generated
	 */
	void setTokens(int value);

} // Place
