step = 1/100;
gamma = [0:step:1];

a = 0.9 + 0.4*sin(8*pi*gamma).^2;

x = a .* cos(2*pi*gamma);
y = a .* sin(2*pi*gamma);

b = 0.4*2*8*pi*sin(8*pi*gamma).*cos(8*pi*gamma);

dy = (2*pi*cos(2*pi*gamma).*a + sin(2*pi*gamma).*b);
dx = (-2*pi*sin(2*pi*gamma).*a + cos(2*pi*gamma).*b);

theta = atan2(dy, dx) - pi/2;
 
T = zeros(4, 4, length(x));
for i = 1:length(x)
    T(:,:,i) = transl(x(i), y(i), 0);
end

R = zeros(4, 4, length(theta));
for i = 1:length(theta)
    R(:,:,i) = rotm2tform(rotz(theta(i)));
end

Pose = zeros(4, 4, length(T));
for i = 1:length(T)
    Pose(:,:,i) = T(:,:,i) * R(:,:,i);
end

tranimate(Pose, 'length', 0.1, 'retain', 'rgb', 'notext');
