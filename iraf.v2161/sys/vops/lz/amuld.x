# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

# AMUL -- Multiply two vectors (generic).

procedure amuld (a, b, c, npix)

double	a[ARB], b[ARB], c[ARB]
int	npix, i

begin
	do i = 1, npix
	    c[i] = a[i] * b[i]
end
