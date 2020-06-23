# PyParticle
Analysis codes library for system with particles' real space coordinations


Currently, there are two main purposes for this repo:

1. **Transfer useful Anaylsis codes from IDL to Python** 

The IDL codes consist of two sources:

- *Eric Weeks's Particle Tracking and Anylysis Codes (http://www.physics.emory.edu/faculty/weeks//idl/)*

Particle tracking part has been realized by [trackpy](http://soft-matter.github.io/trackpy/v0.4.2/), so i would focus on the analysis codes, like various correlations functions, as well as the I/O API for typical IDL file types like `.gdf`

- *My own IDL untility codes, which were generated when i was doing researches at Peng's Lab.*

So hopefully, it would provide a smooth transfer bridge between IDL and Python.


2. **Provide a rather complete set of analysis methods' realizations with Python**

As i know, reasearches in fields like soft matter, material science and biology would involve heavy analysis with particles' real space coordinations. However, such analysis codes are currently dispersed in platforms like Matlab, IDL, and most codes are lab-specific. So it is worthwhile to generate a united library in an active open-source language like Python. 

Because new analysis methods and order parameters are being continuously introduced in research papers, it is important to attach references or clear theoretical definitions in each parameter's doc string. 
