a1 = 0.75; %0.608 - 1.200
a2 = 0.5;
a3 = 0.2;
threelink = SerialLink([0 0 a1 0; 0 0 a2 0; 0 0 a3 0], 'name', 'n');

step = 1/100;
gamma = [0:step:1];

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

p = [x' y' zeros(1,101)'];

plot1 = plot2(p);

threelink.plot([double(theta1') double(theta2') double(theta3')]);
