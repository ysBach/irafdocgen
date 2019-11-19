# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

include	<gset.h>
include	<pkg/rg.h>

# RG_GXMARK -- Mark x ranges.

procedure rg_gxmarkr (gp, rstr, x, npts, pltype)

pointer	gp				# GIO pointer
char	rstr[ARB]			# Range string
real	x[npts]				# Ordinates of graph
int	npts				# Number of data points
int	pltype				# Plot line type

pointer	rg
int	i, pltype1
real	xl, xr, yb, yt, dy
real	x1, x2, y1, y2, y3

int	gstati(), stridxs()
pointer	rg_xrangesr()

begin
	if (stridxs ("*", rstr) > 0)
	    return

	rg = rg_xrangesr (rstr, x, npts)

	pltype1 = gstati (gp, G_PLTYPE)
	call gseti (gp, G_PLTYPE, pltype)

	call ggwind (gp, xl, xr, yb, yt)

	dy = yt - yb
	y1 = yb + dy / 100
	y2 = y1 + dy / 20
	y3 = (y1 + y2) / 2

	do i = 1, RG_NRGS(rg) {
	    x1 = x[RG_X1(rg, i)]
	    x2 = x[RG_X2(rg, i)]
	    if ((x1 > xl) && (x1 < xr))
	        call gline (gp, x1, y1, x1, y2)
	    if ((x2 > xl) && (x2 < xr))
	        call gline (gp, x2, y1, x2, y2)
	    call gline (gp, x1, y3, x2, y3)
	}

	call gseti (gp, G_PLTYPE, pltype1)
	call rg_free (rg)
end
