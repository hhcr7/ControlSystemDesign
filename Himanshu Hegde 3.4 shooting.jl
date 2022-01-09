using LinearAlgebra, DifferentialEquations, PyPlot
x0=2.0

function f!(dx,x,param,t)
    u=-cbrt(0.25x[2])
    dx[1]=0.25x[1]+u
    dx[2]=0.25x[2]+8x[1]^3
end

function bc2!(residual, x, p, t) 
    global x0
    residual[1] = x[1][1] - x0
    residual[2] = x[end][2] - x[end][1]^4
end

tspan=(0.0,2.0)
dt=0.01
bvp = TwoPointBVProblem(f!, bc2!, [x0,0.0], tspan)
sol = solve(bvp, MIRK4(), dt=dt)
t=range(tspan[1],stop=tspan[end],length=length(sol[1,:]))

u=-0.25sol[2,:]
for i in eachindex(u)
    u[i]=cbrt(u[i])
end
plot(t,sol[1,:],t,sol[2,:],t,u)
legend(["x", "p","u"])
grid(true)

#plotted u separately so that we can see it better
plot(t,u)
legend(["x"])
grid(true)


