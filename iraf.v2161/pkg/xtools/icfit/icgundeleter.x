# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

include	<gset.h>
include	<mach.h>
include	<pkg/gtools.h>
include	"icfit.h"

define	MSIZE		2.		# Mark size

# ICG_UNDELETE -- Undelete data point nearest the cursor.
# The nearest point to the cursor in NDC coordinates is determined.

procedure icg_undeleter (ic, gp, gt, cv, x, y, wts, userwts, npts, wx, wy)

pointer	ic					# ICFIT pointer
pointer	gp					# GIO pointer
pointer	gt					# GTOOLS pointer
pointer	cv					# CURFIT pointer
real	x[npts], y[npts]			# Data points
real	wts[npts], userwts[npts]		# Weight arrays
int	npts					# Number of points
real	wx, wy					# Position to be nearest

pointer	sp, xout, yout

int	gt_geti()

begin
	call smark (sp)
	call salloc (xout, npts, TY_REAL)
	call salloc (yout, npts, TY_REAL)

	call icg_axesr (ic, gt, cv, 1, x, y, Memr[xout], npts)
	call icg_axesr (ic, gt, cv, 2, x, y, Memr[yout], npts)

	if (gt_geti (gt, GTTRANSPOSE) == NO)
	    call icg_u1r (ic, gp, Memr[xout], Memr[yout], wts, userwts,
		npts, wx, wy)
	else
	    call icg_u1r (ic, gp, Memr[yout], Memr[xout], wts, userwts,
		npts, wy, wx)

	call sfree (sp)
end


# ICG_U1 -- Do the actual undelete.

procedure icg_u1r (ic, gp, x, y, wts, userwts, npts, wx, wy)

pointer	ic					# ICFIT pointer
pointer	gp					# GIO pointer
real	x[npts], y[npts]			# Data points
real	wts[npts], userwts[npts]		# Weight arrays
int	npts					# Number of points
real	wx, wy					# Position to be nearest

int	i, j
real	x0, y0, r2, r2min

begin
	# Transform world cursor coordinates to NDC.

	call gctran (gp, wx, wy, wx, wy, 1, 0)

	# Search for nearest point to a point with zero weight.

	r2min = MAX_REAL
	do i = 1, npts {
	    if (wts[i] != 0.)
		next

	    call gctran (gp, real (x[i]), real (y[i]), x0, y0, 1, 0)

	    r2 = (x0 - wx) ** 2 + (y0 - wy) ** 2
	    if (r2 < r2min) {
		r2min = r2
		j = i
	    }
	}

	# Unmark the deleted point and reset the weight.

	if (j != 0) {
	    call gscur (gp, real (x[j]), real (y[j]))
	    call gseti (gp, G_PMLTYPE, GL_CLEAR)
	    call gmark (gp, real (x[j]), real (y[j]), GM_CROSS, MSIZE, MSIZE)
	    call gseti (gp, G_PMLTYPE, GL_SOLID)
	    call gline (gp, real (x[j]), real (y[j]), real (x[j]), real (y[j]))
	    wts[j] = userwts[j]
	    IC_NEWWTS(ic) = YES
	}
end
