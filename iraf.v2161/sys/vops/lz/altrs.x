# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

# ALTR -- Linearly map a vector into another vector of the same datatype.
# This is the most general form.  See also ALTA and ALTM.
#	b[i] = (a[i] + k1) * k2 + k3

procedure altrs (a, b, npix, k1, k2, k3)

short	a[ARB], b[ARB]
real	k1, k2, k3
int	npix, i

begin
	do i = 1, npix
	    b[i] = (a[i] + k1) * k2 + k3
end
