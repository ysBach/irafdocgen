# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

# ASEL -- Vector select element.  The output vector is formed by taking
# successive pixels from either of the two input vectors, based on the value
# of the integer (boolean) selection vectors.  Used to implement vector
# conditional expressions.

procedure aseld (a, b, c, sel, npix)

double	a[ARB], b[ARB], c[ARB]
int	sel[ARB]			# IF sel[i] THEN a[i] ELSE b[i]
int	npix
int	i

begin
	do i = 1, npix
	    if (sel[i] != 0)
		c[i] = a[i]
	    else
		c[i] = b[i]
end
