# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

include <math/curfit.h>

include "curfitdef.h"


# CVSOLVE -- Solve the matrix normal equations of the form ca = b for a,
# where c is a symmetric, positive semi-definite, banded matrix with
# CV_NCOEFF(cv) rows and a and b are CV_NCOEFF(cv)-vectors.
# Initially c is stored in the CV_ORDER(cv) by CV_NCOEFF(cv) matrix MATRIX
# and b is stored in VECTOR.
# The Cholesky factorization of MATRIX is calculated and stored in CHOFAC.
# Finally the coefficients are calculated by forward and back substitution
# and stored in COEFF.

procedure cvsolve (cv, ier)


pointer	cv 		# curve descriptor
int	ier		# ier = OK, everything OK
			# ier = SINGULAR, matrix is singular, 1 or more
			# coefficients are 0.
			# ier = NO_DEG_FREEDOM, too few points to solve matrix
int	nfree

begin
	ier = OK
	nfree = CV_NPTS(cv) - CV_NCOEFF(cv)

	if (nfree < 0) {
	    ier = NO_DEG_FREEDOM
	    return
	}

	# calculate the Cholesky factorization of the data matrix
	call rcvchofac (MATRIX(CV_MATRIX(cv)), CV_ORDER(cv), CV_NCOEFF(cv),
		    CHOFAC(CV_CHOFAC(cv)), ier)

	# solve for the coefficients by forward and back substitution
	call rcvchoslv (CHOFAC(CV_CHOFAC(cv)), CV_ORDER(cv), CV_NCOEFF(cv),
		    VECTOR(CV_VECTOR(cv)), COEFF(CV_COEFF(cv)))
end
