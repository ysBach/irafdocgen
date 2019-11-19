# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

# AMED4 -- Median of four vectors.  Each output point M[i] is the median of the
# four input points A[i],B[i],C[i],D[i].  The vector min and max are also
# computed and returned in the A and D vectors.  The input vectors are modifed
# in place.

procedure amed4d (a, b, c, d, m, npix)

double	a[ARB], b[ARB]		# input vectors
double	c[ARB], d[ARB]		# input vectors
double	m[ARB]				# output vector (median)
int	npix

int	i
double	temp
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

	    # Move the maximum value to D[i].
	    if (b[i] > d[i])
		swap (b[i], d[i])
	    if (c[i] > d[i])
		swap (c[i], d[i])

	    # Return the median value.
	    if (b[i] < c[i])
		m[i] = b[i]
	    else
		m[i] = c[i]
	}
end
