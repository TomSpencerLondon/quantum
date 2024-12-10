Here’s the updated README, including the Docker commands we discussed earlier:

---

# Quantum Circuit Simulation with Qiskit

This project demonstrates how to create and simulate a simple quantum circuit using Qiskit. The circuit explores fundamental quantum concepts like superposition, entanglement, and measurement.

---

## Code Explanation

### Importing Required Libraries
```python
from qiskit import Aer, QuantumCircuit, execute
from qiskit.visualization import plot_histogram
```
- **`Aer`**: Provides access to Qiskit simulators, such as the `qasm_simulator`.
- **`QuantumCircuit`**: A class for creating and manipulating quantum circuits.
- **`execute`**: Runs quantum circuits on a selected backend.
- **`plot_histogram`**: Visualizes measurement results as a histogram.

---

### Creating the Quantum Circuit
```python
qc = QuantumCircuit(2)
```
- **`QuantumCircuit(2)`**: Creates a quantum circuit with 2 qubits (q0 and q1), both initialized to the state |0⟩.

---

### Adding Quantum Gates
```python
qc.h(0)
qc.cx(0, 1)
```
- Applies a **Hadamard gate** to the first qubit (`q0`), creating a superposition:
  $|0⟩ \rightarrow \frac{|0⟩ + |1⟩}{\sqrt{2}}$

- Creates an **entangled state**:
  $|\psi⟩ = \frac{|00⟩ + |11⟩}{\sqrt{2}}$

---

### Adding Measurements
```python
qc.measure_all()
```
- Measures both qubits (`q0` and `q1`) in the computational basis (|0⟩ or |1⟩).
- Collapses the quantum state into classical binary values, such as `00` or `11`.

---

### Setting Up the Simulator
```python
simulator = Aer.get_backend('qasm_simulator')
```
- **`qasm_simulator`**: Simulates quantum circuits and outputs classical measurement results.

---

### Executing the Circuit
```python
result = execute(qc, simulator, shots=1000).result()
```
- **`execute(qc, simulator, shots=1000)`**:
  - Runs the quantum circuit `qc` on the `qasm_simulator`.
  - Repeats the circuit execution 1000 times to collect measurement statistics.
- **`.result()`**: Retrieves the execution results.

---

### Extracting and Visualizing Results
```python
counts = result.get_counts()
```
- **`result.get_counts()`**:
  - Returns a dictionary showing the frequency of measurement outcomes.
  - Example: `{'00': 502, '11': 498}`.

```python
print(counts)
plot_histogram(counts)
```
- **`print(counts)`**: Displays the counts of measurement outcomes.
- **`plot_histogram(counts)`**: Visualizes the measurement results as a bar chart.

---

## Circuit Overview

### Quantum Operations
1. **Hadamard Gate (`H`)**:
   - Creates a superposition on the first qubit (`q0`).
2. **CNOT Gate (`CX`)**:
   - Entangles the second qubit (`q1`) with the first (`q0`).

### Final Quantum State
The quantum circuit produces the entangled state:

|ψ⟩ = (|00⟩ + |11⟩) / √2

### Expected Measurement Results
- The two qubits are **correlated**: both are either `00` or `11`.
- Each outcome has a **50% probability**.

**Example Output:**
```plaintext
{'00': 490, '11': 510}
```

**Histogram:**

The histogram will show approximately equal bars for `00` and `11`.

---

## Running the Code

### Prerequisites
1. Install Docker on your system.
2. Save the code in a Python file or use the following Docker setup.

---

## Running the Code Using Docker

### Dockerfile
```dockerfile
FROM --platform=linux/amd64 python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y git curl && rm -rf /var/lib/apt/lists/*

# Install Qiskit and dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir "qiskit==0.43.2" qiskit[visualization] jupyter

EXPOSE 8888

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
```

### Building and Running the Docker Container
1. Build the Docker image:
   ```bash
   docker build -t qiskit-docker .
   ```
2. Run the Docker container:
   ```bash
   docker run -it --rm -p 8888:8888 -v "$PWD":/app qiskit-docker
   ```
3. Open Jupyter Notebook in your browser:
   - The URL will be displayed in the container logs (e.g., `http://localhost:8888`).

---

## Visualization Example
Below is a sample histogram of the measurement results:

<img width="1240" alt="image" src="https://github.com/user-attachments/assets/9f5e39e8-c0ba-41fe-9a71-bad243a6ff6c">

