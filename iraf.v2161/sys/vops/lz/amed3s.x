# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

# AMED3 -- Median of three vectors.  Each output point M[i] is the median value
# of the three input points A[i],B[i],C[i].

procedure amed3s (a, b, c, m, npix)

short	a[ARB], b[ARB], c[ARB]	# input vectors
short	m[ARB]				# output vector (median)
int	npix
int	i

begin
	do i = 1, npix
	    if (a[i] < b[i]) {
		if (b[i] < c[i])		# abc
		    m[i] = b[i]
		else if (a[i] < c[i])		# acb
		    m[i] = c[i]
		else				# cab
		    m[i] = a[i]
	    } else {
		if (b[i] > c[i])		# cba
		    m[i] = b[i]
		else if (a[i] > c[i])		# bca
		    m[i] = c[i]
		else				# bac
		    m[i] = a[i]
	    }
end
