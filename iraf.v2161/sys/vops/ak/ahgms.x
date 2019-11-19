# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

include	<mach.h>

# AHGM -- Accumulate the histogram of the input vector.  The output vector
# HGM (the histogram) should be cleared prior to the first call.

procedure ahgms (data, npix, hgm, nbins, z1, z2)

short 	data[ARB]		# data vector
int	npix			# number of pixels
int	hgm[ARB]		# output histogram
int	nbins			# number of bins in histogram
short	z1, z2			# greyscale values of first and last bins

short	z
real	dz
int	bin, i

begin
	dz = real (nbins - 1) / real (z2 - z1)
	if (abs (dz - 1.0) < (EPSILONR * 2.0)) {
	    do i = 1, npix {
		z = data[i]
		if (z >= z1 && z <= z2) {
		    bin = int (z - z1) + 1
		    hgm[bin] = hgm[bin] + 1
		}
	    }
	} else {
	    do i = 1, npix {
		z = data[i]
		if (z >= z1 && z <= z2) {
		    bin = int ((z - z1) * dz) + 1
		    hgm[bin] = hgm[bin] + 1
		}
	    }
	}
end
