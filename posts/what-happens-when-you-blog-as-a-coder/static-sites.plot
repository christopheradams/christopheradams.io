set terminal svg font "Courier Bold,10" size 660,330
unset key
set xdata time
set timefmt "%Y-%m"
set format x "%Y"
set tics nomirror scale 1,0
set format y ""
unset ytics
unset border
set style data lines
set title 'static site generator search interest: 2008-2016'
set datafile separator ","
plot 'multiTimeline.csv' using 1:2 linewidth 3 linecolor rgb "salmon"
