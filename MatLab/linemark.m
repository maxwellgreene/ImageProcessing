function linemark(sp, ep)  
   v1 = (sp - ep) / (norm(sp-ep) / 20);
   t1 = 22.5 * pi / 180;
   t2 = -1 * 22.5 * pi / 180;
   r1 = [cos(t1)  -sin(t1) ; sin(t1)  cos(t1)];
   r2 = [cos(t2)  -sin(t2) ; sin(t2)  cos(t2)];   
   v2 = v1 * r1;
   v3 = v1 * r2;
   p1 = ep;
   p2 = p1 + v2;
   p3 = p1 + v3;
   fill([p1(1) p2(1) p3(1)], [p1(2) p2(2) p3(2)], 'r', 'edgealpha', 0);  
   plot([sp(1) ep(1)], [sp(2) ep(2)], 'linewidth', 2 ,'color' ,'r');
end