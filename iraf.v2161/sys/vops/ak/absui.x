# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

# ABSU -- Vector block sum.  Each pixel in the output vector is the
# sum of the input vector over a block of pixels.  The input vector must
# be at least (nblocks * npix_per_block) pixels in length.

procedure absui (a, b, nblocks, npix_per_block)

int	a[ARB]			# input vector
int	b[nblocks]		# output vector
int	nblocks			# number of blocks (pixels in output vector)
int	npix_per_block		# number of input pixels per block

real	sum

int	i, j
int	block_offset, next_block, block_length

begin
	block_offset = 1
	block_length = npix_per_block

	if (block_length <= 1)
	    call amovi (a[block_offset], b, nblocks)
	else {
	    do j = 1, nblocks {
		next_block = block_offset + block_length
		sum = 0
		do i = block_offset, next_block - 1
		    sum = sum + a[i]
		b[j] = sum
		block_offset = next_block
	    }
	}
end
