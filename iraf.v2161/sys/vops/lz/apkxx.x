# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

# APKX -- Generate a type COMPLEX output vector given the real and imaginary
# components as input vectors.

procedure apkxx (a, b, c, npix)

complex	a[ARB]			# real component
complex	b[ARB]			# imaginary component
complex	c[ARB]			# output vector
int	npix, i

begin
	do i = 1, npix
		c[i] = complex (real(a[i]), aimag(b[i]))
end
