% <<< Direct Linear Transformation >>>
% FILENAME : DLT.m
% Version : 1.0
% 작성자 : 이현섭      작성일 : 1998년 10월 23일
% Description :
%   1. 카메라 2대에서 추출한 2차원 좌표를 이용하여 3차원 좌표를 생성해낸다.
%   2. DLT parameter를 구한 다음 parameter를 이용하여 3차원 좌표를 이용한다.
%   3. 본 프로그램에서는 기본적인 DLT parameter만을 구한다. 즉 11개의 DLT
%       parameter만을 구한다.
%   4. Control object는 6개를 사용한다.
%   5. 계산에 사용된 방식은 least square를 사용하였다.
% Information :
%   reference : Object control 즉, reference frame의 실공간 좌표 값을 갖고 있는 파일의 
%                     데이터를 저장하는 변수이다.
%   r3_x          : reference에 저장되어 있는 실공간 좌표 값 중에 x좌표 값만을 저장한다.
%   r3_y          : reference에 저장되어 있는 실공간 좌표 값 중에 y좌표 값만을 저장한다.
%   r3_z          : reference에 저장되어 있는 실공간 좌표 값 중에 z좌표 값만을 저장한다.
%   r_camera1 : reference frame을 촬영한 첫번째 카메라의 2차원 좌표 값을 저장한다.
%   rc1_x        : r_camera1에 저장되어 있는 2차원 좌표 값중에 x좌표 값만을 저장한다.
%   rc1_y        : r_camera1에 저장되어 있는 2차원 좌표 값중에 y좌표 값만을 저장한다.
%   r_camera2 : reference frame을 촬영한 두번째 카메라의 2차원 좌표 값을 저장한다.
%   rc2_x        : r_camera2에 저장되어 있는 2차원 좌표 값중에 x좌표 값만을 저장한다.
%   rc2_y        : r_camera2에 저장되어 있는 2차원 좌표 값중에 y좌표 값만을 저장한다.
%   camera1   : 운동동작을 촬영한 첫번째 카메라의 데이터를 저장한다.
%   c1_x         : camera1에 저장되어 있는 2차원 좌표 값중에 x좌표 값만을 저장한다.
%   c1_y         : camera1에 저장되어 있는 2차원 좌표 값중에 y좌표 값만을 저장한다.
%   camera2   : 운동동작을 촬영한 두번째 카메라의 데이터를 저장한다.
%   c2_x         : camera2에 저장되어 있는 2차원 좌표 값중에 x좌표 값만을 저장한다.
%   c2_y         : camera2에 저장되어 있는 2차원 좌표 값중에 y좌표 값만을 저장한다.
%   cam1_left  : 첫번째 카메라의 DLT parameter를 구하기 위한 행렬 중에서 왼쪽 행렬을 저장한다.
%   cam2_left  : 두번째 카메라의 DLT parameter를 구하기 위한 행렬 중에서 왼쪽 행렬을 저장한다.
%   cam1_right : 첫번째 카메라의 DLT parameter를 구하기 위한 행렬 중에서 오른쪽 행렬을 저장한다.
%                       즉, reference frame의 2차원 좌표 값을 저장한다.
%   cam2_right : 두번째 카메라의 DLT parameter를 구하기 위한 행렬 중에서 오른쪽 행렬을 저장한다.
%                       즉, reference frame의 2차원 좌표 값을 저장한다.
%   cam1_para : 첫번째 카메라의 DLT parameter를 저장한다.
%   cam2_para : 두번째 카메라의 DLT parameter를 저장한다.
%   dlt_left        : 2개의 2차원 좌표를 가지고 3차원 좌표를 구하기 위한 행렬중에서 왼쪽 행렬을 저장한다.
%   dlt_right     : 2개의 2차원 좌표를 가지고 3차원 좌표를 구하기 위한 행렬중에서 오른쪽 행렬을 저장한다.
%   xyz_coordi : DLT 공식을 이용하여 얻어진 3차원 좌표 값을 저장한다.





disp('<< 작성자 : 이현섭   작성일 : 1998년 10월 23일  Version : 1.0        >>');
disp('<< Description :                                                                          >>'); 
disp('<<        2대의 카메라에서 추출한 2차원 좌표를 이용하여 3차원 좌표를 구성한다. >>');
disp('<< 본 프로그램에서는 6개의 object control point를 사용한다. >>');
disp('----> Enter the Any Key! <----');
pause;

[FILENAME, PATHNAME]=uigetfile('*.dat','Reference frame의 3차원 좌표 데이터 파일를 입력하시요!');
 if FILENAME == 0
    return;
 end
 fid=fopen(FILENAME,'r+'); %파일을 오픈한다.
 %파일로 부터 데이터를 읽어들인다. 2행 무한열로 읽어들여 a에 저장한다.
 reference=fscanf(fid,'%g',[3,inf]);
 fclose(fid);
 r3_x=reference(1,:)';
 r3_y=reference(2,:)';
 r3_z=reference(3,:)';
 
% 첫번째 카메라에서 촬영된 reference frame의 2차원 좌표값을 입력한다.
[FILENAME, PATHNAME]=uigetfile('*.dat','첫번째 카메라의 reference frame에 대한 데이터 파일을 선택하시요');
 if FILENAME == 0
    return;
 end
 fid=fopen(FILENAME,'r+'); %파일을 오픈한다.
 %파일로 부터 데이터를 읽어들인다. 2행 무한열로 읽어들여 a에 저장한다.
 r_camera1=fscanf(fid,'%g',[2,inf]);
 fclose(fid);
 rc1_x=r_camera1(1,:)';
 rc1_y=r_camera1(2,:)';
 
% 두번째 카메라에서 촬영된 reference frame의 2차원 좌표값을 입력한다.
[FILENAME, PATHNAME]=uigetfile('*.dat','두첫번째 카메라의 reference frame 대한 데이터 파일을 선택하시요');
 if FILENAME == 0
    return;
 end
 fid=fopen(FILENAME,'r+'); %파일을 오픈한다.
 %파일로 부터 데이터를 읽어들인다. 2행 무한열로 읽어들여 a에 저장한다.
 r_camera2=fscanf(fid,'%g',[2,inf]);
 fclose(fid);
 rc2_x=r_camera2(1,:)';
 rc2_y=r_camera2(2,:)';

% 2대의 카메라에서 촬영된 데이터 파일들을 입력한다.
[FILENAME, PATHNAME]=uigetfile('*.dat','첫번째 카메라에 대한 데이터 파일을 선택하시요');
 if FILENAME == 0
    return;
 end
fid=fopen(FILENAME,'r+'); %파일을 오픈한다.
%파일로 부터 데이터를 읽어들인다. 2행 무한열로 읽어들여 a에 저장한다.
camera1=fscanf(fid,'%g',[2,inf]);
fclose(fid);
c1_x=camera1(1,:)';
c1_y=camera1(2,:)';
c1_length=length(c1_x);


[FILENAME, PATHNAME]=uigetfile('*.dat','두번째 카메라에 대한 데이터 파일을 선택하시요');
if FILENAME == 0
   return;
end
fid=fopen(FILENAME,'r+'); %파일을 오픈한다.
%파일로 부터 데이터를 읽어들인다. 2행 무한열로 읽어들여 a에 저장한다.
camera2=fscanf(fid,'%g',[2,inf]);
fclose(fid);
c2_x=camera2(1,:)';
c2_y=camera2(2,:)';
c2_length=length(c2_x);
 
% 첫번째 카메라에 대한 좌측 행열
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
             
 % 두번째 카메라에 대한 좌측 행열          
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

% 첫번째 카메라에 대한 우측 행렬          
cam1_right=[rc1_x(1);  rc1_y(1);  rc1_x(2);  rc1_y(2);  rc1_x(3);  rc1_y(3);  rc1_x(4);  rc1_y(4);  rc1_x(5);  rc1_y(5);  rc1_x(6);  rc1_y(6)];         
% 두번째 카메라에 대한 우측 행렬         
cam2_right=[rc2_x(1);  rc2_y(1);  rc2_x(2);  rc2_y(2);  rc2_x(3);  rc2_y(3);  rc2_x(4);  rc2_y(4);  rc2_x(5);  rc2_y(5);  rc2_x(6);  rc2_y(6)];   
         
cam1_para=cam1_left\cam1_right;  %첫번째 카메라에 대한 DLT parameter.
cam2_para=cam2_left\cam2_right;  %두번째 카메라에 대한 DLT parameter.

if c1_length ~= c2_length
   error('데이터 길이가 같지 않음!!!!');
   return;
end

xyz_coordi=[ 0 0 0]; % 행렬 index를 동일하기 위한 임시 데이터.
for i=1:c1_length
% 3차원 좌표를 구하기 위한 공식의 좌측 행렬   
dlt_left=[cam1_para(1)-(c1_x(i)*cam1_para(9))   cam1_para(2)-(c1_x(i)*cam1_para(10))   cam1_para(3)-(c1_x(i)*cam1_para(11));...
             cam1_para(5)-(c1_y(i)*cam1_para(9))   cam1_para(6)-(c1_y(i)*cam1_para(10))   cam1_para(7)-(c1_y(i)*cam1_para(11));...
             cam2_para(1)-(c2_x(i)*cam2_para(9))   cam2_para(2)-(c2_x(i)*cam2_para(10))   cam2_para(3)-(c2_x(i)*cam2_para(11));...
             cam2_para(5)-(c2_y(i)*cam2_para(9))   cam2_para(6)-(c2_y(i)*cam2_para(10))   cam2_para(7)-(c2_y(i)*cam2_para(11))];
% 3차원 좌표를 구하기 위한 공식의 우측 행렬       
dlt_right=[c1_x(i)-cam1_para(4);   c1_y(i)-cam1_para(8);   c2_x(i)-cam2_para(4);   c2_y(i)-cam2_para(8)];
       
temp_xyz_coordi=dlt_left\dlt_right;
temp_xyz_coordi=temp_xyz_coordi';
xyz_coordi=[xyz_coordi; temp_xyz_coordi];
end

xyz_coordi(1,:)=[]; %위에서 임시로 저장한 데이터를 빼고 나머지를 저장한다.

% 데이터를 저장하는 루틴.
saveyn=input('3차원 좌표 Data를 저장?   1 : 예,   2 : 아니오 ----> :');
switch saveyn
      case 1
         [FILENAME, PATHNAME]=uiputfile('*.dat','Save File');
          if FILENAME ~= 0
             fid=fopen(FILENAME,'w');
             xyz_coordi=xyz_coordi'; %데이터를 열벡터로 변환한다.
             fprintf(fid, '%8.4f  %8.4f  %8.4f \n', xyz_coordi);
             fclose(fid);
          else
             error('Error : 화일 처리에 에러가 발생함');       
          end
          %return;
      case 2
          %return;
      otherwise
          error('Error : 번호를 잘못 선택하였음');
end  

       
         
         