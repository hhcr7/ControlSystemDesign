using ControlSystems, LinearAlgebra
#creating transfer function
num=[1,0]
den=[1,3,2,0]
tf(num,den,0)

#creating state space out of transfer function 
ReqdSys=ss(tf(num,den,0))

#getting desired poles
P1=pole(ReqdSys)

#Compensated system is ReqdSys
#Controllability of compensated system
Mc=ctrb(ReqdSys)
r1=rank(Mc)
display(Mc)
display(r1)

#Observability of compensated system
Mo=obsv(ReqdSys)
r2=rank(Mo)
display(Mo)
display(r2)

#system is controllable but not observable

#finding out the unobservable subspace
unobservable=nullspace(Mo)


