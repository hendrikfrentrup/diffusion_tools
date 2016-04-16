FC=gfortran
EXE=mk2d_esurf
#~/bin/mk2d_esurf

OBJ_SRC=mk2d_esurf.o \

OBJ_MOD=random.o

$(EXE): $(OBJ_SRC) $(OBJ_MOD)
	$(FC) -o $@ $(OBJ_SRC) $(OBJ_MOD)

%.o: %.f90
	$(FC) -c -g $<

$(OBJ_SRC):$(OBJ_MOD)

clean:
	rm *.o *.mod  $(EXE)


	

