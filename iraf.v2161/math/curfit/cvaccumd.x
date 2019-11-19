# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

include <math/curfit.h>

include "dcurfitdef.h"

# CVACCUM -- Procedure to add a data point to the set of normal equations.
# The inner products of the basis functions are added into the CV_ORDER(cv)
# by CV_NCOEFF(cv) array MATRIX. The first row of MATRIX
# contains the main diagonal of the matrix followed by
# the CV_ORDER(cv) lower diagonals. This method of storing MATRIX
# minimizes the space required by large symmetric, banded matrices.
# The inner products of the basis functions and the data ordinates are
# stored in VECTOR which has CV_NCOEFF(cv) elements. The integers left
# and leftm1 are used to determine which elements of MATRIX and VECTOR
# are to receive the data.

procedure dcvaccum (cv, x, y, w, wtflag)

pointer	cv		# curve descriptor
double	x		# x value
double	y		# y value
double	w		# weight of the data point
int	wtflag		# type of weighting desired

int	left, i, ii, j
double	bw
pointer	xzptr
pointer	mzptr, mzzptr
pointer	vzptr

begin

	# increment number of points
	CV_NPTS(cv) = CV_NPTS(cv) + 1

	# calculate the weights
	switch (wtflag) {
	case WTS_UNIFORM, WTS_SPACING:
	    w = 1.0
	case WTS_USER:
	    # user defined weights
	case WTS_CHISQ:
	    # data assumed to be scaled to photons with Poisson statistics
	    if (y > 0.0)
	        w = 1.0 / y
	    else if (y < 0.0)
		w = - 1.0 / y
	    else
		w = 0.0
	default:
	    w = 1.0
	}

	# calculate all non-zero basis functions for a given data point
	switch (CV_TYPE(cv)) {
	case CHEBYSHEV:
	    left = 0
	    call dcv_b1cheb (x, CV_ORDER(cv), CV_MAXMIN(cv), CV_RANGE(cv),
			    XBASIS(CV_XBASIS(cv)))
	case LEGENDRE:
	    left = 0
	    call dcv_b1leg (x, CV_ORDER(cv), CV_MAXMIN(cv), CV_RANGE(cv),
			    XBASIS(CV_XBASIS(cv)))
	case SPLINE3:
	    call dcv_b1spline3 (x, CV_NPIECES(cv), -CV_XMIN(cv),
	         CV_SPACING(cv), XBASIS(CV_XBASIS(cv)), left)
	case SPLINE1:
	    call dcv_b1spline1 (x, CV_NPIECES(cv), -CV_XMIN(cv),
	         CV_SPACING(cv), XBASIS(CV_XBASIS(cv)), left)
	case USERFNC:
	    left = 0
	    call dcv_b1user (cv, x)
	}

	# index the pointers
	xzptr = CV_XBASIS(cv) - 1
	vzptr = CV_VECTOR(cv) + left - 1
	mzptr = CV_MATRIX(cv) + CV_ORDER(CV) * (left - 1)

	# accumulate the data point into the matrix and vector
	do i = 1, CV_ORDER(cv) {

	    # calculate the non-zero basis functions
	    bw = XBASIS(xzptr+i) * w

	    # add the inner product of the basis functions and the ordinate
	    # into the appropriate element of VECTOR
	    VECTOR(vzptr+i) = VECTOR(vzptr+i) + bw * y

	    # accumulate the inner products of the basis functions into
	    # the apprpriate element of MATRIX
	    mzzptr = mzptr + i * CV_ORDER(cv)
	    ii = 0
	    do j = i, CV_ORDER(cv) {
		MATRIX(mzzptr+ii) = MATRIX(mzzptr+ii) + XBASIS(xzptr+j) * bw
		ii = ii + 1
	    }
	}
end
