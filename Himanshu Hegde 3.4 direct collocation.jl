using JuMP, Ipopt, PyPlot

Nc=99
Np=Nc+1
Nnode=Np+1

T=2.0
h=T/Np

model = Model(with_optimizer(Ipopt.Optimizer, print_level = 0))

x0=zeros(Nnode)
[x0[i]=2 for i=1:Nnode]

@variable(model, x[i=1:Nnode], start = x0[i])

u0=zeros(Nnode)
@variable(model, u[i=1:Nnode], start = u0[i])

@constraint(model, [i = 1:Nnode-1], x[1] == x0[i])

#System dynamics
@constraint(model, [i = 1:Nnode-1], x[i+1]-x[i] == 0.5*h*(0.25x[i+1]+u[i+1]+0.25x[i]+u[i]))

@NLobjective(model, Min, sum(0.5 * h * (2(x[i + 1]^4 + x[i]^4)+ u[i + 1]^4 + u[i]^4) for i in 1:Np)) 

JuMP.optimize!(model)

display(JuMP.objective_value(model))

x_opt=JuMP.value.(x);
u_opt=JuMP.value.(u);
figure()
# t=range(1,length=N,stop=2-0.01)
t=(0:Np)*T/Np
t_opt=T
subplot(311)
plot(t,x_opt[:])
subplot(312)
plot(t,u_opt)


