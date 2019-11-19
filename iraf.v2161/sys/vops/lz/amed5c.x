# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

# AMED5 -- Median of five vectors.  Each output point M[i] is the median of the
# five input points A[i],B[i],C[i],D[i],E[i].  The vector min and max are also
# computed and returned in the A and E vectors.  The input vectors are modifed.

procedure amed5c (a, b, c, d, e, m, npix)

char	a[ARB], b[ARB]		# input vectors
char	c[ARB], d[ARB], e[ARB]	# input vectors
char	m[ARB]				# output vector (median)
int	npix

int	i
char	temp
define	swap {temp=$1;$1=$2;$2=temp}

begin
	do i = 1, npix {
	    # Move the minimum value to A[i].
	    if (b[i] < a[i])
		swap (b[i], a[i])
	    if (c[i] < a[i])
		swap (c[i], a[i])
	    if (d[i] < a[i])
		swap (d[i], a[i])
	    if (e[i] < a[i])
		swap (e[i], a[i])

	    # Move the maximum value to E[i].
	    if (b[i] > e[i])
		swap (b[i], e[i])
	    if (c[i] > e[i])
		swap (c[i], e[i])
	    if (d[i] > e[i])
		swap (d[i], e[i])

	    # Return the median value of the central three points.
	    if (b[i] < c[i]) {
		if (c[i] < d[i])		# bcd
		    m[i] = c[i]
		else if (b[i] < d[i])		# bdc
		    m[i] = d[i]
		else				# dbc
		    m[i] = b[i]
	    } else {
		if (c[i] > d[i])		# dcb
		    m[i] = c[i]
		else if (b[i] > d[i])		# cdb
		    m[i] = d[i]
		else				# cbd
		    m[i] = b[i]
	    }
	}
end
