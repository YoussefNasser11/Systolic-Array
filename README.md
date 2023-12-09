# Systolic-Array
The Systolic Matrix Multiplier (3x3) is a hardware implementation designed to efficiently perform matrix multiplication using a systolic array architecture. this project leverages processing elements (PEs) to achieve parallel computation, resulting in improved performance for matrix multiplication tasks.

Key Features:

Systolic Array Architecture: The project employs a 3x3 systolic array, a highly parallelized structure that enhances the computational efficiency of matrix multiplication.
Processing Elements (PEs): The heart of the design, PEs handle the multiplication, addition, and shifting operations. Each PE operates synchronously with the system clock, providing a structured and synchronized approach to computation.
Scalable Data Width: The project allows for flexibility in data width, accommodating various precision requirements by parameterizing the data width in the processing elements.
Reset Functionality: The design incorporates a reset mechanism to initialize the system, ensuring proper operation under different conditions.
Modular Design: The code is organized into modular components, enhancing readability, maintainability, and ease of integration into larger systems.
