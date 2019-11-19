# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

include	<syserr.h>
include	"../qpoe.h"

# QP_PUT -- Set the value of the named header parameter.  Automatic type
# conversion is performed where possible.  While only scalar values can be
# set by this function, the scalar may be an element of a one-dimensional
# array, e.g., "param[N]".

procedure qp_puts (qp, param, value)

pointer	qp			#I QPOE descriptor
char	param[ARB]		#I parameter name
short	value			#I scalar parameter value

pointer	pp
bool	indef
int	dtype
int	qp_putparam()
errchk	qp_putparam, syserrs

begin
	# Lookup the parameter and get a pointer to the value buffer.
	dtype = qp_putparam (qp, param, pp)
	if (pp == NULL)
	    call syserrs (SYS_QPNOVAL, param)

	if (QP_DEBUG(qp) > 1) {
	    call eprintf ("qp_put: `%s', TYP=(%d->%d), new value %g\n")
		call pargstr (param)
		call pargi (TY_SHORT)
		call pargi (dtype)
		call pargs (value)
	}

	indef = IS_INDEFS(value)

	# Set the parameter value.
	switch (dtype) {
	case TY_CHAR:
	    Memc[pp] = value
	case TY_SHORT:
	    if (indef)
		Mems[pp] = INDEFS
	    else
		Mems[pp] = value
	case TY_INT:
	    if (indef)
		Memi[pp] = INDEFI
	    else
		Memi[pp] = value
	case TY_LONG:
	    if (indef)
		Meml[pp] = INDEFL
	    else
		Meml[pp] = value
	case TY_REAL:
	    if (indef)
		Memr[pp] = INDEFR
	    else
		Memr[pp] = value
	case TY_DOUBLE:
	    if (indef)
		Memd[pp] = INDEFD
	    else
		Memd[pp] = value
	default:
	    call syserrs (SYS_QPBADCONV, param)
	}

	# Update the parameter in the datafile.
	call qp_flushpar (qp)
end
