# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

# AVEQ -- Compare two vectors for equality.

bool procedure aveqr (a, b, npix)

real	a[ARB], b[ARB]		#I vectors to be compared
int	npix			#I number of pixels to be compared

int	i

begin
	do i = 1, npix
	    if (a[i] != b[i])
		return (false)

	return (true)
end
