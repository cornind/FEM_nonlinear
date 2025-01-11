syms x y U1 U2 U3 cor1_1 cor1_2 cor2_1 cor2_2 cor3_1 cor3_2;
cor1 = [cor1_1 cor1_2];
cor2 = [cor2_1 cor2_2];
cor3 = [cor3_1 cor3_2];
cor = [cor1;cor2;cor3];
Area = det([ones(1,3);cor'])/2;



f_1 = 1-x-y;
f_2 = x;
f_3 = y;

u = U1*f_1+U2*f_2+U3*f_3;

d=3;
% ud = u^d*[f_1;f_2;f_3];
ud = u^d;
ud=expand(ud);
ud = collect(ud,[x y]);
ud =int(ud,y,[0,1-x]);
ud =int(ud,x,[0,1]);
ud = char(ud);
ud = strrep(ud,'U1','U(1)');
ud = strrep(ud,'U2','U(2)');
ud = strrep(ud,'U3','U(3)');

udp = d*u^{d-1}*[f_1 f_2 f_3];
udp=expand(udp);
udp = collect(udp,[x y]);
udp =int(udp,y,[0,1-x]);
udp =int(udp,x,[0,1]);
udp = char(udp);
udp = strrep(udp,'U1','U(1)');
udp = strrep(udp,'U2','U(2)');
udp = strrep(udp,'U3','U(3)');


