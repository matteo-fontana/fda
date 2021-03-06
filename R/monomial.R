monomial <- function(evalarg, exponents=1, nderiv=0, argtrans=c(0,1))
{
#  MONOMIAL Values of monomials, or their derivatives.
#  The powers of EVALARG are the NBASIS nonnegative integers in EXPONENTS.
#  The default is 1, meaning EVALARG itself.
#  Arguments are as follows:
#  EVALARG   ... array of values at which the polynomials are to
#                evaluated
#  EXPONENTS ... array of nonnegative integer exponents of EVALARG
#  NDERIV    ... order of derivative to be returned.
  #  ARGTRANS  ... A vector of two constants for shifting and scaling the 
  #                argument range.  In function MONOMIAL and MONOM, 
  #                the EVALARG is transformed to 
  #                [evalarg-argtrans(1))/evalarg(2);
  #                Defaults to [0,1]
  #  Return is:
#  A matrix with length(EVALARG) rows and NBASIS columns containing
#    the values of the monomials or their derivatives

#  last modified 9 January 2020 by Jim Ramsay

	evalarg <- as.vector(evalarg)
	evalarg <- (evalarg - argtrans[1])/argtrans[2]
  n       <- length(evalarg)    

	nbasis <- length(exponents)

	#  check whether exponents are nonnegative integers

	for (ibasis in 1:nbasis) {
    	if (exponents[ibasis] - round(exponents[ibasis]) != 0) {
        	stop("An exponent is not an integer.")
    	}
    	if (exponents[ibasis] < 0) {
        	stop("An exponent is negative.")
    	}
	}

	# check if there are duplicate exponents

  if((length(exponents)>1) && (min(diff(sort(exponents))) == 0))
          stop("There are duplicate exponents.")

	monommat <- matrix(0,n,nbasis)

	if (nderiv == 0) {
    	#  use the recursion formula to compute monomnomial values
    	for (ibasis in 1:nbasis) {
			monommat[,ibasis] <- evalarg^exponents[ibasis]
		}
	} else {
    	for (ibasis in 1:nbasis) {
    	  print(ibasis)
        	degree <- exponents[ibasis]
        	if (nderiv <= degree) {
            	fac <- degree
            	if (nderiv >= 2) {
            	    for (ideriv in 2:nderiv) {
                	    fac <- fac*(degree-ideriv)
           	      }
           	  }
            	print(fac)
            	print(degree-nderiv)
            	monommat[,ibasis] <- fac*evalarg^(degree-nderiv)
        	}
    	}
	}

	return(monommat)
}

