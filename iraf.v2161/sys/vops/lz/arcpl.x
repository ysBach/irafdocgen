# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

# ARCP -- Reciprocal of a constant divided by a vector.  No divide by zero
# checking is performed.

procedure arcpl (a, b, c, npix)

long	a		# constant numerator
long	b[ARB]		# vector denominator
long	c[ARB]		# output vector
int	npix
int	i

begin
	if (a == 0) {
	    call aclrl (c, npix)
	} else if (a == 1) {
	    do i = 1, npix
		c[i] = 1 / b[i]
	} else {
	    do i = 1, npix
		c[i] = a / b[i]
	}
end
