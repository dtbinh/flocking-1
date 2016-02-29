clear variables
%GLOBAL VARIABLES:
globalvariables

%PARAMETERS:
%number of agents
N=5;
%dimension
d=2;
%final time
T=20;
%mesh length
n=403;
%mesh size
h=T/(n-1);
%mesh
t=0:h:T;
%adjoint mesh length
nn = floor(n/2)+1;
%adjoint mesh size
hh=2*h;
%adjoint mesh
tt=t(1:2:n);
%solution
%solx=zeros(n, N+1, d);
%solv=zeros(n, N+1, d);
%control with zero initial value
u = zeros(d, n);
%initialize the control on the leader
for k=1:n
    u(:, k) = uleader0(t(k), d);
end

%INITIAL CONDITION FOR THE FORWARD EQUATION
%initial position
x0 = zeros(N+1, d);
for i = 1:N+1
    %x0(i,2)=0;
    x0(i,1)=20*N*i/(N+1);
end
%initial velocity
v0 =  ones(N+1, d);


%[solx, u] = SteepestDescent(u, eps, x0, v0, N, d, n, h, T);

%SOLVE  FORWARD EQUATION
%solving the equation
[solx, solv] = ForwardEquation(x0, v0, u, N, d, n,  h);




%SOLVE ADJOINT EQUATION
%initial condition for the adjoint equation
%pn = [-(solx(:, :, n) - xxdes(T, N, d));  -(solv(:, :, n) - xvdes(T, N, d))];% this is wrong!!!
%(only the first element is nonzero)
pn = zeros(2*(N+1), d);
pn(1,:) = -(solx(1, :, n) - xxdes(T, d));
%test
%test
%solving the equation
solp = AdjointEquation(pn, solx, solv, N, d, n,  h);




%PLOT TRAJECTORIES
%plot leader's trajectory
%plot(solx(:,2,1), solx(:,2,2));
%plot leader's and other's tajectory
for i=1:N+1
    plot(reshape(solx(i,1,:), n, 1), reshape(solx(i,2,:), n, 1));
    %plot(solx(i,1,:), solx(i,2,:));
    hold all
end


%PLOT SOLUTION OF THE ADJOINT EQUATION
%plot the first dimension of p against time
figure
for i=1:2*(N+1)
    plot(t, reshape(solp(i,1,:), n, 1));
    %plot(tt, reshape(solp(i,1,:), nn, 1));
    %plot(solx(i,1,:), solx(i,2,:));
    hold all
end
%plot the second dimension of p against time
figure
for i=1:2*(N+1)
    plot(t, reshape(solp(i,2,:), n, 1));
    %plot(tt, reshape(solp(i,2,:), nn, 1));
    %plot(solx(i,1,:), solx(i,2,:));
    hold all
end