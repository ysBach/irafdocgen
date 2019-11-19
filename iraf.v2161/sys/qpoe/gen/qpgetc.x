# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

include	<syserr.h>
include	"../qpoe.h"

# QP_GET -- Return the value of the named header parameter.  Automatic type
# conversion is performed where possible.  While only scalar values can be
# returned by this function, the scalar may be an element of a one-dimensional
# array, e.g., "param[N]".

char procedure qp_getc (qp, param)

pointer	qp			#I QPOE descriptor
char	param[ARB]		#I parameter name

pointer	pp
int	dtype
char	value
int	qp_getparam()
errchk	qp_getparam, syserrs

begin
	# Lookup the parameter and it's value.
	dtype = qp_getparam (qp, param, pp)
	if (pp == NULL)
	    call syserrs (SYS_QPNOVAL, param)

	# Set default value of INDEF or NULL.
	    value = (NULL)

	# Get a valid parameter value.
	switch (dtype) {
	case TY_CHAR:
	    value = (Memc[pp])
	case TY_SHORT:
	    if (!IS_INDEFS(Mems[pp]))
		value = (Mems[pp])
	case TY_INT:
	    if (!IS_INDEFI(Memi[pp]))
		value = (Memi[pp])
	case TY_LONG:
	    if (!IS_INDEFL(Meml[pp]))
		value = (Meml[pp])
	case TY_REAL:
	    if (!IS_INDEFR(Memr[pp]))
		value = (Memr[pp])
	case TY_DOUBLE:
	    if (!IS_INDEFD(Memd[pp]))
		value = (Memd[pp])
	default:
	    call syserrs (SYS_QPBADCONV, param)
	}

	if (QP_DEBUG(qp) > 1) {
	    call eprintf ("qp_get: `%s', TYP=(%d->%d) returns %g\n")
		call pargstr (param)
		call pargi (dtype)
		call pargi (TY_CHAR)
		call pargc (value)
	}

	return (value)
end
