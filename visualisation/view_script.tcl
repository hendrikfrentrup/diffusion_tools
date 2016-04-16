mol new {/Users/hf210/molsim/md-nemd/adsor/EPS2/h1.5/rho001/f1/traj.xyz} type {xyz} first 0 last 620 step 1 waitfor 1
mol modstyle 0 top VDW 0.3 24.0
rotate x by 90
display projection Orthographic
axes location Off

mol modselect 0 top name W1
mol modmaterial 0 top BrushedMetal
mol modcolor 0 top ColorID 6
mol smoothrep top 0 1

mol addrep top
mol modcolor 1 top ColorID 3
mol modstyle 1 top VDW 0.3 24.0
mol modselect 1 top name N1 and x>-8 and x<8 and z>1
mol modmaterial 1 top Opaque
mol smoothrep top 1 1

mol addrep top
mol modstyle 2 top VDW 0.3 24.0
mol modselect 2 top name N1
mol modmaterial 2 top Ghost
mol smoothrep top 2 1
