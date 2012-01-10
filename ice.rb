#!/usr/bin/ruby
include Math

# Everything in units of 1k years
t_start = -3000.0
t = t_start
t_end = 0.0
v_initial = 0.0e7
v = v_initial

a = 0.0001
b = 30.0
c = 0.02
d = 0.0
alpha = 6.0e7
beta = 1.0e2
t0 = -1200

f = File.open("ice.csv", "w")
obl_csv = File.open("obl.csv")

while t < t_end
	f.puts "#{t} #{v}"
	t +=1

	# CO2 'd' takes effect after 1.2Myr
	if d == 0.0 and t >= t0
		d = 9.0e-18
	end

	# normalized obliquity
	theta_norm = obl_csv.readline.to_f

	# limiting threshold
	l = alpha - beta*theta_norm

	if(v > l) # oblate to 1/3 of alpha over 10 Kyr
		t0 = t

		v = v/3.0#alpha/3.0
		9.times { obl_csv.readline }
		t += 9
	else
		v += a + b*(t - t_start) + c*(v - v_initial)*theta_norm + d*v*v*v
	end
end

f.close
