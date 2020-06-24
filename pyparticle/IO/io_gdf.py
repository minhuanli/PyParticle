import numpy as np

def read_gdf(fn):
    
    """Basic Python read_gdf routine
       Based on http://physics.nyu.edu/grierlab/software/read_gdf.pro
       and therefore also licensed under the GPLv2
       
       Copyright (c) 1991-2010 David G. Grier
       Copyright (c) 2014 Merlijn van Deen
       
       Note: Only supports binary, same-endian, float32 arrays!
       
       @param fn File name
       @returns numpy array with contents of fn
       
       Modefied by MinHuan_Li @ Nov 2019, To Python3 Version
    """

    ### Header data structure:
    # Nbytes dtype contents
    # 4      int32  MAGIC
    # 4      int32  number of dimensions
    # 4*ndim int32  dimension lengths
    # 4      int32  data type (see http://www.exelisvis.com/docs/SIZE.html)
    # 4      int32  total data size (= product of dimension lengths)
    #
    # This is followed by *count* bytes of type *dtype*

    data = open(fn, 'rb')
    
    # First read the MAGIC, which should be 82991L == \x24\x44\x01\x00
    magic = np.frombuffer(data.read(4), np.int32)
    assert(int(magic) == 82991)
    
    ndim = np.frombuffer(data.read(4), np.int32)
    dims = np.frombuffer(data.read(int(ndim*4)), np.int32)
    
    dtype = np.frombuffer(data.read(4), np.int32)
    
    count = np.frombuffer(data.read(4), np.int32)
    
    assert(int(count) == np.product(dims))
    
    # For now, we only support float32. Can be extended easily, but needs testing
    # to see if the underlying formats are the same.
    # see http://www.exelisvis.com/docs/SIZE.html for details
    
    dtype_FLOAT = 4
    assert(int(dtype) == dtype_FLOAT)
    
    data = np.fromfile(data, dtype=np.float32, count=int(count))
    
    # IDL uses fortran-indexed arrays
    data = data.reshape(dims, order='F')
    
    return(data)