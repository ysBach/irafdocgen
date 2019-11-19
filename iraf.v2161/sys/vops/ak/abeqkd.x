# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

# ABEQK -- Vector boolean equals constant.  C[i], type INT, is set to 1 if
# A[i] equals B, else C[i] is set to zero.

procedure abeqkd (a, b, c, npix)

double	a[ARB]
double	b
int	c[ARB]
int	npix
int	i

begin
	# The case b==0 is perhaps worth optimizing.  On many machines this
	# will save a memory fetch.

	if (b == 0.0D0) {
	    do i = 1, npix
		if (a[i] == 0.0D0)
		    c[i] = 1
		else
		    c[i] = 0
	} else {
	    do i = 1, npix
		if (a[i] == b)
		    c[i] = 1
		else
		    c[i] = 0
	}
end
