# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

# AMGS -- Return the square of the magnitude of two vectors.

procedure amgsx (a, b, c, npix)

complex	a[ARB], b[ARB], c[ARB]
int	npix, i

begin
	do i = 1, npix
	    c[i] = a[i] ** 2 + b[i] ** 2
end
