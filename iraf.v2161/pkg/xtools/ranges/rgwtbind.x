# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

include	<pkg/rg.h>

# RG_WTBIN -- Weighted average or median of data.
#
# The ranges are broken up into subranges of at most abs (nbin) points and a
# minimum of max (3, (abs(nbin)+1)/2) (though always at least one bin).  The
# subranges are weighted averaged if nbin > 1 and medianed if nbin < 1.
# The output weights are the sum of the weights for each subrange.
# The output array must be large enough to contain the desired points.
# If the ranges are merged then the input and output arrays may be the same.

procedure rg_wtbind (rg, nbin, in, wtin, nin, out, wtout, nout)

pointer	rg				# Ranges
int	nbin				# Maximum points in average or median
double	in[nin]				# Input array
double	wtin[nin]			# Input weights
int	nin				# Number of input points
double	out[ARB]			# Output array
double	wtout[ARB]			# Output weights
int	nout				# Number of output points

int	i, j, k, l, n, npts, ntemp, nsample

double	asumd(), amedd()

errchk	rg_packd

begin
	# Check for a null set of ranges.

	if (rg == NULL)
	    call error (0, "Range descriptor undefined")

	# If the bin size is exactly one then move the selected input points
	# to the output array.

	if (abs (nbin) < 2) {
	    call rg_packd (rg, in, out)
	    call rg_packd (rg, wtin, wtout)
	    nout = RG_NPTS(rg)
	    return
	}

	# Determine the subranges and take the median or average.

	npts = abs (nbin)
	ntemp = 0

	do i = 1, RG_NRGS(rg) {
	    nsample = 0
	    if (RG_X1(rg, i) > RG_X2(rg, i)) {
		j = min (nin, RG_X1(rg, i))
		k = max (1, RG_X2(rg, i))
		while (j >= k) {
		    n = max (0, min (npts, j - k + 1))
		    if (nsample > 0 && n < max (min (npts, 3), (npts+1)/2))
			break
		    k = k - n
		    nsample = nsample + 1
		    ntemp = ntemp + 1
		    wtout[ntemp] = asumd (wtin[k + 1], n)
		    if (nbin > 0) {
		        if (wtout[ntemp] != 0.) {
			    out[ntemp] = 0.
			    do l = k + 1, k + n
			        out[ntemp] = out[ntemp] + in[l] * wtin[l]
		            out[ntemp] = out[ntemp] / wtout[ntemp]
			} else {
			    out[ntemp] = 0.
			    do l = k + 1, k + n
			        out[ntemp] = out[ntemp] + in[l]
		            out[ntemp] = out[ntemp] / n
			}
		    } else {
			out[ntemp] = amedd (in[k+1], n)
		    }
		}
	    } else {
		j = max (1, RG_X1(rg, i))
		k = min (nin, RG_X2(rg, i))
	        while (j <= k) {
		    n = max (0, min (npts, k - j + 1))
		    if (nsample > 0 && n < max (min (npts, 3), (npts+1)/2))
			break
		    nsample = nsample + 1
		    ntemp = ntemp + 1
		    wtout[ntemp] = asumd (wtin[j], n)
		    if (nbin > 0) {
			if (wtout[ntemp] != 0.) {
			    out[ntemp] = 0.
			    do l = j, j + n - 1
		                out[ntemp] = out[ntemp] + in[l] * wtin[l]
			    out[ntemp] = out[ntemp] / wtout[ntemp]
			} else {
			    out[ntemp] = 0.
			    do l = j, j + n - 1
		                out[ntemp] = out[ntemp] + in[l]
			    out[ntemp] = out[ntemp] / n
			}
		    } else {
			out[ntemp] = amedd (in[j], n)
		    }
		    j = j + n
		}
	    }
	}

	nout = ntemp
end
