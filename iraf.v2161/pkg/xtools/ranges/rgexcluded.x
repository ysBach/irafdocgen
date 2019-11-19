# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

include	<pkg/rg.h>

# RG_EXCLUDE -- Exclude points given by ranges.
#
# The output array must be large enough to contain the desired points.
# If the ranges are merged then the input and output arrays may be the same.

procedure rg_excluded (rg, a, nin, b, nout)

pointer	rg					# Ranges
double	a[nin]					# Input array
int	nin					# Number of input points
double	b[ARB]					# Output array
int	nout					# Number of output points

int	i, j, k, n, ntemp

begin
	# Error check the range pointer.

	if (rg == NULL)
	    call error (0, "Range descriptor undefined")

	if (RG_NRGS(rg) == 0) {
	    call amovd (a[1], b[1], nin)
	    nout = nin
	} else {
	    ntemp = 0

	    i = 1
	    j = 1
	    k = min (nin, min (RG_X1(rg, i), RG_X2(rg, i)) - 1)
	    n = max (0, k - j + 1)
	    call amovd (a[j], b[ntemp+1], n)
	    ntemp = ntemp + n

	    do i = 2, RG_NRGS(rg) {
	        j = max (1, max (RG_X1(rg, i-1), RG_X2(rg, i-1)) + 1)
	        k = min (nin, min (RG_X1(rg, i), RG_X2(rg, i)) - 1)
	        n = max (0, k - j + 1)
	        call amovd (a[j], b[ntemp+1], n)
	        ntemp = ntemp + n
	    }

	    i = RG_NRGS (rg)
	    j = max (1, max (RG_X1(rg, i), RG_X2(rg, i)) + 1)
	    k = nin
	    n = max (0, k - j + 1)
	    call amovd (a[j], b[ntemp+1], n)
	    ntemp = ntemp + n
	}

	nout = ntemp
end
