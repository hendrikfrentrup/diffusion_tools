for sys in EPS2 LJ WCA; do
 for pore in h1.5 h4.0; do
  for rho in rho001 rho01 rho05; do
   cd /home/frentrup/molsim/md-nemd/adsor/$sys/$pore/$rho/
   rm flux_data.csv
   for dir in f005 f02 f05 f1 f2 f4 f6 f8 fx fx2 fx6 fxx; do
    grep "Magnitude of xi" $dir/field.inp| awk '{print $1}'i >> flux_data.csv
   done
   
   for dir in f005 f02 f05 f1 f2 f4 f6 f8 fx fx2 fx6 fxx; do
    grep "Total Flux" $dir/output.dat | awk '{print $6}' >> flux_data.csv
   done

   tail -n 39 gradFit.csv | awk '{print $1,  $3}' >> flux_data.csv
  done
 done
done
