# Flux-Force plots H=1.5 and 4.0
a=2
plot './WCA/h1.5/rho001/flux_data.csv' u 1:a w l, \
     './LJ/h1.5/rho001/flux_data.csv' u 1:a w l, \
     './EPS2/h1.5/rho001/flux_data.csv' u 1:a w l, \
     './WCA/h4.0/rho001/flux_data.csv' u 1:a w l, \
     './LJ/h4.0/rho001/flux_data.csv' u 1:a w l, \
     './EPS2/h4.0/rho001/flux_data.csv' u 1:a w l

plot './WCA/h1.5/rho01/flux_data.csv' u 1:a w l, \
     './LJ/h1.5/rho01/flux_data.csv' u 1:a w l, \
     './EPS2/h1.5/rho01/flux_data.csv' u 1:a w l, \
     './WCA/h4.0/rho01/flux_data.csv' u 1:a w l, \
     './LJ/h4.0/rho01/flux_data.csv' u 1:a w l, \
     './EPS2/h4.0/rho01/flux_data.csv' u 1:a w l

plot './WCA/h1.5/rho05/flux_data.csv' u 1:a w l, \
     './LJ/h1.5/rho05/flux_data.csv' u 1:a w l, \
     './EPS2/h1.5/rho05/flux_data.csv' u 1:a w l, \
     './WCA/h4.0/rho05/flux_data.csv' u 1:a w l, \
     './LJ/h4.0/rho05/flux_data.csv' u 1:a w l, \
     './EPS2/h4.0/rho05/flux_data.csv' u 1:a w l

# Density gradient-Force plots

set xlabel "{/Times-Italic f}_{/Times-Roman ex} [{/Symbol e}/{/Symbol s}]"
set ylabel "Density gradient {/Symbol-Oblique Dr} / {/Symbol-Oblique D}{/Times-Italic x} [1/{/Symbol s^4}]"

plot './WCA/h1.5/rho001/flux_data.csv' u 1:($3-$5) w l, \
     './WCA/h1.5/rho01/flux_data.csv' u 1:($3-$5) w l, \
     './WCA/h1.5/rho05/flux_data.csv' u 1:($3-$5) w l, \
     './LJ/h1.5/rho001/flux_data.csv' u 1:($3-$5) w l, \
     './LJ/h1.5/rho01/flux_data.csv' u 1:($3-$5) w l, \
     './LJ/h1.5/rho05/flux_data.csv' u 1:($3-$5) w l, \
     './EPS2/h1.5/rho001/flux_data.csv' u 1:($3-$5) w l, \
     './EPS2/h1.5/rho01/flux_data.csv' u 1:($3-$5) w l, \
     './EPS2/h1.5/rho05/flux_data.csv' u 1:($3-$5) w l

plot './WCA/h1.5/rho001/flux_data.csv' u 1:($3-$5) w l, \
     './LJ/h1.5/rho001/flux_data.csv' u 1:($3-$5) w l, \
     './EPS2/h1.5/rho001/flux_data.csv' u 1:($3-$5) w l 

plot './WCA/h1.5/rho01/flux_data.csv' u 1:($3-$5) w l, \
     './LJ/h1.5/rho01/flux_data.csv' u 1:($3-$5) w l, \
     './EPS2/h1.5/rho01/flux_data.csv' u 1:($3-$5) w l

plot './WCA/h1.5/rho05/flux_data.csv' u 1:($3-$5) w l, \
     './LJ/h1.5/rho05/flux_data.csv' u 1:($3-$5) w l, \
     './EPS2/h1.5/rho05/flux_data.csv' u 1:($3-$5) w l


