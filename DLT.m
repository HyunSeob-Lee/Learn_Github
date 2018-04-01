% <<< Direct Linear Transformation >>>
% FILENAME : DLT.m
% Version : 1.0
% �ۼ��� : ������      �ۼ��� : 1998�� 10�� 23��
% Description :
%   1. ī�޶� 2�뿡�� ������ 2���� ��ǥ�� �̿��Ͽ� 3���� ��ǥ�� �����س���.
%   2. DLT parameter�� ���� ���� parameter�� �̿��Ͽ� 3���� ��ǥ�� �̿��Ѵ�.
%   3. �� ���α׷������� �⺻���� DLT parameter���� ���Ѵ�. �� 11���� DLT
%       parameter���� ���Ѵ�.
%   4. Control object�� 6���� ����Ѵ�.
%   5. ��꿡 ���� ����� least square�� ����Ͽ���.
% Information :
%   reference : Object control ��, reference frame�� �ǰ��� ��ǥ ���� ���� �ִ� ������ 
%                     �����͸� �����ϴ� �����̴�.
%   r3_x          : reference�� ����Ǿ� �ִ� �ǰ��� ��ǥ �� �߿� x��ǥ ������ �����Ѵ�.
%   r3_y          : reference�� ����Ǿ� �ִ� �ǰ��� ��ǥ �� �߿� y��ǥ ������ �����Ѵ�.
%   r3_z          : reference�� ����Ǿ� �ִ� �ǰ��� ��ǥ �� �߿� z��ǥ ������ �����Ѵ�.
%   r_camera1 : reference frame�� �Կ��� ù��° ī�޶��� 2���� ��ǥ ���� �����Ѵ�.
%   rc1_x        : r_camera1�� ����Ǿ� �ִ� 2���� ��ǥ ���߿� x��ǥ ������ �����Ѵ�.
%   rc1_y        : r_camera1�� ����Ǿ� �ִ� 2���� ��ǥ ���߿� y��ǥ ������ �����Ѵ�.
%   r_camera2 : reference frame�� �Կ��� �ι�° ī�޶��� 2���� ��ǥ ���� �����Ѵ�.
%   rc2_x        : r_camera2�� ����Ǿ� �ִ� 2���� ��ǥ ���߿� x��ǥ ������ �����Ѵ�.
%   rc2_y        : r_camera2�� ����Ǿ� �ִ� 2���� ��ǥ ���߿� y��ǥ ������ �����Ѵ�.
%   camera1   : ������� �Կ��� ù��° ī�޶��� �����͸� �����Ѵ�.
%   c1_x         : camera1�� ����Ǿ� �ִ� 2���� ��ǥ ���߿� x��ǥ ������ �����Ѵ�.
%   c1_y         : camera1�� ����Ǿ� �ִ� 2���� ��ǥ ���߿� y��ǥ ������ �����Ѵ�.
%   camera2   : ������� �Կ��� �ι�° ī�޶��� �����͸� �����Ѵ�.
%   c2_x         : camera2�� ����Ǿ� �ִ� 2���� ��ǥ ���߿� x��ǥ ������ �����Ѵ�.
%   c2_y         : camera2�� ����Ǿ� �ִ� 2���� ��ǥ ���߿� y��ǥ ������ �����Ѵ�.
%   cam1_left  : ù��° ī�޶��� DLT parameter�� ���ϱ� ���� ��� �߿��� ���� ����� �����Ѵ�.
%   cam2_left  : �ι�° ī�޶��� DLT parameter�� ���ϱ� ���� ��� �߿��� ���� ����� �����Ѵ�.
%   cam1_right : ù��° ī�޶��� DLT parameter�� ���ϱ� ���� ��� �߿��� ������ ����� �����Ѵ�.
%                       ��, reference frame�� 2���� ��ǥ ���� �����Ѵ�.
%   cam2_right : �ι�° ī�޶��� DLT parameter�� ���ϱ� ���� ��� �߿��� ������ ����� �����Ѵ�.
%                       ��, reference frame�� 2���� ��ǥ ���� �����Ѵ�.
%   cam1_para : ù��° ī�޶��� DLT parameter�� �����Ѵ�.
%   cam2_para : �ι�° ī�޶��� DLT parameter�� �����Ѵ�.
%   dlt_left        : 2���� 2���� ��ǥ�� ������ 3���� ��ǥ�� ���ϱ� ���� ����߿��� ���� ����� �����Ѵ�.
%   dlt_right     : 2���� 2���� ��ǥ�� ������ 3���� ��ǥ�� ���ϱ� ���� ����߿��� ������ ����� �����Ѵ�.
%   xyz_coordi : DLT ������ �̿��Ͽ� ����� 3���� ��ǥ ���� �����Ѵ�.





disp('<< �ۼ��� : ������   �ۼ��� : 1998�� 10�� 23��  Version : 1.0        >>');
disp('<< Description :                                                                          >>'); 
disp('<<        2���� ī�޶󿡼� ������ 2���� ��ǥ�� �̿��Ͽ� 3���� ��ǥ�� �����Ѵ�. >>');
disp('<< �� ���α׷������� 6���� object control point�� ����Ѵ�. >>');
disp('----> Enter the Any Key! <----');
pause;

[FILENAME, PATHNAME]=uigetfile('*.dat','Reference frame�� 3���� ��ǥ ������ ���ϸ� �Է��Ͻÿ�!');
 if FILENAME == 0
    return;
 end
 fid=fopen(FILENAME,'r+'); %������ �����Ѵ�.
 %���Ϸ� ���� �����͸� �о���δ�. 2�� ���ѿ��� �о�鿩 a�� �����Ѵ�.
 reference=fscanf(fid,'%g',[3,inf]);
 fclose(fid);
 r3_x=reference(1,:)';
 r3_y=reference(2,:)';
 r3_z=reference(3,:)';
 
% ù��° ī�޶󿡼� �Կ��� reference frame�� 2���� ��ǥ���� �Է��Ѵ�.
[FILENAME, PATHNAME]=uigetfile('*.dat','ù��° ī�޶��� reference frame�� ���� ������ ������ �����Ͻÿ�');
 if FILENAME == 0
    return;
 end
 fid=fopen(FILENAME,'r+'); %������ �����Ѵ�.
 %���Ϸ� ���� �����͸� �о���δ�. 2�� ���ѿ��� �о�鿩 a�� �����Ѵ�.
 r_camera1=fscanf(fid,'%g',[2,inf]);
 fclose(fid);
 rc1_x=r_camera1(1,:)';
 rc1_y=r_camera1(2,:)';
 
% �ι�° ī�޶󿡼� �Կ��� reference frame�� 2���� ��ǥ���� �Է��Ѵ�.
[FILENAME, PATHNAME]=uigetfile('*.dat','��ù��° ī�޶��� reference frame ���� ������ ������ �����Ͻÿ�');
 if FILENAME == 0
    return;
 end
 fid=fopen(FILENAME,'r+'); %������ �����Ѵ�.
 %���Ϸ� ���� �����͸� �о���δ�. 2�� ���ѿ��� �о�鿩 a�� �����Ѵ�.
 r_camera2=fscanf(fid,'%g',[2,inf]);
 fclose(fid);
 rc2_x=r_camera2(1,:)';
 rc2_y=r_camera2(2,:)';

% 2���� ī�޶󿡼� �Կ��� ������ ���ϵ��� �Է��Ѵ�.
[FILENAME, PATHNAME]=uigetfile('*.dat','ù��° ī�޶� ���� ������ ������ �����Ͻÿ�');
 if FILENAME == 0
    return;
 end
fid=fopen(FILENAME,'r+'); %������ �����Ѵ�.
%���Ϸ� ���� �����͸� �о���δ�. 2�� ���ѿ��� �о�鿩 a�� �����Ѵ�.
camera1=fscanf(fid,'%g',[2,inf]);
fclose(fid);
c1_x=camera1(1,:)';
c1_y=camera1(2,:)';
c1_length=length(c1_x);


[FILENAME, PATHNAME]=uigetfile('*.dat','�ι�° ī�޶� ���� ������ ������ �����Ͻÿ�');
if FILENAME == 0
   return;
end
fid=fopen(FILENAME,'r+'); %������ �����Ѵ�.
%���Ϸ� ���� �����͸� �о���δ�. 2�� ���ѿ��� �о�鿩 a�� �����Ѵ�.
camera2=fscanf(fid,'%g',[2,inf]);
fclose(fid);
c2_x=camera2(1,:)';
c2_y=camera2(2,:)';
c2_length=length(c2_x);
 
% ù��° ī�޶� ���� ���� �࿭
 cam1_left=[r3_x(1)  r3_y(1)  r3_z(1)    1        0                0               0                0    -rc1_x(1)*r3_x(1)    -rc1_x(1)*r3_y(1)    -rc1_x(1)*r3_z(1);...
                   0           0           0             0        r3_x(1)       r3_y(1)      r3_z(1)       1    -rc1_y(1)*r3_x(1)    -rc1_y(1)*r3_y(1)    -rc1_y(1)*r3_z(1);...
                   r3_x(2)  r3_y(2)  r3_z(2)    1        0                0               0                0    -rc1_x(2)*r3_x(2)    -rc1_x(2)*r3_y(2)    -rc1_x(2)*r3_z(2);...
                   0           0           0             0        r3_x(2)       r3_y(2)      r3_z(2)       1    -rc1_y(2)*r3_x(2)    -rc1_y(2)*r3_y(2)    -rc1_y(2)*r3_z(2);...
                   r3_x(3)  r3_y(3)  r3_z(3)    1        0                0               0                0    -rc1_x(3)*r3_x(3)    -rc1_x(3)*r3_y(3)    -rc1_x(3)*r3_z(3);...
                   0           0           0             0        r3_x(3)       r3_y(3)      r3_z(3)       1    -rc1_y(3)*r3_x(3)    -rc1_y(3)*r3_y(3)    -rc1_y(3)*r3_z(3);...
                   r3_x(4)  r3_y(4)  r3_z(4)    1        0                0               0                0    -rc1_x(4)*r3_x(4)    -rc1_x(4)*r3_y(4)    -rc1_x(4)*r3_z(4);...
                   0           0           0             0        r3_x(4)       r3_y(4)      r3_z(4)       1    -rc1_y(4)*r3_x(4)    -rc1_y(4)*r3_y(4)    -rc1_y(4)*r3_z(4);...
                   r3_x(5)  r3_y(5)  r3_z(5)    1        0                0               0                0    -rc1_x(5)*r3_x(5)    -rc1_x(5)*r3_y(5)    -rc1_x(5)*r3_z(5);...
                   0           0           0             0        r3_x(5)       r3_y(5)      r3_z(5)       1    -rc1_y(5)*r3_x(5)    -rc1_y(5)*r3_y(5)    -rc1_y(5)*r3_z(5);...
                   r3_x(6)  r3_y(6)  r3_z(6)    1        0                0               0                0    -rc1_x(6)*r3_x(6)    -rc1_x(6)*r3_y(6)    -rc1_x(6)*r3_z(6);...
                   0           0           0             0        r3_x(6)       r3_y(6)      r3_z(6)       1    -rc1_y(6)*r3_x(6)    -rc1_y(6)*r3_y(6)    -rc1_y(6)*r3_z(6)];
             
 % �ι�° ī�޶� ���� ���� �࿭          
 cam2_left=[r3_x(1)  r3_y(1)  r3_z(1)    1        0                0               0                0    -rc2_x(1)*r3_x(1)    -rc2_x(1)*r3_y(1)    -rc2_x(1)*r3_z(1);...
                   0           0           0             0        r3_x(1)       r3_y(1)      r3_z(1)       1    -rc2_y(1)*r3_x(1)    -rc2_y(1)*r3_y(1)    -rc2_y(1)*r3_z(1);...
                   r3_x(2)  r3_y(2)  r3_z(2)    1        0                0               0                0    -rc2_x(2)*r3_x(2)    -rc2_x(2)*r3_y(2)    -rc2_x(2)*r3_z(2);...
                   0           0           0             0        r3_x(2)       r3_y(2)      r3_z(2)       1    -rc2_y(2)*r3_x(2)    -rc2_y(2)*r3_y(2)    -rc2_y(2)*r3_z(2);...
                   r3_x(3)  r3_y(3)  r3_z(3)    1        0                0               0                0    -rc2_x(3)*r3_x(3)    -rc2_x(3)*r3_y(3)    -rc2_x(3)*r3_z(3);...
                   0           0           0             0        r3_x(3)       r3_y(3)      r3_z(3)       1    -rc2_y(3)*r3_x(3)    -rc2_y(3)*r3_y(3)    -rc2_y(3)*r3_z(3);...
                   r3_x(4)  r3_y(4)  r3_z(4)    1        0                0               0                0    -rc2_x(4)*r3_x(4)    -rc2_x(4)*r3_y(4)    -rc2_x(4)*r3_z(4);...
                   0           0           0             0        r3_x(4)       r3_y(4)      r3_z(4)       1    -rc2_y(4)*r3_x(4)    -rc2_y(4)*r3_y(4)    -rc2_y(4)*r3_z(4);...
                   r3_x(5)  r3_y(5)  r3_z(5)    1        0                0               0                0    -rc2_x(5)*r3_x(5)    -rc2_x(5)*r3_y(5)    -rc2_x(5)*r3_z(5);...
                   0           0           0             0        r3_x(5)       r3_y(5)      r3_z(5)       1    -rc2_y(5)*r3_x(5)    -rc2_y(5)*r3_y(5)    -rc2_y(5)*r3_z(5);...
                   r3_x(6)  r3_y(6)  r3_z(6)    1        0                0               0                0    -rc2_x(6)*r3_x(6)    -rc2_x(6)*r3_y(6)    -rc2_x(6)*r3_z(6);...
                   0           0           0             0        r3_x(6)       r3_y(6)      r3_z(6)       1    -rc2_y(6)*r3_x(6)    -rc2_y(6)*r3_y(6)    -rc2_y(6)*r3_z(6)];

% ù��° ī�޶� ���� ���� ���          
cam1_right=[rc1_x(1);  rc1_y(1);  rc1_x(2);  rc1_y(2);  rc1_x(3);  rc1_y(3);  rc1_x(4);  rc1_y(4);  rc1_x(5);  rc1_y(5);  rc1_x(6);  rc1_y(6)];         
% �ι�° ī�޶� ���� ���� ���         
cam2_right=[rc2_x(1);  rc2_y(1);  rc2_x(2);  rc2_y(2);  rc2_x(3);  rc2_y(3);  rc2_x(4);  rc2_y(4);  rc2_x(5);  rc2_y(5);  rc2_x(6);  rc2_y(6)];   
         
cam1_para=cam1_left\cam1_right;  %ù��° ī�޶� ���� DLT parameter.
cam2_para=cam2_left\cam2_right;  %�ι�° ī�޶� ���� DLT parameter.

if c1_length ~= c2_length
   error('������ ���̰� ���� ����!!!!');
   return;
end

xyz_coordi=[ 0 0 0]; % ��� index�� �����ϱ� ���� �ӽ� ������.
for i=1:c1_length
% 3���� ��ǥ�� ���ϱ� ���� ������ ���� ���   
dlt_left=[cam1_para(1)-(c1_x(i)*cam1_para(9))   cam1_para(2)-(c1_x(i)*cam1_para(10))   cam1_para(3)-(c1_x(i)*cam1_para(11));...
             cam1_para(5)-(c1_y(i)*cam1_para(9))   cam1_para(6)-(c1_y(i)*cam1_para(10))   cam1_para(7)-(c1_y(i)*cam1_para(11));...
             cam2_para(1)-(c2_x(i)*cam2_para(9))   cam2_para(2)-(c2_x(i)*cam2_para(10))   cam2_para(3)-(c2_x(i)*cam2_para(11));...
             cam2_para(5)-(c2_y(i)*cam2_para(9))   cam2_para(6)-(c2_y(i)*cam2_para(10))   cam2_para(7)-(c2_y(i)*cam2_para(11))];
% 3���� ��ǥ�� ���ϱ� ���� ������ ���� ���       
dlt_right=[c1_x(i)-cam1_para(4);   c1_y(i)-cam1_para(8);   c2_x(i)-cam2_para(4);   c2_y(i)-cam2_para(8)];
       
temp_xyz_coordi=dlt_left\dlt_right;
temp_xyz_coordi=temp_xyz_coordi';
xyz_coordi=[xyz_coordi; temp_xyz_coordi];
end

xyz_coordi(1,:)=[]; %������ �ӽ÷� ������ �����͸� ���� �������� �����Ѵ�.

% �����͸� �����ϴ� ��ƾ.
saveyn=input('3���� ��ǥ Data�� ����?   1 : ��,   2 : �ƴϿ� ----> :');
switch saveyn
      case 1
         [FILENAME, PATHNAME]=uiputfile('*.dat','Save File');
          if FILENAME ~= 0
             fid=fopen(FILENAME,'w');
             xyz_coordi=xyz_coordi'; %�����͸� �����ͷ� ��ȯ�Ѵ�.
             fprintf(fid, '%8.4f  %8.4f  %8.4f \n', xyz_coordi);
             fclose(fid);
          else
             error('Error : ȭ�� ó���� ������ �߻���');       
          end
          %return;
      case 2
          %return;
      otherwise
          error('Error : ��ȣ�� �߸� �����Ͽ���');
end  

       
         
         