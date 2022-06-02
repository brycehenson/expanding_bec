# expanding_bec
**[Bryce M. Henson](https://github.com/brycehenson)**  
Numeric and approximate solutions to the expansion of a BEC  


## Background
Y. Castin and R. Dum [[1]](#1) have shown that a pure BEC expanding from a harmonic trap that is turned off at t=0 can be well approximated as a rescaling of the x,y,z coordinates of the original solution. 



This rescaling is given by a rather nasty second order ODE that cannot be solved analytically. 


The repo gives an aproximate solution that aproximates the expansion for cigar shaped BEC's.

## Contribution
The goal of this project is to provide 
- improved closed form aproximations to this expansion problem
- a matlab function that numericaly solves the ODE

These features are usefull for
- fitting an expanded BEC for determinieng trap parameters
  - anayltical solutions can be used for the inital fit
  - then can be honed in with numerical calculation
- on paper derivations that require the width of a BEC after some expansion time
  - a decent aproximation is often all that is needed
  


## References
<a id="1">[1]</a> 
[Y. Castin and R. Dum, “Bose-Einstein Condensates in Time Dependent Traps,” Physical Review Letters, vol. 77, no. 27, pp. 5315–5319, Dec. 1996](https://doi.org/10.1103/PhysRevLett.77.5315) 
<a id="2">[2]</a> 
[Rui-Zong Li (李睿宗)1,3, Tian-You Gao (高天佑)1, Dong-Fang Zhang et al. , “Expansion dynamics of a spherical Bose–Einstein condensate,” Chinese Phys. B 28 106701, 2019](https://doi.org/10.1103/PhysRevLett.77.5315) 

