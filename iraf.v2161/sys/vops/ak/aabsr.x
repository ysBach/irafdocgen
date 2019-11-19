# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

# AABS -- Compute the absolute value of a vector (generic).

procedure aabsr (a, b, npix)

real	a[ARB], b[ARB]
int	npix, i

begin
	do i = 1, npix
	    b[i] = abs(a[i])
end
