# FIR Filter

An implementation of a FIR filter in particular using the transposed form.

# Instructions

<ul>
  <li>In the file <kbd>VHDL/fir_tb.vhdl</kbd> modify the path to your <kbd>IO/</kbd> folder. </li>
  <li>Adjust the file <kbd>IO/input_vectors.txt</kbd> with array to be filtered. Each line is one integer value.</li>
  <li>Run the testbench on with your VHDL Simulation program.</li>
  <li>Check <kbd>IO/output_results.txt</kbd> for the result</li>
  <li>If you want to use your own coefficients use the Matlab script <kbd>Matlab/coeff_script.m</kbd>. It will adjust your floating point values to integers and give a you simulation of your filter and the expected output of the vhdl filter. After simulating, you can then computer the output in <kbd>IO/output_results.txt</kbd> with the output of the Matlab script.</li>
</ul>

# Contributors

- [Gioele Carignani](https://github.com/gioelec/)
- [Felix Weichselgartner](https://github.com/FelixWeichselgartner/)
