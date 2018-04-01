/**
 */
package hu.bme.mit.inf.viewmodel.benchmarks.models.railway;

import org.eclipse.emf.common.util.EList;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Segment</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link hu.bme.mit.inf.viewmodel.benchmarks.models.railway.Segment#getLength <em>Length</em>}</li>
 *   <li>{@link hu.bme.mit.inf.viewmodel.benchmarks.models.railway.Segment#getSemaphores <em>Semaphores</em>}</li>
 * </ul>
 *
 * @see hu.bme.mit.inf.viewmodel.benchmarks.models.railway.RailwayPackage#getSegment()
 * @model
 * @generated
 */
public interface Segment extends TrackElement {
	/**
	 * Returns the value of the '<em><b>Length</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Length</em>' attribute isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Length</em>' attribute.
	 * @see #setLength(int)
	 * @see hu.bme.mit.inf.viewmodel.benchmarks.models.railway.RailwayPackage#getSegment_Length()
	 * @model unique="false"
	 * @generated
	 */
	int getLength();

	/**
	 * Sets the value of the '{@link hu.bme.mit.inf.viewmodel.benchmarks.models.railway.Segment#getLength <em>Length</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Length</em>' attribute.
	 * @see #getLength()
	 * @generated
	 */
	void setLength(int value);

	/**
	 * Returns the value of the '<em><b>Semaphores</b></em>' containment reference list.
	 * The list contents are of type {@link hu.bme.mit.inf.viewmodel.benchmarks.models.railway.Semaphore}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Semaphores</em>' containment reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Semaphores</em>' containment reference list.
	 * @see hu.bme.mit.inf.viewmodel.benchmarks.models.railway.RailwayPackage#getSegment_Semaphores()
	 * @model containment="true"
	 * @generated
	 */
	EList<Semaphore> getSemaphores();

} // Segment
