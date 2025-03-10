a1 = 0.75; %0.608 - 1.200
a2 = 0.5;
a3 = 0.2;
threelink = SerialLink([0 0 a1 0; 0 0 a2 0; 0 0 a3 0], 'name', 'n');

step = 1/100;
%time = [0:1:100]; % 100 time steps

tf = 20;
tspan = [0 tf];
%opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
solinit = bvpinit(linspace(0,1,100),[0]);
[t,gamma] = ode45(@my_ode, tspan, 0)
%sol = bvp4c(@my_ode, @bvp4bc,solinit);
%time = linspace(0,1);
%gamma = deval(sol,time);

a = 0.9 + 0.4*sin(8*sym(pi)*gamma).^2;

x = a .* cos(2*sym(pi)*gamma);
y = a .* sin(2*sym(pi)*gamma);

b = 0.4*2*8*sym(pi)*sin(8*sym(pi)*gamma).*cos(8*sym(pi)*gamma);

dy = (2*sym(pi)*cos(2*sym(pi)*gamma).*a + sin(2*sym(pi)*gamma).*b);
dx = (-2*sym(pi)*sin(2*sym(pi)*gamma).*a + cos(2*sym(pi)*gamma).*b);

phi = atan2(dy, dx) - sym(pi)/2;% 2*sym(pi)*gamma

costheta2 = (x.^2 + y.^2 + a3^2 - 2*a3*(x.*cos(phi) + y.*sin(phi)) - a1^2 - a2^2)/(2*a1*a2);
theta2 = acos(costheta2);       %-acos(costheta2);

theta1 = atan2(y - a3*sin(phi),x - a3*cos(phi)) - atan2(a2*sin(theta2),a1 + a2*cos(theta2));

theta3 = phi - theta1 - theta2;

p = [x y zeros(1,length(gamma))'];

plot1 = plot2(p);

threelink.plot([double(theta1') double(theta2') double(theta3')]);



function dydt = my_ode(t,y)
    dydt = 1/(sqrt((0.9+0.2*sin(8*pi*y)^2)^2 + 0.4*64*sin(8*pi*y)^2*cos(8*pi*y)^2)*2*pi); % Evaluate ODE at time t
end

function res = bvp4bc(ya, yb)
    res = [ya];
end
