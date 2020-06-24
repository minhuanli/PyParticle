import numpy as np
import scipy.optimize as opt
from tqdm import tqdm_notebook as tqdm



def conlist_id(cpdata,bgdata,rmax,nmax):
    
    '''
    The function return particle id of center particle's neighbour
    particle id here is a parameter, generated after track
    
    all data should have shape (particle number, parameter number)
    x: [:,0]  y:[:,1]   z:[:,1]     particl id [:,-1]
    
    input:
    1. cpdata, center particles' data
    2. bgdata, background particles's data, to search neighbours
    3. rmax, max distance range
    4. nmax, max neighbour number
    
    output:
    search for nmax+1 nearest neighbors
    ndarray, with shape (cpdata number, nmax + 2)
    each row corresponds to a cpdata particle
    neighbour number, neighbour id 1, neighbour id 2, ....
    sorted with distance
    if the bgdata contains the cpdata, the first neighbour should be itself
    '''
    # n1, cpdata particle number; 
    # n2, parameter number 
    n1,n2 = cpdata.shape
    
    nblist = np.full((n1,nmax+2),-1,dtype=int) # initialize outpout array
    cpid_list = np.array(cpdata[:,-1],dtype=np.int) # list of center particle id 
    
    for i in tqdm(range(n1)):
        cpi = cpdata[i,:]
        xmin=cpi[0]-rmax
        ymin=cpi[1]-rmax
        zmin=cpi[2]-rmax
        xmax=cpi[0]+rmax
        ymax=cpi[1]+rmax
        zmax=cpi[2]+rmax
        wi = np.argwhere((bgdata[:,0] >= xmin) & (bgdata[:,0] <= xmax) &
                         (bgdata[:,1] >= ymin) & (bgdata[:,1] <= ymax) &
                         (bgdata[:,2] >= zmin) & (bgdata[:,2] <= zmax)).reshape(-1)
        
        nb_box = bgdata[wi].copy()
        dis_box = np.linalg.norm(nb_box[:,0:3] - cpi[0:3],axis=1)
        ww = np.argsort(dis_box)
        
        # neighbour number, determined by rmax or nmax +1 
        ni = min((dis_box<rmax).sum(),nmax+1)   
        #if i % 1000 == 0:
            #print ((dis_box<rmax).sum(),ni)
        nblist[i,0] = ni   # record the neighbour number 
        nblist[i,1:ni+1] = nb_box[ww[0:ni],-1]   # recourd the neighbour id
        #nb_pos = nb_box[ww[0:ni],0:3]   # record the neighbour positions
        
    return nblist



def nonaffine_equa(D,R_ij,r_ij):
    '''
    return  \sum_j[r_j - r_i - D( R_j - R_i )]^2 
    
    Input:
    1. D, should be 1D array, size = 9
    2. R_ij, shape (nb_num,3), relative positon at time 1
    3. r_ij, shape (nb_num,3), relative positon at time 2
    
    Return:
    a scalar, which will be minimized later
    '''
    return np.linalg.norm(r_ij - np.matmul(R_ij,D.reshape(3,3)),axis=1).sum()


def nonaffine_all(cpdata,bgdata1,bgdata2,rmax,nmax):
    '''
    The function return nonaffine parameter of each center particle
    \chi(i) = min(\sum_j[r_j - r_i - D( R_j - R_i )]^2)
    
    all data should have shape (particle number, parameter number)
    x: [:,0]  y:[:,1]   z:[:,1]     particl id: [:,-1]
    
    Input:
    1. cpdata, center particles' data
    2. bgdata1, background particles's data, to search neighbours, time 1
       bgdata2, background particles's data, to search neighbours, time 2
    3. rmax, max distance range, to search neighbour
    4. nmax, max neighbour number
    
    Return:
    nonaffine parameter, affine matrix
    1. nonaffine parameter: 2-D array, size = cpdata particle number
       [:,0], neighbour number   [:,1], the minimum nonaffine parameter
    2. affine matrix, matrix D for each particle
       each has been flat into 1D array, size 9
    
    Reference:
    Falk. and Langer. Physical Review E 57.6 (1998): 7192. 
    '''
    
    # n1, cpdata particle number; 
    # n2, parameter number 
    n1,n2 = cpdata.shape
    
    # generate neighbour list from initial configuration
    nblist = conlist_id(cpdata,bgdata1,rmax,nmax)

    NonaffineRes = np.full((n1,2),-1.) # initialize output array, for nonaffine parameter
    AffineMatrix = np.full((n1,9),-1.) # initialize output array, for affine matrix
    
    for i in tqdm(range(n1)):
        
        # check if the center particle id exsits in the time 2 configuration
        ww0 = np.argwhere(bgdata2[:,-1] == nblist[i][1])
        if ww0.size == 0:
            continue
        
        nn1 = nblist[i][0] - 1  # neighbour number, in time 1
        cp_pos_1 = cpdata[i,0:3] # center particle position, R_i, time 1
        cp_pos_2 = bgdata2[ww0[0,0],0:3] # center particle position, r_i, time 2
        
        # initialize array to store neighbour positions
        nb_pos_1 = np.array([])
        nb_pos_2 = np.array([])
        
        l = 0  # count useful neighbor number
        for j in range(2,nn1+2):
            
            wwj2 = np.argwhere(bgdata2[:,-1] == nblist[i][j])
            
            # check if this neighbour id exsits in bgdata 2 
            if wwj2.size == 0:
                continue 
            l = l + 1
            
            # neighbour j in time 1 bgdata
            wwj1 = np.argwhere(bgdata1[:,-1] == nblist[i][j])
            
            nb_pos_1 = np.hstack((nb_pos_1,bgdata1[wwj1[0,0],0:3])) # record R_j
            nb_pos_2 = np.hstack((nb_pos_2,bgdata2[wwj2[0,0],0:3]))  # record r_j    
        
        if l < 5: continue  
        
        R_ij = nb_pos_1.reshape(-1,3) - cp_pos_1  # r_ij
        r_ij = nb_pos_2.reshape(-1,3) - cp_pos_2  # R_ij

        D0 = np.array([1.,0.,0.,0.,1.,0.,0.,0.,1.]) # initial D
        
        # minimize function from scipy.opt.minimize
        wrap = opt.minimize(nonaffine_equa,D0,args=(R_ij,r_ij))  
           
        NonaffineRes[i,0] = l
        NonaffineRes[i,1] = wrap.fun # minimum nonaffine parameter
        
        AffineMatrix[i,:] = wrap.x # optimized and flat matrix D
        
    return NonaffineRes,AffineMatrix