function y = signal_circle(u)
%#codegen

t= u;
T = 10;
x1 = 3;
y1 = 3;
z0 = 3;
r1 = sqrt(8);

r2 = (sqrt(162)-sqrt(18)-sqrt(8))*0.5;
x2 = sqrt((sqrt(18)+sqrt(8)+r2)^2*0.5);
y2 = x2;

omega = pi/T;
if t<T || t ==T
    xd = x1+r1*cos(-2.35+omega*t);
    yd = y1+r1*sin(-2.35+omega*t);
    zd = z0-z0/T/2*t;
    dxd = -r1*omega*sin(-2.35+omega*t);
    dyd = r1*omega*cos(-2.35+omega*t);
    dzd = -z0/T/2;
    dpsid = 0;
    ddxd = -r1*omega^2*cos(-2.35+omega*t);
    ddyd = -r1*omega^2*sin(-2.35+omega*t);
elseif t<2*T
    xd = x2+r2*cos(-2.35-omega*(t-T));
    yd = y2+r2*sin(-2.35-omega*(t-T));
    zd = z0-z0/T/2*t;
    dxd = r2*omega*sin(-2.35-omega*(t-T));
    dyd = -r2*omega*cos(-2.35-omega*(t-T));
    dzd = -z0/T/2;
    dpsid = 0;
    ddxd = -omega^2*r2*cos(-2.35-omega*(t-T));
    ddyd = -omega^2*r2*sin(-2.35-omega*(t-T));
else
    xd = 9;
    yd = 9;
    zd = 0;
    dxd = 0;
    dyd = 0;
    dzd = 0;
    dpsid = 0;
    ddxd = 0;
    ddyd = 0;
end
psid = 0;

y = [xd yd zd psid dxd dyd dzd dpsid ddxd ddyd]';


