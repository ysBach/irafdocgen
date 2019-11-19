# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

# ADIV -- Divide two vectors (generic).  No divide by zero checking is
# performed.  If this is desired, advz should be used instead.

procedure adivr (a, b, c, npix)

real	a[ARB], b[ARB], c[ARB]
int	npix, i

begin
	do i = 1, npix
	    c[i] = a[i] / b[i]
end
