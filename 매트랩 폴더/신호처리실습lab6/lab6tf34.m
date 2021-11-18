clc;
clear;
z1 = -5;
p1 = [0.5*cos(pi/4)+0.5i*sin(pi/4),0.5*cos(pi/4)-0.5i*sin(pi/4)];
z2 = -5;
p2 = [cos(pi/4)+1i*sin(pi/4),cos(pi/4)-1i*sin(pi/4)];
z3 = -5;
p3 = [1.5*cos(pi/4)+1.5i*sin(pi/4),1.5*cos(pi/4)-1.5i*sin(pi/4)]; %zero, pole 3���� ����.
axis = linspace(0,20,21);

[tfz1, tfp1] = zp2tf(z1,p1,1); %�����Լ� ���·� �����. ��� �̵� �����Ƿ� ����° ���� 1.
[tfz2, tfp2] = zp2tf(z2,p2,1);
[tfz3, tfp3] = zp2tf(z3,p3,1);

[zero1, pole1, k1] = residue(tfz1,[tfp1,0]);
[zero2, pole2, k2] = residue(tfz2,[tfp2,0]);
[zero3, pole3, k3] = residue(tfz3,[tfp3,0]); %�κкм� �� ���ϱ�. ���ڴ� zero, �и�� pole�� �ش�.

z1 = customINVZ(zero1,pole1,axis);
z2 = customINVZ(zero2,pole2,axis);
z3 = customINVZ(zero3,pole3,axis); %�̻��ȣ�̹Ƿ� inv-z ��ȯ�ϱ�.

figure(1)
subplot(311)
stem(axis,z1)
xlabel('n')
ylabel('h[n] of System#1') %����

subplot(312)
stem(axis,z2)
xlabel('n')
ylabel('h[n] of System#2') %����


subplot(313)
stem(axis,z3)
xlabel('n')
ylabel('h[n] of System#3') %�߻�
