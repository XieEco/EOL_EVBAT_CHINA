clear
clc
set(0,'defaultfigurecolor','w') 
kkk=150000;
%%%%%% Demand module %%%%%
%new car battery
VKT_T=csvread('VKTandT.csv');
VKT=VKT_T(:,1);
Temp=VKT_T(:,2:13);
Ea=[29232.024,56825.3586,29232.024];%Arrhenius
Life=[8.2,10.6,8.2];
for i=1:12
    Life_SYL(:,i)=Life(1,1).*exp(Ea(1,1)./8.314.*(1./(24+273.15)-(1./(Temp(:,i)+273.15))));
    Life_LSTL(:,i)=Life(1,2).*exp(Ea(1,2)./8.314.*(1./(24+273.15)-(1./(Temp(:,i)+273.15))));
    Life_JHL(:,i)=Life(1,3).*exp(Ea(1,3)./8.314.*(1./(24+273.15)-(1./(Temp(:,i)+273.15))));
end
load EVs.mat % EVs projection
N_V4_SED_BEV=N_V4(94:124,:);
N_V4_SED_PHEV=N_V4(63:93,:);
N_V4_SUV_BEV=N_V4(218:248,:);
N_V4_SUV_PHEV=N_V4(187:217,:);
N_V4_MPV_BEV=N_V4(342:372,:);
N_V4_MPV_PHEV=N_V4(311:341,:);
N_V4_CRO_BEV=N_V4(466:496,:);
N_V4_CRO_PHEV=N_V4(435:465,:);
Life_Battery=zeros(31,3);
Life_Battery(:,1)=sum(Life_SYL,2)./12;
Life_Battery(:,2)=sum(Life_LSTL,2)./12;
Life_Battery(:,3)=sum(Life_JHL,2)./12;
Life_Battery(:,1)=Life_Battery(:,1).*19933./VKT(:,1); %average 19933km/year
Life_Battery(:,2)=Life_Battery(:,2).*19933./VKT(:,1);
Life_Battery(:,3)=Life_Battery(:,3).*19933./VKT(:,1);
Times_Battery=ceil(15./Life_Battery);
SCZB_Battery=csvread('Bat_SCZB.csv');
P_S=csvread('pricesale.csv');
Price_Sale=zeros(8,6);
P_S_sum=sum(P_S);
P_S(:,2)=P_S(:,2)./P_S_sum(1,2);
P_S(:,4)=P_S(:,4)./P_S_sum(1,4);
P_S(:,6)=P_S(:,6)./P_S_sum(1,6);
P_S(:,8)=P_S(:,8)./P_S_sum(1,8);
P_S(:,10)=P_S(:,10)./P_S_sum(1,10);
P_S(:,12)=P_S(:,12)./P_S_sum(1,12);%
for i=1:113
if P_S(i,1)<=10
Price_Sale(1,1)=Price_Sale(1,1)+P_S(i,2);
elseif P_S(i,1)<=20
Price_Sale(1,2)=Price_Sale(1,2)+P_S(i,2);
elseif P_S(i,1)<=30
Price_Sale(1,3)=Price_Sale(1,3)+P_S(i,2);
elseif P_S(i,1)<=40
Price_Sale(1,4)=Price_Sale(1,4)+P_S(i,2);
elseif P_S(i,1)<=50
Price_Sale(1,5)=Price_Sale(1,5)+P_S(i,2);
else
Price_Sale(1,6)=Price_Sale(1,6)+P_S(i,2);
end
if P_S(i,3)<=10
Price_Sale(2,1)=Price_Sale(2,1)+P_S(i,4);
elseif P_S(i,3)<=20
Price_Sale(2,2)=Price_Sale(2,2)+P_S(i,4);
elseif P_S(i,3)<=30
Price_Sale(2,3)=Price_Sale(2,3)+P_S(i,4);
elseif P_S(i,3)<=40
Price_Sale(2,4)=Price_Sale(2,4)+P_S(i,4);
elseif P_S(i,3)<=50
Price_Sale(2,5)=Price_Sale(2,5)+P_S(i,4);
else
Price_Sale(2,6)=Price_Sale(2,6)+P_S(i,4);
end
if P_S(i,5)<=10
Price_Sale(3,1)=Price_Sale(3,1)+P_S(i,6);
elseif P_S(i,5)<=20
Price_Sale(3,2)=Price_Sale(3,2)+P_S(i,6);
elseif P_S(i,5)<=30
Price_Sale(3,3)=Price_Sale(3,3)+P_S(i,6);
elseif P_S(i,5)<=40
Price_Sale(3,4)=Price_Sale(3,4)+P_S(i,6);
elseif P_S(i,5)<=50
Price_Sale(3,5)=Price_Sale(3,5)+P_S(i,6);
else
Price_Sale(3,6)=Price_Sale(3,6)+P_S(i,6);
end
if P_S(i,7)<=10
Price_Sale(4,1)=Price_Sale(4,1)+P_S(i,8);
elseif P_S(i,7)<=20
Price_Sale(4,2)=Price_Sale(4,2)+P_S(i,8);
elseif P_S(i,7)<=30
Price_Sale(4,3)=Price_Sale(4,3)+P_S(i,8);
elseif P_S(i,7)<=40
Price_Sale(4,4)=Price_Sale(4,4)+P_S(i,8);
elseif P_S(i,7)<=50
Price_Sale(4,5)=Price_Sale(4,5)+P_S(i,8);
else
Price_Sale(4,6)=Price_Sale(4,6)+P_S(i,8);
end
if P_S(i,9)<=10
Price_Sale(5,1)=Price_Sale(5,1)+P_S(i,10);
elseif P_S(i,9)<=20
Price_Sale(5,2)=Price_Sale(5,2)+P_S(i,10);
elseif P_S(i,9)<=30
Price_Sale(5,3)=Price_Sale(5,3)+P_S(i,10);
elseif P_S(i,9)<=40
Price_Sale(5,4)=Price_Sale(5,4)+P_S(i,10);
elseif P_S(i,9)<=50
Price_Sale(5,5)=Price_Sale(5,5)+P_S(i,10);
else
Price_Sale(5,6)=Price_Sale(5,6)+P_S(i,10);
end
if P_S(i,11)<=10
Price_Sale(6,1)=Price_Sale(6,1)+P_S(i,12);
elseif P_S(i,11)<=20
Price_Sale(6,2)=Price_Sale(6,2)+P_S(i,12);
elseif P_S(i,11)<=30
Price_Sale(6,3)=Price_Sale(6,3)+P_S(i,12);
elseif P_S(i,11)<=40
Price_Sale(6,4)=Price_Sale(6,4)+P_S(i,12);
elseif P_S(i,11)<=50
Price_Sale(6,5)=Price_Sale(6,5)+P_S(i,12);
else
Price_Sale(6,6)=Price_Sale(6,6)+P_S(i,12);
end
end
Price_Sale(7,:)=1./6;
Price_Sale(8,:)=1./6;
DCLX_China=zeros(1,24);
XSL_PP=csvread('xiaoshouliang_pinpai.csv');
DCLX=zeros(200,64);
DCSX=csvread('Battery.csv');
XSQZ=zeros(626,1);
for i=1:626
    if DCSX(i,5)<=100000
        if DCSX(i,1)==1 && DCSX(i,2)==1 % sed-bev
            XSQZ(i,1)=Price_Sale(1,1);
        elseif DCSX(i,1)==1 && DCSX(i,2)==2 % sed-phev
            XSQZ(i,1)=Price_Sale(2,1);
        elseif DCSX(i,1)==2 && DCSX(i,2)==1 % suv-bev
            XSQZ(i,1)=Price_Sale(3,1);            
        elseif DCSX(i,1)==2 && DCSX(i,2)==2 % suv-phev
            XSQZ(i,1)=Price_Sale(4,1);
        elseif DCSX(i,1)==3 && DCSX(i,2)==1 % mpv-bev
            XSQZ(i,1)=Price_Sale(5,1);            
        elseif DCSX(i,1)==3 && DCSX(i,2)==2 % mpv-phev
            XSQZ(i,1)=Price_Sale(6,1);
        elseif DCSX(i,1)==4 && DCSX(i,2)==1 % cro-bev
            XSQZ(i,1)=Price_Sale(7,1);            
        elseif DCSX(i,1)==4 && DCSX(i,2)==2 % cro-phev
            XSQZ(i,1)=Price_Sale(8,1);
        else
        end
    elseif DCSX(i,5)<=200000
        if DCSX(i,1)==1 && DCSX(i,2)==1 % sed-bev
            XSQZ(i,1)=Price_Sale(1,2);
        elseif DCSX(i,1)==1 && DCSX(i,2)==2 % sed-phev
            XSQZ(i,1)=Price_Sale(2,2);
        elseif DCSX(i,1)==2 && DCSX(i,2)==1 % suv-bev
            XSQZ(i,1)=Price_Sale(3,2);            
        elseif DCSX(i,1)==2 && DCSX(i,2)==2 % suv-phev
            XSQZ(i,1)=Price_Sale(4,2);
        elseif DCSX(i,1)==3 && DCSX(i,2)==1 % mpv-bev
            XSQZ(i,1)=Price_Sale(5,2);            
        elseif DCSX(i,1)==3 && DCSX(i,2)==2 % mpv-phev
            XSQZ(i,1)=Price_Sale(6,2);
        elseif DCSX(i,1)==4 && DCSX(i,2)==1 % cro-bev
            XSQZ(i,1)=Price_Sale(7,2);            
        elseif DCSX(i,1)==4 && DCSX(i,2)==2 % cro-phev
            XSQZ(i,1)=Price_Sale(8,2);
        else
        end
    elseif DCSX(i,5)<=300000
        if DCSX(i,1)==1 && DCSX(i,2)==1 % sed-bev
            XSQZ(i,1)=Price_Sale(1,3);
        elseif DCSX(i,1)==1 && DCSX(i,2)==2 % sed-phev
            XSQZ(i,1)=Price_Sale(2,3);
        elseif DCSX(i,1)==2 && DCSX(i,2)==1 % suv-bev
            XSQZ(i,1)=Price_Sale(3,3);            
        elseif DCSX(i,1)==2 && DCSX(i,2)==2 % suv-phev
            XSQZ(i,1)=Price_Sale(4,3);
        elseif DCSX(i,1)==3 && DCSX(i,2)==1 % mpv-bev
            XSQZ(i,1)=Price_Sale(5,3);            
        elseif DCSX(i,1)==3 && DCSX(i,2)==2 % mpv-phev
            XSQZ(i,1)=Price_Sale(6,3);
        elseif DCSX(i,1)==4 && DCSX(i,2)==1 % cro-bev
            XSQZ(i,1)=Price_Sale(7,3);            
        elseif DCSX(i,1)==4 && DCSX(i,2)==2 % cro-phev
            XSQZ(i,1)=Price_Sale(8,3);
        else
        end
    elseif DCSX(i,5)<=400000
        if DCSX(i,1)==1 && DCSX(i,2)==1 % sed-bev
            XSQZ(i,1)=Price_Sale(1,4);
        elseif DCSX(i,1)==1 && DCSX(i,2)==2 % sed-phev
            XSQZ(i,1)=Price_Sale(2,4);
        elseif DCSX(i,1)==2 && DCSX(i,2)==1 % suv-bev
            XSQZ(i,1)=Price_Sale(3,4);            
        elseif DCSX(i,1)==2 && DCSX(i,2)==2 % suv-phev
            XSQZ(i,1)=Price_Sale(4,4);
        elseif DCSX(i,1)==3 && DCSX(i,2)==1 % mpv-bev
            XSQZ(i,1)=Price_Sale(5,4);            
        elseif DCSX(i,1)==3 && DCSX(i,2)==2 % mpv-phev
            XSQZ(i,1)=Price_Sale(6,4);
        elseif DCSX(i,1)==4 && DCSX(i,2)==1 % cro-bev
            XSQZ(i,1)=Price_Sale(7,4);            
        elseif DCSX(i,1)==4 && DCSX(i,2)==2 % cro-phev
            XSQZ(i,1)=Price_Sale(8,4);
        else
        end
    elseif DCSX(i,5)<=500000
        if DCSX(i,1)==1 && DCSX(i,2)==1 % sed-bev
            XSQZ(i,1)=Price_Sale(1,5);
        elseif DCSX(i,1)==1 && DCSX(i,2)==2 % sed-phev
            XSQZ(i,1)=Price_Sale(2,5);
        elseif DCSX(i,1)==2 && DCSX(i,2)==1 % suv-bev
            XSQZ(i,1)=Price_Sale(3,5);            
        elseif DCSX(i,1)==2 && DCSX(i,2)==2 % suv-phev
            XSQZ(i,1)=Price_Sale(4,5);
        elseif DCSX(i,1)==3 && DCSX(i,2)==1 % mpv-bev
            XSQZ(i,1)=Price_Sale(5,5);            
        elseif DCSX(i,1)==3 && DCSX(i,2)==2 % mpv-phev
            XSQZ(i,1)=Price_Sale(6,5);
        elseif DCSX(i,1)==4 && DCSX(i,2)==1 % cro-bev
            XSQZ(i,1)=Price_Sale(7,5);            
        elseif DCSX(i,1)==4 && DCSX(i,2)==2 % cro-phev
            XSQZ(i,1)=Price_Sale(8,5);
        else
        end        
    else
        if DCSX(i,1)==1 && DCSX(i,2)==1 % sed-bev
            XSQZ(i,1)=Price_Sale(1,6);
        elseif DCSX(i,1)==1 && DCSX(i,2)==2 % sed-phev
            XSQZ(i,1)=Price_Sale(2,6);
        elseif DCSX(i,1)==2 && DCSX(i,2)==1 % suv-bev
            XSQZ(i,1)=Price_Sale(3,6);            
        elseif DCSX(i,1)==2 && DCSX(i,2)==2 % suv-phev
            XSQZ(i,1)=Price_Sale(4,6);
        elseif DCSX(i,1)==3 && DCSX(i,2)==1 % mpv-bev
            XSQZ(i,1)=Price_Sale(5,6);            
        elseif DCSX(i,1)==3 && DCSX(i,2)==2 % mpv-phev
            XSQZ(i,1)=Price_Sale(6,6);
        elseif DCSX(i,1)==4 && DCSX(i,2)==1 % cro-bev
            XSQZ(i,1)=Price_Sale(7,6);            
        elseif DCSX(i,1)==4 && DCSX(i,2)==2 % cro-phev
            XSQZ(i,1)=Price_Sale(8,6);
        end
    end
end
for i=1:200
    for j=1:626
        if XSL_PP(i,1)==DCSX(j,6) && XSL_PP(i,2)==DCSX(j,7)
            if DCSX(j,1)==1 && DCSX(j,2)==1 
               if DCSX(j,3)==1 
               DCLX(i,1)=XSQZ(j,1);
               DCLX(i,2)=DCSX(j,4);
               elseif DCSX(j,3)==2 
               DCLX(i,3)=XSQZ(j,1);
               DCLX(i,4)=DCSX(j,4);
               elseif DCSX(j,3)==3 
               DCLX(i,5)=XSQZ(j,1);
               DCLX(i,6)=DCSX(j,4);
               elseif DCSX(j,3)==4 
               DCLX(i,7)=XSQZ(j,1);
               DCLX(i,8)=DCSX(j,4);
               else
               end
            else
            end
            if DCSX(j,1)==1 && DCSX(j,2)==2 
               if DCSX(j,3)==1 
               DCLX(i,9)=XSQZ(j,1);
               DCLX(i,10)=DCSX(j,4);
               elseif DCSX(j,3)==2 
               DCLX(i,11)=XSQZ(j,1);
               DCLX(i,12)=DCSX(j,4);
               elseif DCSX(j,3)==3 
               DCLX(i,13)=XSQZ(j,1);
               DCLX(i,14)=DCSX(j,4);
               elseif DCSX(j,3)==4 
               DCLX(i,15)=XSQZ(j,1);
               DCLX(i,16)=DCSX(j,4);
               else
               end
            else
            end            
            if DCSX(j,1)==2 && DCSX(j,2)==1 
               if DCSX(j,3)==1 
               DCLX(i,17)=XSQZ(j,1);
               DCLX(i,18)=DCSX(j,4);
               elseif DCSX(j,3)==2 
               DCLX(i,19)=XSQZ(j,1);
               DCLX(i,20)=DCSX(j,4);
               elseif DCSX(j,3)==3 
               DCLX(i,21)=XSQZ(j,1);
               DCLX(i,22)=DCSX(j,4);
               elseif DCSX(j,3)==4 
               DCLX(i,23)=XSQZ(j,1);
               DCLX(i,24)=DCSX(j,4);
               else
               end
            else
            end              
            if DCSX(j,1)==2 && DCSX(j,2)==2
               if DCSX(j,3)==1 
               DCLX(i,25)=XSQZ(j,1);
               DCLX(i,26)=DCSX(j,4);
               elseif DCSX(j,3)==2 
               DCLX(i,27)=XSQZ(j,1);
               DCLX(i,28)=DCSX(j,4);
               elseif DCSX(j,3)==3 
               DCLX(i,29)=XSQZ(j,1);
               DCLX(i,30)=DCSX(j,4);
               elseif DCSX(j,3)==4 
               DCLX(i,31)=XSQZ(j,1);
               DCLX(i,32)=DCSX(j,4);
               else
               end
            else
            end              
            if DCSX(j,1)==3 && DCSX(j,2)==1 
               if DCSX(j,3)==1 
               DCLX(i,33)=XSQZ(j,1);
               DCLX(i,34)=DCSX(j,4);
               elseif DCSX(j,3)==2 
               DCLX(i,35)=XSQZ(j,1);
               DCLX(i,36)=DCSX(j,4);
               elseif DCSX(j,3)==3 
               DCLX(i,37)=XSQZ(j,1);
               DCLX(i,38)=DCSX(j,4);
               elseif DCSX(j,3)==4 
               DCLX(i,39)=XSQZ(j,1);
               DCLX(i,40)=DCSX(j,4);
               else
               end
            else
            end             
            if DCSX(j,1)==3 && DCSX(j,2)==2
               if DCSX(j,3)==1 
               DCLX(i,41)=XSQZ(j,1);
               DCLX(i,42)=DCSX(j,4);
               elseif DCSX(j,3)==2 
               DCLX(i,43)=XSQZ(j,1);
               DCLX(i,44)=DCSX(j,4);
               elseif DCSX(j,3)==3 
               DCLX(i,45)=XSQZ(j,1);
               DCLX(i,46)=DCSX(j,4);
               elseif DCSX(j,3)==4 
               DCLX(i,47)=XSQZ(j,1);
               DCLX(i,48)=DCSX(j,4);
               else
               end
            else
            end
            if DCSX(j,1)==4 && DCSX(j,2)==1
               if DCSX(j,3)==1 
               DCLX(i,49)=XSQZ(j,1);
               DCLX(i,50)=DCSX(j,4);
               elseif DCSX(j,3)==2 
               DCLX(i,51)=XSQZ(j,1);
               DCLX(i,52)=DCSX(j,4);
               elseif DCSX(j,3)==3 
               DCLX(i,53)=XSQZ(j,1);
               DCLX(i,54)=DCSX(j,4);
               elseif DCSX(j,3)==4 
               DCLX(i,55)=XSQZ(j,1);
               DCLX(i,56)=DCSX(j,4);
               else
               end
            else
            end            
            if DCSX(j,1)==4 && DCSX(j,2)==2 
               if DCSX(j,3)==1
               DCLX(i,57)=XSQZ(j,1);
               DCLX(i,58)=DCSX(j,4);
               elseif DCSX(j,3)==2 
               DCLX(i,59)=XSQZ(j,1);
               DCLX(i,60)=DCSX(j,4);
               elseif DCSX(j,3)==3 
               DCLX(i,61)=XSQZ(j,1);
               DCLX(i,62)=DCSX(j,4);
               elseif DCSX(j,3)==4 
               DCLX(i,63)=XSQZ(j,1);
               DCLX(i,64)=DCSX(j,4);
               else
               end
            else
            end                   
        else
        end
    end
end
ZQZ=sum(DCLX);
for i=1:32
    for j=1:200
DCLX(j,(i-1).*2+1)=DCLX(j,(i-1).*2+1)./ZQZ(1,(i-1).*2+1);
    end
end
DCLX(isnan(DCLX))=0;
%sed-bev
DCLX_China(1,1)=sum((DCLX(:,1).*DCLX(:,2)));
DCLX_China(1,2)=sum((DCLX(:,3).*DCLX(:,4)));
DCLX_China(1,3)=sum((DCLX(:,5).*DCLX(:,6)));
%sed-phev
DCLX_China(1,4)=sum((DCLX(:,1+8).*DCLX(:,2+8)));
DCLX_China(1,5)=sum((DCLX(:,3+8).*DCLX(:,4+8)));
DCLX_China(1,6)=sum((DCLX(:,5+8).*DCLX(:,6+8)));
%suv-bev
DCLX_China(1,1+6)=sum((DCLX(:,1+16).*DCLX(:,2+16)));
DCLX_China(1,2+6)=sum((DCLX(:,3+16).*DCLX(:,4+16)));
DCLX_China(1,3+6)=sum((DCLX(:,5+16).*DCLX(:,6+16)));%
%suv-phev
DCLX_China(1,4+6)=sum((DCLX(:,1+8+16).*DCLX(:,2+8+16)));
DCLX_China(1,5+6)=sum((DCLX(:,3+8+16).*DCLX(:,4+8+16)));
DCLX_China(1,6+6)=sum((DCLX(:,5+8+16).*DCLX(:,6+8+16)));
%mpv-bev
DCLX_China(1,1+6+6)=sum((DCLX(:,1+16+16).*DCLX(:,2+16+16)));
DCLX_China(1,2+6+6)=sum((DCLX(:,3+16+16).*DCLX(:,4+16+16)));
DCLX_China(1,3+6+6)=sum((DCLX(:,5+16+16).*DCLX(:,6+16+16)));
%mpv-phev
DCLX_China(1,4+6+6)=sum((DCLX(:,1+8+16+16).*DCLX(:,2+8+16+16)));
DCLX_China(1,5+6+6)=sum((DCLX(:,3+8+16+16).*DCLX(:,4+8+16+16)));
DCLX_China(1,6+6+6)=sum((DCLX(:,5+8+16+16).*DCLX(:,6+8+16+16)));
%cro-bev
DCLX_China(1,1+6+6+6)=sum((DCLX(:,1+16+16+16).*DCLX(:,2+16+16+16)));
DCLX_China(1,2+6+6+6)=sum((DCLX(:,3+16+16+16).*DCLX(:,4+16+16+16)));
DCLX_China(1,3+6+6+6)=sum((DCLX(:,5+16+16+16).*DCLX(:,6+16+16+16)));
%cro-phev
DCLX_China(1,4+6+6+6)=sum((DCLX(:,1+8+16+16+16).*DCLX(:,2+8+16+16+16)));
DCLX_China(1,5+6+6+6)=sum((DCLX(:,3+8+16+16+16).*DCLX(:,4+8+16+16+16)));
DCLX_China(1,6+6+6+6)=sum((DCLX(:,5+8+16+16+16).*DCLX(:,6+8+16+16+16)));
XQ_CARBAT=zeros(93,100);
for i=1:31
    for j=1:49
    for k=1:Times_Battery(i,1)
    XQ_CARBAT(i,j+k.*round(Life_Battery(i,1)))=XQ_CARBAT(i,j+k.*round(Life_Battery(i,1)))+(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
    end
     for k=1:Times_Battery(i,2)
    XQ_CARBAT(i+31,j+k.*round(Life_Battery(i,2)))=XQ_CARBAT(i+31,j+k.*round(Life_Battery(i,2)))+(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
     end
     for k=1:Times_Battery(i,3)
    XQ_CARBAT(i+31+31,j+k.*round(Life_Battery(i,3)))=XQ_CARBAT(i+31,j+k.*round(Life_Battery(i,3)))+(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
     end
    end
end
for i=1:31
    for j=1:49
    XQ_CARBAT(i,j)=XQ_CARBAT(i,j)+(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
  XQ_CARBAT(i+31,j)=XQ_CARBAT(i+31,j)+(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
    XQ_CARBAT(i+31+31,j)=XQ_CARBAT(i+31+31,j)+(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
    end
end
CNGSXS=[2.634	2.5872	2.5404	2.4936	2.4468	2.4	2.3532	2.3064	2.2596	2.2128	2.166	2.1192	2.0724	2.0256	1.9788	1.932	1.8852	1.8384	1.7916	1.7448	1.698	1.6512	1.6044	1.5576	1.5108	1.464	1.4172	1.3704	1.3236	1.2768	1.23];
XQ_CARBAT=XQ_CARBAT.*100./10^8;%GWh
XQ_XUNHUAN_CHINA=sum(XQ_CARBAT(:,19:49)).*CNGSXS(1,:);
XQ_XUNHUAN_CHINA1=sum(XQ_CARBAT(1:31,19:49)).*CNGSXS(1,:);
XQ_XUNHUAN_CHINA2=sum(XQ_CARBAT(32:62,19:49)).*CNGSXS(1,:);
XQ_XUNHUAN_CHINA3=sum(XQ_CARBAT(63:93,19:49)).*CNGSXS(1,:);
DCSCBL=csvread('DCSCBL.csv');
XQ_XUNHUAN=zeros(31,31);
for i=1:31
for    j=1:31
XQ_XUNHUAN(i,j)=DCSCBL(i,1).*XQ_XUNHUAN_CHINA(1,j);
end
end
for i=1:31
for    j=1:31
XQ_XH3B(i,j)=DCSCBL(i,1).*XQ_XUNHUAN_CHINA1(1,j);
XQ_XH3B(i+31,j)=DCSCBL(i,1).*XQ_XUNHUAN_CHINA2(1,j);
XQ_XH3B(i+62,j)=DCSCBL(i,1).*XQ_XUNHUAN_CHINA3(1,j);
end
end
%battery energy storage
Power_pv=csvread('pv.csv').*0.01;
Power_wind=csvread('wind.csv').*0.01;
CF=csvread('CF.csv');%1-pv;2-wind
for i=1:31
D_pv(i,:)=Power_pv(i,:)./(CF(i,1).*24.*365).*0.027.*2.51;
D_wind(i,:)=Power_wind(i,:)./(CF(i,2).*24.*365).*0.028.*1.58;
end
D_power=zeros(31,31);%2020-2050
for i=1:31
    for j=1:31
   if D_pv(i,j)>=D_wind(i,j)
      D_power(i,j)= D_pv(i,j);
   else
      D_power(i,j)= D_wind(i,j); 
   end
    end
end
for i=1:31
D_bs(:,i)=D_power(:,i)./(1+exp(-0.3031.*(i-21))).*2.11406129;%GWh
end
D_bs_China=sum(D_bs);%GWh
for i=1:20
    BFL_bs1(1,i)=1./(1+exp(-2.*(i-12.5)));
end
BFL_bs1(1,20)=1;
BFL_bs=zeros(1,20);
for i=2:20
    BFL_bs(1,i)=BFL_bs1(1,i)-BFL_bs1(1,i-1);
end
CHL_bs=1-BFL_bs; 
D_bs_history=[0.05623403 0.061209121 0.087691262 0.163769281	0.201822384	0.303092967	0.824061091	1.604149707	2.91304454].*4.1335./6.137;%GWh
BF_bs=zeros(31,51);
for i=1:9
    for j=10:20
BF_bs_china(1,j-9)=D_bs_history(1,i).*BFL_bs(1,j-i);
    end
end
Z=sum(D_bs);
for i=1:31
    for j=1:11
   BF_bs(i,j)=BF_bs(i,j)+BF_bs_china(1,j).*D_bs(i,j)./Z(1,j);
    end
end
for i=1:31
    for j=1:31
        for t=1:20
BF_bs(i,j+t)=BF_bs(i,j+t)+D_bs(i,j).*BFL_bs(1,t);
        end
    end
end
N_bs=zeros(31,31);
N_bs(:,1)=D_bs(:,1)-D_bs_history(1,9).*D_bs(:,1)./Z(1,1)+BF_bs(:,1);%2020
for i=2:31
N_bs(:,i)=D_bs(:,i)-D_bs(:,i-1)+BF_bs(:,i);%demand，GWh
end
result999=sum(N_bs);
XQ_TCLY(32:62,:)=N_bs(1:31,:);
XQ_TCLY(63:93,:)=0;
XQ_TCLY(1:31,:)=0;
%%%%% Supply module %%%%%
% retired battery
%V4,retired battery
V4_result=zeros(93,72);
for i=1:31
    for j=1:49
V4_result(i,j+ceil(Life_Battery(i,1)))=V4_result(i,j+ceil(Life_Battery(i,1)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
        if Times_Battery(i,1)==2
V4_result(i,j+15)=V4_result(i,j+15)+(1-0.2.*(15-5.*Life_Battery(i,1))./Life_Battery(i,1)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
        elseif Times_Battery(i,1)==3
V4_result(i,j+2.*ceil(Life_Battery(i,1)))=V4_result(i,j+2.*ceil(Life_Battery(i,1)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
V4_result(i,j+15)=V4_result(i,j+15)+(1-0.2.*(15-5.*Life_Battery(i,1))./Life_Battery(i,1)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
        elseif Times_Battery(i,1)==4
V4_result(i,j+2.*ceil(Life_Battery(i,1)))=V4_result(i,j+2.*ceil(Life_Battery(i,1)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
V4_result(i,j+3.*ceil(Life_Battery(i,1)))=V4_result(i,j+3.*ceil(Life_Battery(i,1)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
V4_result(i,j+15)=V4_result(i,j+15)+(1-0.2.*(15-5.*Life_Battery(i,1))./Life_Battery(i,1)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
        elseif Times_Battery(i,1)==5
V4_result(i,j+2.*ceil(Life_Battery(i,1)))=V4_result(i,j+2.*ceil(Life_Battery(i,1)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
V4_result(i,j+3.*ceil(Life_Battery(i,1)))=V4_result(i,j+3.*ceil(Life_Battery(i,1)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
V4_result(i,j+4.*ceil(Life_Battery(i,1)))=V4_result(i,j+4.*ceil(Life_Battery(i,1)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
V4_result(i,j+15)=V4_result(i,j+15)+(1-0.2.*(15-5.*Life_Battery(i,1))./Life_Battery(i,1)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
        elseif Times_Battery(i,1)==6
V4_result(i,j+2.*ceil(Life_Battery(i,1)))=V4_result(i,j+2.*ceil(Life_Battery(i,1)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
V4_result(i,j+3.*ceil(Life_Battery(i,1)))=V4_result(i,j+3.*ceil(Life_Battery(i,1)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
V4_result(i,j+4.*ceil(Life_Battery(i,1)))=V4_result(i,j+4.*ceil(Life_Battery(i,1)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
V4_result(i,j+5.*ceil(Life_Battery(i,1)))=V4_result(i,j+5.*ceil(Life_Battery(i,1)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
V4_result(i,j+15)=V4_result(i,j+15)+(1-0.2.*(15-5.*Life_Battery(i,1))./Life_Battery(i,1)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(1,j).*DCLX_China(1,22));
        end   
V4_result(i+62,j+ceil(Life_Battery(i,3)))=V4_result(i+62,j+ceil(Life_Battery(i,3)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
        if Times_Battery(i,1)==2
V4_result(i+62,j+15)=V4_result(i+62,j+15)+(1-0.2.*(15-5.*Life_Battery(i,3))./Life_Battery(i,3)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
        elseif Times_Battery(i,1)==3
V4_result(i+62,j+2.*ceil(Life_Battery(i,3)))=V4_result(i+62,j+2.*ceil(Life_Battery(i,3)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
V4_result(i+62,j+15)=V4_result(i+62,j+15)+(1-0.2.*(15-5.*Life_Battery(i,3))./Life_Battery(i,3)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
        elseif Times_Battery(i,1)==4
V4_result(i+62,j+2.*ceil(Life_Battery(i,3)))=V4_result(i+62,j+2.*ceil(Life_Battery(i,3)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
V4_result(i+62,j+3.*ceil(Life_Battery(i,3)))=V4_result(i+62,j+3.*ceil(Life_Battery(i,3)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
V4_result(i+62,j+15)=V4_result(i+62,j+15)+(1-0.2.*(15-5.*Life_Battery(i,3))./Life_Battery(i,3)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
        elseif Times_Battery(i,1)==5
V4_result(i+62,j+2.*ceil(Life_Battery(i,3)))=V4_result(i+62,j+2.*ceil(Life_Battery(i,3)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
V4_result(i+62,j+3.*ceil(Life_Battery(i,3)))=V4_result(i+62,j+3.*ceil(Life_Battery(i,3)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
V4_result(i+62,j+4.*ceil(Life_Battery(i,3)))=V4_result(i+62,j+4.*ceil(Life_Battery(i,3)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
V4_result(i+62,j+15)=V4_result(i+62,j+15)+(1-0.2.*(15-5.*Life_Battery(i,3))./Life_Battery(i,3)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
        elseif Times_Battery(i,1)==6
V4_result(i+62,j+2.*ceil(Life_Battery(i,3)))=V4_result(i+62,j+2.*ceil(Life_Battery(i,3)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
V4_result(i+62,j+3.*ceil(Life_Battery(i,3)))=V4_result(i+62,j+3.*ceil(Life_Battery(i,3)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
V4_result(i+62,j+4.*ceil(Life_Battery(i,3)))=V4_result(i+62,j+4.*ceil(Life_Battery(i,3)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
V4_result(i+62,j+5.*ceil(Life_Battery(i,3)))=V4_result(i+62,j+5.*ceil(Life_Battery(i,3)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
V4_result(i+62,j+15)=V4_result(i+62,j+15)+(1-0.2.*(15-5.*Life_Battery(i,3))./Life_Battery(i,3)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(3,j).*DCLX_China(1,2+22));
        end 
V4_result(i+31,j+ceil(Life_Battery(i,2)))=V4_result(i+31,j+ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
        if Times_Battery(i,2)==2
V4_result(i+31,j+15)=V4_result(i+31,j+15)+(1-0.2.*(15-5.*Life_Battery(i,2))./Life_Battery(i,2)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
        elseif Times_Battery(i,2)==3
V4_result(i+31,j+2.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+2.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));            
V4_result(i+31,j+15)=V4_result(i+31,j+15)+(1-0.2.*(15-5.*Life_Battery(i,2))./Life_Battery(i,2)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
        elseif Times_Battery(i,2)==4
V4_result(i+31,j+2.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+2.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+3.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+3.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+15)=V4_result(i+31,j+15)+(1-0.2.*(15-5.*Life_Battery(i,2))./Life_Battery(i,2)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
        elseif Times_Battery(i,2)==5
V4_result(i+31,j+2.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+2.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+3.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+3.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+4.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+4.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+15)=V4_result(i+31,j+15)+(1-0.2.*(15-5.*Life_Battery(i,2))./Life_Battery(i,2)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
        elseif Times_Battery(i,2)==6
V4_result(i+31,j+2.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+2.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+3.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+3.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+4.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+4.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+5.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+5.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+15)=V4_result(i+31,j+15)+(1-0.2.*(15-5.*Life_Battery(i,2))./Life_Battery(i,2)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
        elseif Times_Battery(i,2)==7
V4_result(i+31,j+2.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+2.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+3.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+3.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+4.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+4.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+5.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+5.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+6.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+6.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+15)=V4_result(i+31,j+15)+(1-0.2.*(15-5.*Life_Battery(i,2))./Life_Battery(i,2)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
        elseif Times_Battery(i,2)==8
V4_result(i+31,j+2.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+2.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+3.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+3.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+4.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+4.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+5.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+5.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+6.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+6.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+7.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+7.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+15)=V4_result(i+31,j+15)+(1-0.2.*(15-5.*Life_Battery(i,2))./Life_Battery(i,2)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
        elseif Times_Battery(i,2)==9
V4_result(i+31,j+2.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+2.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+3.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+3.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+4.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+4.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+5.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+5.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+6.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+6.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+7.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+7.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+8.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+8.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
V4_result(i+31,j+15)=V4_result(i+31,j+15)+(1-0.2.*(15-5.*Life_Battery(i,2))./Life_Battery(i,2)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));
        elseif Times_Battery(i,2)==10
V4_result(i+31,j+2.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+2.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));      
V4_result(i+31,j+3.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+3.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));     
V4_result(i+31,j+4.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+4.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));       
V4_result(i+31,j+5.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+5.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));     
V4_result(i+31,j+6.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+6.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));      
V4_result(i+31,j+7.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+7.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));     
V4_result(i+31,j+8.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+8.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));     
V4_result(i+31,j+9.*ceil(Life_Battery(i,2)))=V4_result(i+31,j+9.*ceil(Life_Battery(i,2)))+0.8.*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));       
V4_result(i+31,j+15)=V4_result(i+31,j+15)+(1-0.2.*(15-5.*Life_Battery(i,2))./Life_Battery(i,2)).*(N_V4_SED_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+1)+N_V4_SED_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+4)+N_V4_SUV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+7)+N_V4_SUV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+10)+N_V4_MPV_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+13)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+16)+N_V4_CRO_BEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+19)+N_V4_MPV_PHEV(i,j).*SCZB_Battery(2,j).*DCLX_China(1,1+22));      
        end  
    end
end
China_battery(4,:)=sum(V4_result(:,1:49)).*100./10^8;%GWh
% Scenario
HSL_base=[0.25 	0.25 	0.25 	0.25 	0.25 	0.25 	0.25 
0.25 	0.39 	0.47 	0.48 	0.48 	0.48 	0.48 
0.25 	0.54 	0.68 	0.71 	0.72 	0.72 	0.72 
0.25 	0.68 	0.90 	0.94 	0.95 	0.95 	0.95 ];%Collection
HSL=zeros(4,31);%year
for i=1:6
    HSL(:,(i-1).*5+1)=HSL_base(:,i);
    HSL(:,(i-1).*5+2)=HSL_base(:,i)+(HSL_base(:,i+1)-HSL_base(:,i))./5;
    HSL(:,(i-1).*5+3)=HSL_base(:,i)+(HSL_base(:,i+1)-HSL_base(:,i))./5.*2;
    HSL(:,(i-1).*5+4)=HSL_base(:,i)+(HSL_base(:,i+1)-HSL_base(:,i))./5.*3;
    HSL(:,(i-1).*5+5)=HSL_base(:,i)+(HSL_base(:,i+1)-HSL_base(:,i))./5.*4;
end
HSL(:,31)=HSL_base(:,7);
% B1-BAU;B2-MR；B3-DR；B4-SU；B5-BA
B1=zeros(3,31);%回收的电池的处置方式选择比例，1-冶金，2-二次，3-直接回收
B1(1,:)=1;
B2_base=[1.00 	0.96 	0.89 	0.87 	0.86 	0.86 	0.86 
0.00 	0.02 	0.06 	0.06 	0.07 	0.07 	0.07 
0.00 	0.02 	0.06 	0.06 	0.07 	0.07 	0.07 ];
B2=zeros(3,31);
for i=1:6
    B2(:,(i-1).*5+1)=B2_base(:,i);
    B2(:,(i-1).*5+2)=B2_base(:,i)+(B2_base(:,i+1)-B2_base(:,i))./5;
    B2(:,(i-1).*5+3)=B2_base(:,i)+(B2_base(:,i+1)-B2_base(:,i))./5.*2;
    B2(:,(i-1).*5+4)=B2_base(:,i)+(B2_base(:,i+1)-B2_base(:,i))./5.*3;
    B2(:,(i-1).*5+5)=B2_base(:,i)+(B2_base(:,i+1)-B2_base(:,i))./5.*4;
end
B2(:,31)=B2_base(:,7);
B3_base=[1.00 	0.84 	0.67 	0.55 	0.47 	0.41 	0.37 
0.00 	0.03 	0.03 	0.04 	0.05 	0.06 	0.06 
0.00 	0.13 	0.30 	0.40 	0.47 	0.53 	0.57 ];
B3=zeros(3,31);
for i=1:6
    B3(:,(i-1).*5+1)=B3_base(:,i);
    B3(:,(i-1).*5+2)=B3_base(:,i)+(B3_base(:,i+1)-B3_base(:,i))./5;
    B3(:,(i-1).*5+3)=B3_base(:,i)+(B3_base(:,i+1)-B3_base(:,i))./5.*2;
    B3(:,(i-1).*5+4)=B3_base(:,i)+(B3_base(:,i+1)-B3_base(:,i))./5.*3;
    B3(:,(i-1).*5+5)=B3_base(:,i)+(B3_base(:,i+1)-B3_base(:,i))./5.*4;
end
B3(:,31)=B3_base(:,7);
B4_base=[1.00 	0.84 	0.67 	0.55 	0.47 	0.41 	0.37 
0.00 	0.13 	0.30 	0.40 	0.47 	0.53 	0.57 
0.00 	0.03 	0.03 	0.04 	0.05 	0.06 	0.06 ];
B4=zeros(3,31);
for i=1:6
    B4(:,(i-1).*5+1)=B4_base(:,i);
    B4(:,(i-1).*5+2)=B4_base(:,i)+(B4_base(:,i+1)-B4_base(:,i))./5;
    B4(:,(i-1).*5+3)=B4_base(:,i)+(B4_base(:,i+1)-B4_base(:,i))./5.*2;
    B4(:,(i-1).*5+4)=B4_base(:,i)+(B4_base(:,i+1)-B4_base(:,i))./5.*3;
    B4(:,(i-1).*5+5)=B4_base(:,i)+(B4_base(:,i+1)-B4_base(:,i))./5.*4;
end
B4(:,31)=B4_base(:,7);
B5_base=[1.00 	0.85 	0.67 	0.54 	0.47 	0.42 	0.37 
0.00 	0.07 	0.17 	0.23 	0.26 	0.29 	0.32 
0.00 	0.07 	0.17 	0.23 	0.26 	0.29 	0.32 ];
B5=zeros(3,31);
for i=1:6
    B5(:,(i-1).*5+1)=B5_base(:,i);
    B5(:,(i-1).*5+2)=B5_base(:,i)+(B5_base(:,i+1)-B5_base(:,i))./5;
    B5(:,(i-1).*5+3)=B5_base(:,i)+(B5_base(:,i+1)-B5_base(:,i))./5.*2;
    B5(:,(i-1).*5+4)=B5_base(:,i)+(B5_base(:,i+1)-B5_base(:,i))./5.*3;
    B5(:,(i-1).*5+5)=B5_base(:,i)+(B5_base(:,i+1)-B5_base(:,i))./5.*4;
end
B5(:,31)=B5_base(:,7);
HSCSQJ=zeros(52,31);
HSCSQJ(4,:)=1-HSL(1,:);%LOW-B1
HSCSQJ(1:3,:)=B1(:,:).*HSL(1,:);
HSCSQJ(8,:)=1-HSL(2,:);%LOW-B2
HSCSQJ(5:7,:)=B2(:,:).*HSL(2,:);
HSCSQJ(12,:)=1-HSL(2,:);%LOW-B3
HSCSQJ(9:11,:)=B3(:,:).*HSL(2,:);
HSCSQJ(16,:)=1-HSL(2,:);%LOW-B4
HSCSQJ(13:15,:)=B4(:,:).*HSL(2,:);
HSCSQJ(20,:)=1-HSL(2,:);%LOW-B5
HSCSQJ(17:19,:)=B5(:,:).*HSL(2,:);
HSCSQJ(8+16,:)=1-HSL(3,:);%mid-B2
HSCSQJ(21:23,:)=B2(:,:).*HSL(3,:);
HSCSQJ(12+16,:)=1-HSL(3,:);%mid-B3
HSCSQJ(25:27,:)=B3(:,:).*HSL(3,:);
HSCSQJ(16+16,:)=1-HSL(3,:);%mid-B4
HSCSQJ(29:31,:)=B4(:,:).*HSL(3,:);
HSCSQJ(20+16,:)=1-HSL(3,:);%mid-B5
HSCSQJ(33:35,:)=B5(:,:).*HSL(3,:);
HSCSQJ(8+16+16,:)=1-HSL(4,:);%HIG-B2
HSCSQJ((21+16):(23+16),:)=B2(:,:).*HSL(4,:);
HSCSQJ(12+16+16,:)=1-HSL(4,:);%HIG-B3
HSCSQJ((25+16):(27+16),:)=B3(:,:).*HSL(4,:);
HSCSQJ(16+16+16,:)=1-HSL(4,:);%HIG-B4
HSCSQJ((29+16):(31+16),:)=B4(:,:).*HSL(4,:);
HSCSQJ(20+16+16,:)=1-HSL(4,:);%HIG-B5
HSCSQJ((33+16):(35+16),:)=B5(:,:).*HSL(4,:);
% finnal supply
GG=V4_result(:,19:49).*100./10^8;%GWh
%BAU-B1
GG_BAU_B1_WSJ(1:31,:)=GG(1:31,:).*HSCSQJ(4,:);
GG_BAU_B1_WSJ(32:62,:)=GG(32:62,:).*HSCSQJ(4,:);
GG_BAU_B1_WSJ(63:93,:)=GG(63:93,:).*HSCSQJ(4,:);
GG_BAU_B1_TCLY(32:62,:)=(GG(1:31,:)+GG(32:62,:)+GG(63:93,:)).*HSCSQJ(2,:);
GG_BAU_B1_TCLY(1:31,:)=0;
GG_BAU_B1_TCLY(63:93,:)=0;
GG_BAU_B1_YEJIN(:,:)=(GG(:,:)-GG_BAU_B1_WSJ(:,:)-GG_BAU_B1_TCLY(:,:)).*(HSCSQJ(1,:)./(HSCSQJ(1,:)+HSCSQJ(3,:)));
GG_BAU_B1_XUNHUAN(:,:)=(GG(:,:)-GG_BAU_B1_WSJ(:,:)-GG_BAU_B1_TCLY(:,:)).*(HSCSQJ(3,:)./(HSCSQJ(1,:)+HSCSQJ(3,:))).*0.95;
%LOW-B2
A=4;
GG_LOW_B2_WSJ(1:31,:)=GG(1:31,:).*HSCSQJ(4+A,:);
GG_LOW_B2_WSJ(32:62,:)=GG(32:62,:).*HSCSQJ(4+A,:);
GG_LOW_B2_WSJ(63:93,:)=GG(63:93,:).*HSCSQJ(4+A,:);
GG_LOW_B2_TCLY(32:62,:)=(GG(1:31,:)+GG(32:62,:)+GG(63:93,:)).*HSCSQJ(2+A,:);
GG_LOW_B2_TCLY(1:31,:)=0;
GG_LOW_B2_TCLY(63:93,:)=0;
GG_LOW_B2_YEJIN(:,:)=(GG(:,:)-GG_LOW_B2_WSJ(:,:)-GG_LOW_B2_TCLY(:,:)).*(HSCSQJ(1+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:)));
GG_LOW_B2_XUNHUAN(:,:)=(GG(:,:)-GG_LOW_B2_WSJ(:,:)-GG_LOW_B2_TCLY(:,:)).*(HSCSQJ(3+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:))).*0.95;
%LOW_B3
A=8;
GG_LOW_B3_WSJ(1:31,:)=GG(1:31,:).*HSCSQJ(4+A,:);
GG_LOW_B3_WSJ(32:62,:)=GG(32:62,:).*HSCSQJ(4+A,:);
GG_LOW_B3_WSJ(63:93,:)=GG(63:93,:).*HSCSQJ(4+A,:);
GG_LOW_B3_TCLY(32:62,:)=(GG(1:31,:)+GG(32:62,:)+GG(63:93,:)).*HSCSQJ(2+A,:);
GG_LOW_B3_TCLY(1:31,:)=0;
GG_LOW_B3_TCLY(63:93,:)=0;
GG_LOW_B3_YEJIN(:,:)=(GG(:,:)-GG_LOW_B3_WSJ(:,:)-GG_LOW_B3_TCLY(:,:)).*(HSCSQJ(1+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:)));
GG_LOW_B3_XUNHUAN(:,:)=(GG(:,:)-GG_LOW_B3_WSJ(:,:)-GG_LOW_B3_TCLY(:,:)).*(HSCSQJ(3+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:))).*0.95;
%LOW_B4
A=4.*3;
GG_LOW_B4_WSJ(1:31,:)=GG(1:31,:).*HSCSQJ(4+A,:);
GG_LOW_B4_WSJ(32:62,:)=GG(32:62,:).*HSCSQJ(4+A,:);
GG_LOW_B4_WSJ(63:93,:)=GG(63:93,:).*HSCSQJ(4+A,:);
GG_LOW_B4_TCLY(32:62,:)=(GG(1:31,:)+GG(32:62,:)+GG(63:93,:)).*HSCSQJ(2+A,:);
GG_LOW_B4_TCLY(1:31,:)=0;
GG_LOW_B4_TCLY(63:93,:)=0;
GG_LOW_B4_YEJIN(:,:)=(GG(:,:)-GG_LOW_B4_WSJ(:,:)-GG_LOW_B4_TCLY(:,:)).*(HSCSQJ(1+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:)));
GG_LOW_B4_XUNHUAN(:,:)=(GG(:,:)-GG_LOW_B4_WSJ(:,:)-GG_LOW_B4_TCLY(:,:)).*(HSCSQJ(3+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:))).*0.95;
%LOW_B5
A=4.*4;
GG_LOW_B5_WSJ(1:31,:)=GG(1:31,:).*HSCSQJ(4+A,:);
GG_LOW_B5_WSJ(32:62,:)=GG(32:62,:).*HSCSQJ(4+A,:);
GG_LOW_B5_WSJ(63:93,:)=GG(63:93,:).*HSCSQJ(4+A,:);
GG_LOW_B5_TCLY(32:62,:)=(GG(1:31,:)+GG(32:62,:)+GG(63:93,:)).*HSCSQJ(2+A,:);
GG_LOW_B5_TCLY(1:31,:)=0;
GG_LOW_B5_TCLY(63:93,:)=0;
GG_LOW_B5_YEJIN(:,:)=(GG(:,:)-GG_LOW_B5_WSJ(:,:)-GG_LOW_B5_TCLY(:,:)).*(HSCSQJ(1+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:)));
GG_LOW_B5_XUNHUAN(:,:)=(GG(:,:)-GG_LOW_B5_WSJ(:,:)-GG_LOW_B5_TCLY(:,:)).*(HSCSQJ(3+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:))).*0.95;
%MID_B2
A=4.*5;
GG_MID_B2_WSJ(1:31,:)=GG(1:31,:).*HSCSQJ(4+A,:);
GG_MID_B2_WSJ(32:62,:)=GG(32:62,:).*HSCSQJ(4+A,:);
GG_MID_B2_WSJ(63:93,:)=GG(63:93,:).*HSCSQJ(4+A,:);
GG_MID_B2_TCLY(32:62,:)=(GG(1:31,:)+GG(32:62,:)+GG(63:93,:)).*HSCSQJ(2+A,:);
GG_MID_B2_TCLY(1:31,:)=0;
GG_MID_B2_TCLY(63:93,:)=0;
GG_MID_B2_YEJIN(:,:)=(GG(:,:)-GG_MID_B2_WSJ(:,:)-GG_MID_B2_TCLY(:,:)).*(HSCSQJ(1+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:)));
GG_MID_B2_XUNHUAN(:,:)=(GG(:,:)-GG_MID_B2_WSJ(:,:)-GG_MID_B2_TCLY(:,:)).*(HSCSQJ(3+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:))).*0.95;
%MID_B3
A=4.*6;
GG_MID_B3_WSJ(1:31,:)=GG(1:31,:).*HSCSQJ(4+A,:);
GG_MID_B3_WSJ(32:62,:)=GG(32:62,:).*HSCSQJ(4+A,:);
GG_MID_B3_WSJ(63:93,:)=GG(63:93,:).*HSCSQJ(4+A,:);
GG_MID_B3_TCLY(32:62,:)=(GG(1:31,:)+GG(32:62,:)+GG(63:93,:)).*HSCSQJ(2+A,:);
GG_MID_B3_TCLY(1:31,:)=0;
GG_MID_B3_TCLY(63:93,:)=0;
GG_MID_B3_YEJIN(:,:)=(GG(:,:)-GG_MID_B3_WSJ(:,:)-GG_MID_B3_TCLY(:,:)).*(HSCSQJ(1+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:)));
GG_MID_B3_XUNHUAN(:,:)=(GG(:,:)-GG_MID_B3_WSJ(:,:)-GG_MID_B3_TCLY(:,:)).*(HSCSQJ(3+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:))).*0.95;
%MID_B4
A=4.*7;
GG_MID_B4_WSJ(1:31,:)=GG(1:31,:).*HSCSQJ(4+A,:);
GG_MID_B4_WSJ(32:62,:)=GG(32:62,:).*HSCSQJ(4+A,:);
GG_MID_B4_WSJ(63:93,:)=GG(63:93,:).*HSCSQJ(4+A,:);
GG_MID_B4_TCLY(32:62,:)=(GG(1:31,:)+GG(32:62,:)+GG(63:93,:)).*HSCSQJ(2+A,:);
GG_MID_B4_TCLY(1:31,:)=0;
GG_MID_B4_TCLY(63:93,:)=0;
GG_MID_B4_YEJIN(:,:)=(GG(:,:)-GG_MID_B4_WSJ(:,:)-GG_MID_B4_TCLY(:,:)).*(HSCSQJ(1+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:)));
GG_MID_B4_XUNHUAN(:,:)=(GG(:,:)-GG_MID_B4_WSJ(:,:)-GG_MID_B4_TCLY(:,:)).*(HSCSQJ(3+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:))).*0.95;
%MID_B5
A=4.*8;
GG_MID_B5_WSJ(1:31,:)=GG(1:31,:).*HSCSQJ(4+A,:);
GG_MID_B5_WSJ(32:62,:)=GG(32:62,:).*HSCSQJ(4+A,:);
GG_MID_B5_WSJ(63:93,:)=GG(63:93,:).*HSCSQJ(4+A,:);
GG_MID_B5_TCLY(32:62,:)=(GG(1:31,:)+GG(32:62,:)+GG(63:93,:)).*HSCSQJ(2+A,:);
GG_MID_B5_TCLY(1:31,:)=0;
GG_MID_B5_TCLY(63:93,:)=0;
GG_MID_B5_YEJIN(:,:)=(GG(:,:)-GG_MID_B5_WSJ(:,:)-GG_MID_B5_TCLY(:,:)).*(HSCSQJ(1+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:)));
GG_MID_B5_XUNHUAN(:,:)=(GG(:,:)-GG_MID_B5_WSJ(:,:)-GG_MID_B5_TCLY(:,:)).*(HSCSQJ(3+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:))).*0.95;
%HIG_B2
A=4.*9;
GG_HIG_B2_WSJ(1:31,:)=GG(1:31,:).*HSCSQJ(4+A,:);
GG_HIG_B2_WSJ(32:62,:)=GG(32:62,:).*HSCSQJ(4+A,:);
GG_HIG_B2_WSJ(63:93,:)=GG(63:93,:).*HSCSQJ(4+A,:);
GG_HIG_B2_TCLY(32:62,:)=(GG(1:31,:)+GG(32:62,:)+GG(63:93,:)).*HSCSQJ(2+A,:);
GG_HIG_B2_TCLY(1:31,:)=0;
GG_HIG_B2_TCLY(63:93,:)=0;
GG_HIG_B2_YEJIN(:,:)=(GG(:,:)-GG_HIG_B2_WSJ(:,:)-GG_HIG_B2_TCLY(:,:)).*(HSCSQJ(1+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:)));
GG_HIG_B2_XUNHUAN(:,:)=(GG(:,:)-GG_HIG_B2_WSJ(:,:)-GG_HIG_B2_TCLY(:,:)).*(HSCSQJ(3+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:))).*0.95;
%HIG_B3
A=4.*10;
GG_HIG_B3_WSJ(1:31,:)=GG(1:31,:).*HSCSQJ(4+A,:);
GG_HIG_B3_WSJ(32:62,:)=GG(32:62,:).*HSCSQJ(4+A,:);
GG_HIG_B3_WSJ(63:93,:)=GG(63:93,:).*HSCSQJ(4+A,:);
GG_HIG_B3_TCLY(32:62,:)=(GG(1:31,:)+GG(32:62,:)+GG(63:93,:)).*HSCSQJ(2+A,:);
GG_HIG_B3_TCLY(1:31,:)=0;
GG_HIG_B3_TCLY(63:93,:)=0;
GG_HIG_B3_YEJIN(:,:)=(GG(:,:)-GG_HIG_B3_WSJ(:,:)-GG_HIG_B3_TCLY(:,:)).*(HSCSQJ(1+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:)));
GG_HIG_B3_XUNHUAN(:,:)=(GG(:,:)-GG_HIG_B3_WSJ(:,:)-GG_HIG_B3_TCLY(:,:)).*(HSCSQJ(3+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:))).*0.95;
%HIG_B4
A=4.*11;
GG_HIG_B4_WSJ(1:31,:)=GG(1:31,:).*HSCSQJ(4+A,:);
GG_HIG_B4_WSJ(32:62,:)=GG(32:62,:).*HSCSQJ(4+A,:);
GG_HIG_B4_WSJ(63:93,:)=GG(63:93,:).*HSCSQJ(4+A,:);
GG_HIG_B4_TCLY(32:62,:)=(GG(1:31,:)+GG(32:62,:)+GG(63:93,:)).*HSCSQJ(2+A,:);
GG_HIG_B4_TCLY(1:31,:)=0;
GG_HIG_B4_TCLY(63:93,:)=0;
GG_HIG_B4_YEJIN(:,:)=(GG(:,:)-GG_HIG_B4_WSJ(:,:)-GG_HIG_B4_TCLY(:,:)).*(HSCSQJ(1+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:)));
GG_HIG_B4_XUNHUAN(:,:)=(GG(:,:)-GG_HIG_B4_WSJ(:,:)-GG_HIG_B4_TCLY(:,:)).*(HSCSQJ(3+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:))).*0.95;
%HIG_B5
A=4.*12;
GG_HIG_B5_WSJ(1:31,:)=GG(1:31,:).*HSCSQJ(4+A,:);
GG_HIG_B5_WSJ(32:62,:)=GG(32:62,:).*HSCSQJ(4+A,:);
GG_HIG_B5_WSJ(63:93,:)=GG(63:93,:).*HSCSQJ(4+A,:);
GG_HIG_B5_TCLY(32:62,:)=(GG(1:31,:)+GG(32:62,:)+GG(63:93,:)).*HSCSQJ(2+A,:);
GG_HIG_B5_TCLY(1:31,:)=0;
GG_HIG_B5_TCLY(63:93,:)=0;
GG_HIG_B5_YEJIN(:,:)=(GG(:,:)-GG_HIG_B5_WSJ(:,:)-GG_HIG_B5_TCLY(:,:)).*(HSCSQJ(1+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:)));
GG_HIG_B5_XUNHUAN(:,:)=(GG(:,:)-GG_HIG_B5_WSJ(:,:)-GG_HIG_B5_TCLY(:,:)).*(HSCSQJ(3+A,:)./(HSCSQJ(1+A,:)+HSCSQJ(3+A,:))).*0.95;
XQ_TCLY_CHINA=sum(XQ_TCLY);
GG_TCLY_CHINA(1,:)=sum(GG_BAU_B1_TCLY(:,:));
GG_TCLY_CHINA(2,:)=sum(GG_LOW_B2_TCLY(:,:));
GG_TCLY_CHINA(3,:)=sum(GG_LOW_B3_TCLY(:,:));
GG_TCLY_CHINA(4,:)=sum(GG_LOW_B4_TCLY(:,:));
GG_TCLY_CHINA(5,:)=sum(GG_LOW_B5_TCLY(:,:));
GG_TCLY_CHINA(6,:)=sum(GG_MID_B2_TCLY(:,:));
GG_TCLY_CHINA(7,:)=sum(GG_MID_B3_TCLY(:,:));
GG_TCLY_CHINA(8,:)=sum(GG_MID_B4_TCLY(:,:));
GG_TCLY_CHINA(9,:)=sum(GG_MID_B5_TCLY(:,:));
GG_TCLY_CHINA(10,:)=sum(GG_HIG_B2_TCLY(:,:));
GG_TCLY_CHINA(11,:)=sum(GG_HIG_B3_TCLY(:,:));
GG_TCLY_CHINA(12,:)=sum(GG_HIG_B4_TCLY(:,:));
GG_TCLY_CHINA(13,:)=sum(GG_HIG_B5_TCLY(:,:));
GG_XUNHUAN(1,:)=sum(GG_BAU_B1_XUNHUAN(:,:));
GG_XUNHUAN(2,:)=sum(GG_LOW_B2_XUNHUAN(:,:));
GG_XUNHUAN(3,:)=sum(GG_LOW_B3_XUNHUAN(:,:));
GG_XUNHUAN(4,:)=sum(GG_LOW_B4_XUNHUAN(:,:));
GG_XUNHUAN(5,:)=sum(GG_LOW_B5_XUNHUAN(:,:));
GG_XUNHUAN(6,:)=sum(GG_MID_B2_XUNHUAN(:,:));
GG_XUNHUAN(7,:)=sum(GG_MID_B3_XUNHUAN(:,:));
GG_XUNHUAN(8,:)=sum(GG_MID_B4_XUNHUAN(:,:));
GG_XUNHUAN(9,:)=sum(GG_MID_B5_XUNHUAN(:,:));
GG_XUNHUAN(10,:)=sum(GG_HIG_B2_XUNHUAN(:,:));
GG_XUNHUAN(11,:)=sum(GG_HIG_B3_XUNHUAN(:,:));
GG_XUNHUAN(12,:)=sum(GG_HIG_B4_XUNHUAN(:,:));
GG_XUNHUAN(13,:)=sum(GG_HIG_B5_XUNHUAN(:,:));
%%%%% Disposal system module %%%%%%
% Uncollected
fakuan=4;
Cost_fakuan=[6772050, 8000400].*fakuan;%CNY/GWh
r=0.02;% to 2020
cpfc=0.7;
for j=1:31
Cost_step1_SYL(1:31,j)=Cost_fakuan(1,1)./((1+r)^(j-1));
Cost_step1_LSTL(1:31,j)=Cost_fakuan(1,2)./((1+r)^(j-1));
end
CF_step1_SYL=zeros(31,31);
CF_step1_LSTL=zeros(31,31);
% Collection
YSJL_shengnei=csvread('shengneiyunju.csv');
Cost_shouji=[64766250,50669200];
Cost_yunshu=[1499.85,2200.11];
Cost_yunshu(1)=Cost_yunshu(1).*2+200./4545;
Cost_yunshu(2)=Cost_yunshu(2).*2+200./6667;
CF_shouji=csvread('CO2yunshu.csv').*2;
for j=1:31
Cost_step2_SYL(1:31,j)=Cost_shouji(1,1)./((1+r)^(j-1))+Cost_yunshu(1,1).*YSJL_shengnei(1:31,1)./((1+r)^(j-1));
Cost_step2_LSTL(1:31,j)=Cost_shouji(1,2)./((1+r)^(j-1))+Cost_yunshu(1,2).*YSJL_shengnei(1:31,1)./((1+r)^(j-1));
CF_step2_SYL(1:31,j)=CF_shouji(1:31,1)./1000.*4545.*YSJL_shengnei(1:31,1);
CF_step2_LSTL(1:31,j)=CF_shouji(1:31,1)./1000.*6667.*YSJL_shengnei(1:31,1);
end
pfjdxs=[1	0.998773006	0.997546012	0.996319018	0.995092025	0.993865031	0.977283805	0.96070258	0.944121355	0.927540129	0.910958904	0.893846488	0.876734073	0.859621657	0.842509241	0.825396825	0.807890276	0.790383726	0.772877177	0.755370627	0.737864078	0.720357528	0.702850979	0.685344429	0.667837879	0.65033133	0.63282478	0.615318231	0.597811681	0.580305132	0.562798582];
CF_step2_SYL(1:31,:)=CF_step2_SYL(1:31,:).*pfjdxs(1,:);
CF_step2_LSTL(1:31,:)=CF_step2_LSTL(1:31,:).*pfjdxs(1,:);
% inspection and dismantaling
Cost_step3_SYL_GUDING=zeros(31,31)+(180000./50./1500).*4545./((1+r)^(j-1));
Cost_step3_LSTL_GUDING=zeros(31,31)+(180000./50./1500).*6667./((1+r)^(j-1));
Capcity_step3_SYL=1500./4545.*cpfc(1);
Capcity_step3_LSTL=1500./6667.*cpfc(1);
for j=1:31
Cost_step3_SYL_YUNYING(1:31,j)=(1150./((1+r)^(j-1))).*4545;
Cost_step3_LSTL_YUNYING(1:31,j)=(1150./((1+r)^(j-1))).*6667;
end
CF_power=csvread('cfele.csv');
CF_step3_SYL=CF_power.*21.66./1000.*4545;%tCO2/GWh
CF_step3_LSTL=CF_power.*21.68./1000.*6667;%tCO2/GWh
CF_step3_SYL_Infra=zeros(31,31)+1500./2.58.*508.57.*0.001./50;
CF_step3_LSTL_Infra=zeros(31,31)+1500./2.58.*508.57.*0.001./50;
% EOL
% Metallurgical recycling
for j=1:31
    Cost_step4_YEJIN_SYL(1:31,j)=-40450500./((1+r)^(j-1))+Cost_fakuan(1,1)./((1+r)^(j-1))./fakuan;
    Cost_step4_YEJIN_LSTL(1:31,j)=-26668000./((1+r)^(j-1))+Cost_fakuan(1,2)./((1+r)^(j-1))./fakuan;
end
CF_step4_YEJIN_SYL=CF_power.*500./1000.*4545-37431+2604;
CF_step4_YEJIN_LSTL=CF_power.*500./1000.*6667-31299+3250;
 % Secondary use
Cost_step4_ECLY_LSTL_GUDING=zeros(31,31)+(1500000./50./2000).*6667./((1+r)^(j-1));
Capcity_step4_ECLY_LSTL=2000./6667.*cpfc(1);
for j=1:31
Cost_step4_ECLY_LSTL_YUNYING(1:31,j)=(5900./((1+r)^(j-1))).*6667;
end 
New_chuneng=[1549.04,1470.22,1391.40,1312.58,1233.76,1154.95,1076.13,997.31,918.49,839.67,760.85,742.17,723.49,704.81,686.13,667.45,648.77,630.09,611.42,592.74,574.06,555.38,536.70,518.02,499.34,480.66,461.98,443.30,424.62,405.94,387.26];
Cost_step4_ECLY_NEW=zeros(31,31)+New_chuneng.*10^6./((1+r)^(j-1));
CF_step4_ECLY_NEW=zeros(31,31)+140.264*1000;
CF_step4_ECLY_LSTL=CF_power.*165.57./1000.*6667;
CF_step4_ECLY_LSTL_Infra=zeros(31,31)+2000./2.38.*508.57.*0.001./50;%t CO2 per plant
 % Direct recycling
Cost_step4_ZJHS_SYL_GUDING=zeros(31,31)+(1800000./50./2500).*4545./((1+r)^(j-1));
Capcity_step4_ZJHS_SYL=2500./4545.*cpfc(1);
Cost_step4_ZJHS_LSTL_GUDING=zeros(31,31)+(1800000./50./2500).*6667./((1+r)^(j-1));
Capcity_step4_ZJHS_LSTL=2500./6667.*cpfc(1);
for j=1:31
Cost_step4_ZJHS_SYL_YUNYING(1:31,j)=(12600./((1+r)^(j-1))).*4545+Cost_fakuan(1,1)./((1+r)^(j-1))./fakuan;
Cost_step4_ZJHS_LSTL_YUNYING(1:31,j)=(12600./((1+r)^(j-1))).*6667+Cost_fakuan(1,1)./((1+r)^(j-1))./fakuan;
end
New_carbat=[777.78 	748.89 	720.00 	691.11 	662.22 	633.33 	604.44 	575.56 	546.67 	517.78 	488.89 	474.44 	460.00 	445.56 	431.11 	416.67 	402.22 	387.78 	373.33 	358.89 	344.44 	330.00 	315.56 	301.11 	286.67 	272.22 	257.78 	243.33 	228.89 	214.44 	200.00];
Cost_step4_ZJHS_NEW=zeros(31,31)+New_carbat.*10^6./((1+r)^(j-1));
CF_step4_ZJHS_NEW_SYL=zeros(31,31)+180*1000;
CF_step4_ZJHS_NEW_LSTL=zeros(31,31)+140.264*1000;
CF_step4_ZJHS_LSTL=CF_power.*187.43./1000.*6667-26403+2604;
CF_step4_ZJHS_SYL=CF_power.*187.25./1000.*4545-34072+2604;
CF_step4_ZJHS_SYL_Infra=zeros(31,31)+2500./1.25.*508.57.*0.001./50;
CF_step4_ZJHS_LSTL_Infra=zeros(31,31)+2500./1.25.*508.57.*0.001./50;
% interprovince transport
shengjianyunju=csvread('SHENGJIYUNSHU.csv');
for i=1:31
    for j=1:31
        for k=1:31
            for h=1:31
        if shengjianyunju(i+1,1)==k && shengjianyunju(1,j+1)==h
YSJL_shengjian(k,h)=shengjianyunju(i+1,j+1);
        else
        end
        end
    end
    end
end
for i=1:31
    for j=1:31
        if i==j
    YSJL_shengjian(i,j)=9999999999999;% avoid province a to a
        else
        end
    end
end
%%%%%%% Run MonteCarlo %%%%%%
Cost_total=zeros(13,31);
CO2_total=zeros(13,31);
WSJL=zeros(31,31);
WSJL(:,1)=0.75;
CNL=zeros(31,31);
XHL=zeros(31,31);
YH_result_CO2=zeros(1,kkk);
YH_result_COST=zeros(1,kkk);
YH_WSJL=zeros(31,kkk);
YH_CNL=zeros(31,kkk);
YH_XHL=zeros(31,kkk);
YH_sudu=zeros(31,kkk);
YSQJCS=csvread('QINGJINGCANSHU.csv');
for j=1:21
WSJL_SUDU(1,j)=(0.75-YSQJCS(8,j))./(0.75-YSQJCS(8,21));
WSJL_SUDU(2,j)=(0.75-YSQJCS(24,j))./(0.75-YSQJCS(24,21));
WSJL_SUDU(3,j)=(0.75-YSQJCS(40,j))./(0.75-YSQJCS(40,21));
end
for n=1:kkk
    mu_WSJL=randi([5,75],1)/100;
    mu_CNL=randi([0,85],1)/100;
    mu_XHL=randi([0,85],1)/100;
if mu_CNL + mu_XHL > 0.85
    scale = 0.85 / (mu_CNL + mu_XHL);
    mu_CNL = mu_CNL * scale;
    mu_XHL = mu_XHL * scale;
end
    bd1=randi([0,5],1)./100;
    bd2=randi([0,20],1)./100;
for i=1:31
        WSJL_sheng(i,1)=mu_WSJL*(1 + bd1.*randn);
        CNL_sheng(i,1)=mu_CNL*(1 + bd2.*randn);
        XHL_sheng(i,1)=mu_XHL*(1 + bd2.*randn);
        sudu(:,1)=randi([1,3],1);
end
for i=1:31
if WSJL_sheng(i,1)<0.05
    WSJL_sheng(i,1)=0.05;
elseif WSJL_sheng(i,1)>0.75
    WSJL_sheng(i,1)=0.75;
    else
end
if CNL_sheng(i,1)+XHL_sheng(i,1)>0.85
    scale2 = 0.85 / (CNL_sheng(i,1) + XHL_sheng(i,1));    
    CNL_sheng(i,1) = CNL_sheng(i,1) * scale2;
    XHL_sheng(i,1) = XHL_sheng(i,1) * scale2;
else
end
end
WSJL_nian(:,1)=(WSJL_sheng(:,1)-0.75)./20;
CNL_nian(:,1)=CNL_sheng(:,1)./30;
XHL_nian(:,1)=XHL_sheng(:,1)./30;
for j=1:21 %2020 to 2040
WSJL(:,j)=0.75-(0.75-WSJL_sheng(:,1)).*WSJL_SUDU(sudu,j);
end
for j=22:31
WSJL(:,j)=WSJL_sheng(:,1);
end
for j=1:31 %2020 to 2050
CNL(:,j)=CNL_nian(:,1).*(j-1);
XHL(:,j)=XHL_nian(:,1).*(j-1);
end
WSJLT=WSJL;
CNLT=(1-WSJLT).*CNL;
XHLT=(1-WSJLT).*XHL;
YJLT=(1-WSJLT).*(1-CNL-XHL);
YH_WSJL(:,n)=WSJL_sheng(:,1);
YH_CNL(:,n)=CNL_sheng(:,1);
YH_XHL(:,n)=XHL_sheng(:,1);
YH_sudu(:,n)=sudu;
Yunshuliang_SYL_2035=zeros(31,31);%transport
Yunshuliang_LSTL_2035_CN=zeros(31,31);
Yunshuliang_LSTL_2035_XH=zeros(31,31);
Yunshuliang_SYL_2050=zeros(31,31);
Yunshuliang_LSTL_2050_CN=zeros(31,31);
Yunshuliang_LSTL_2050_XH=zeros(31,31);
GG_YH_WSJ(1:31,:)=GG(1:31,:).*WSJLT(1:31,:);
GG_YH_WSJ(32:62,:)=GG(32:62,:).*WSJLT(1:31,:);
GG_YH_WSJ(63:93,:)=GG(63:93,:).*WSJLT(1:31,:);
GG_YH_CN(32:62,:)=(GG(1:31,:)+GG(32:62,:)+GG(63:93,:)).*CNLT(1:31,:);
GG_YH_CN(63:93,:)=0;
GG_YH_CN(1:31,:)=0;
GG_YH_XH(1:31,:)=GG(1:31,:).*XHLT(1:31,:);
GG_YH_XH(32:62,:)=GG(32:62,:).*XHLT(1:31,:);
GG_YH_XH(63:93,:)=GG(63:93,:).*XHLT(1:31,:);    
GG_YH_YJ(1:31,:)=GG(1:31,:).*YJLT(1:31,:);
GG_YH_YJ(32:62,:)=GG(32:62,:).*YJLT(1:31,:);
GG_YH_YJ(63:93,:)=GG(63:93,:).*YJLT(1:31,:);
%Waste
Cost_step1_total(1:31,:)=(GG_YH_WSJ(1:31,:)+GG_YH_WSJ(63:93,:)).*Cost_step1_SYL(1:31,:)+GG_YH_WSJ(32:62,:).*Cost_step1_LSTL(1:31,:);
CO2_step1_total(1:31,1:31)=0;       
%Collect
GG_YH_SJ=GG-GG_YH_WSJ;
Cost_step2_total(1:31,:)=(GG_YH_SJ(1:31,:)+GG_YH_SJ(63:93,:)).*Cost_step2_SYL(1:31,:)+GG_YH_SJ(32:62,:).*Cost_step2_LSTL(1:31,:);
CO2_step2_total(1:31,:)=(GG_YH_SJ(1:31,:)+GG_YH_SJ(63:93,:)).*CF_step2_SYL(1:31,:)+GG_YH_SJ(32:62,:).*CF_step2_LSTL(1:31,:);
%Inspection and dismantling
Cost_step3_total(1:31,:)=(GG_YH_SJ(1:31,:)+GG_YH_SJ(63:93,:)).*Cost_step3_SYL_YUNYING(1:31,:)+GG_YH_SJ(32:62,:).*Cost_step3_LSTL_YUNYING(1:31,:);%元
Cost_step3_total(1:31,:)=Cost_step3_total(1:31,:)+ceil((GG_YH_SJ(1:31,:)+GG_YH_SJ(63:93,:))./Capcity_step3_SYL).*Cost_step3_SYL_GUDING+ceil(GG_YH_SJ(32:62)./Capcity_step3_LSTL).*Cost_step3_LSTL_GUDING;
CO2_step3_total(1:31,:)=(GG_YH_SJ(1:31,:)+GG_YH_SJ(63:93,:)).*CF_step3_SYL(1:31,:)+GG_YH_SJ(32:62,:).*CF_step3_LSTL(1:31,:)+ceil((GG_YH_SJ(1:31,:)+GG_YH_SJ(63:93,:))./Capcity_step3_SYL).*CF_step3_SYL_Infra+ceil(GG_YH_SJ(32:62)./Capcity_step3_LSTL).*CF_step3_LSTL_Infra;
%TRANSPORT
GAP_CN(1:31,:)=GG_YH_CN(32:62,:)-XQ_TCLY(32:62,:);
    GAP_panduan=zeros(31,31);
    for i=1:31
    for j=1:31
    if GAP_CN(i,j)>=0
        GAP_panduan(i,j)=0;
    else
        GAP_panduan(i,j)=1;
    end
    end
    end
    YYJZ=zeros(31,31);
    QQJZ=zeros(31,31);
    for i=1:31
        for j=1:31
        if GAP_panduan(i,j)==0
            YYJZ(i,j)=GAP_CN(i,j);
        else
            QQJZ(i,j)=abs(GAP_CN(i,j));
        end
        end
    end
        Cost_step5_LSTL_CN=zeros(31,31);
        CO2_step5_LSTL_CN=zeros(31,31);
    for j=1:31
        if sum(GAP_panduan(:,j))==32 || sum(GAP_panduan(:,j))==0 
        else
        YY0 = sort(YYJZ(:,j), 'descend');
        kk=0;
        for i=1:31
            if YY0(i,1)>0
                kk=kk+1;
            else
            end
        end
        for yss=1:kk
            for i=1:31
               
            if YYJZ(i,j)==YY0(yss,1)
                YSZX=sort(YSJL_shengjian(i,:));
                    for yspd=1:30
                        for ycsf=1:31 
                            if YSJL_shengjian(i,ycsf)==YSZX(1,yspd)
                                            if  GAP_panduan(ycsf,j)==0 || GAP_panduan(i,j)==1 
                                            elseif YYJZ(i,j)<=0 ||  QQJZ(ycsf,j)<=0
                                            else
                                if QQJZ(ycsf,j)<=YYJZ(i,j) 
                                Cost_step5_LSTL_CN(ycsf,j)=Cost_step5_LSTL_CN(ycsf,j)+QQJZ(ycsf,j).*Cost_yunshu(1,2).*YSJL_shengjian(i,ycsf);
                                CO2_step5_LSTL_CN(ycsf,j)=CO2_step5_LSTL_CN(ycsf,j)+QQJZ(ycsf,j).*CF_shouji(1,2).*YSJL_shengjian(i,ycsf).*pfjdxs(1,j);
                               
                                if j==16
                                Yunshuliang_LSTL_2035_CN(i,ycsf)=Yunshuliang_LSTL_2035_CN(i,ycsf)+QQJZ(ycsf,j);%GWh
                                elseif j==31
                                Yunshuliang_LSTL_2050_CN(i,ycsf)=Yunshuliang_LSTL_2050_CN(i,ycsf)+QQJZ(ycsf,j);%GWh   
                                else    
                                end
                              
                                GG_YH_CN(ycsf+31,j)=GG_YH_CN(ycsf+31,j)+QQJZ(ycsf,j);
                                GG_YH_CN(i+31,j)=GG_YH_CN(i+31,j)-QQJZ(ycsf,j);
                                YYJZ(i,j)=YYJZ(i,j)-QQJZ(ycsf,j);
                                QQJZ(ycsf,j)=0;
                                else
                                if YYJZ(i,j)<=0
                                else
                                if j==16
                                Yunshuliang_LSTL_2035_CN(i,ycsf)=Yunshuliang_LSTL_2035_CN(i,ycsf)+YYJZ(ycsf,j);%GWh
                                elseif j==31
                                Yunshuliang_LSTL_2050_CN(i,ycsf)=Yunshuliang_LSTL_2050_CN(i,ycsf)+YYJZ(ycsf,j);%GWh   
                                else    
                                end         
                                Cost_step5_LSTL_CN(ycsf,j)=Cost_step5_LSTL_CN(ycsf,j)+YYJZ(i,j).*Cost_yunshu(1,2).*YSJL_shengjian(i,ycsf);
                                CO2_step5_LSTL_CN(ycsf,j)=CO2_step5_LSTL_CN(ycsf,j)+YYJZ(i,j).*CF_shouji(1,2).*YSJL_shengjian(i,ycsf).*pfjdxs(1,j);
                                GG_YH_CN(ycsf+31,j)=GG_YH_CN(ycsf+31,j)+YYJZ(i,j);
                                GG_YH_CN(i+31,j)=GG_YH_CN(i+31,j)-YYJZ(i,j);
                                QQJZ(ycsf,j)=QQJZ(ycsf,j)-YYJZ(i,j);
                                YYJZ(i,j)=0;
                                    end
                                end
                                            end
                            else
                            end
                        end
                    end
                
            else
            end            
            end
        end
     end
    end
        GAP_XH_SYL(1:31,:)=GG_YH_XH(1:31,:)-XQ_XH3B(1:31,:);   
    GAP_XH_LSTL(1:31,:)=GG_YH_XH(32:62,:)-XQ_XH3B(32:62,:);
    GAP_panduan1=zeros(31,31);
    GAP_panduan2=zeros(31,31);   
    for i=1:31
    for j=1:31
    if GAP_XH_SYL(i,j)>=0
        GAP_panduan1(i,j)=0;
    else
        GAP_panduan1(i,j)=1;
    end
    end
    end
    for i=1:31
    for j=1:31
    if GAP_XH_LSTL(i,j)>=0
        GAP_panduan2(i,j)=0;
    else
        GAP_panduan2(i,j)=1;
    end
    end
    end
    YYJZ1=zeros(31,31);
    YYJZ2=zeros(31,31);
    QQJZ1=zeros(31,31);
    QQJZ2=zeros(31,31);
    for i=1:31
        for j=1:31
        if GAP_panduan1(i,j)==0
            YYJZ1(i,j)=GAP_XH_SYL(i,j);           
        else
            QQJZ1(i,j)=abs(GAP_XH_SYL(i,j));        
        end
        end
    end
        for i=1:31
        for j=1:31
        if GAP_panduan2(i,j)==0
YYJZ2(i,j)=GAP_XH_LSTL(i,j);
        else
QQJZ2(i,j)=abs(GAP_XH_LSTL(i,j));
        end
        end
    end
        Cost_step5_LSTL_XH=zeros(31,31);
        CO2_step5_LSTL_XH=zeros(31,31);
        Cost_step5_SYL_XH=zeros(31,31);
        CO2_step5_SYL_XH=zeros(31,31);        
    for j=1:31
        if sum(GAP_panduan1(:,j))==32 || sum(GAP_panduan1(:,j))==0 
        else
        YY1 = sort(YYJZ1(:,j), 'descend');
        kk=0;
        %计数
        for i=1:31
            if YY1(i,1)>0
                kk=kk+1;
            else
            end
        end
        for yss=1:kk
            for i=1:31
               
            if YYJZ1(i,j)==YY1(yss,1)
                YSZX1=sort(YSJL_shengjian(i,:));
                    for yspd=1:30
                        for ycsf=1:31 
                            if YSJL_shengjian(i,ycsf)==YSZX1(1,yspd)
                                            if  GAP_panduan1(ycsf,j)==0 || GAP_panduan1(i,j)==1 
                                            elseif YYJZ1(i,j)<=0 ||  QQJZ1(ycsf,j)<=0
                                            else
                                if QQJZ1(ycsf,j)<=YYJZ1(i,j) 
                                Cost_step5_SYL_XH(ycsf,j)=Cost_step5_SYL_XH(ycsf,j)+QQJZ1(ycsf,j).*Cost_yunshu(1,2).*YSJL_shengjian(i,ycsf);
                                CO2_step5_SYL_XH(ycsf,j)=CO2_step5_SYL_XH(ycsf,j)+QQJZ1(ycsf,j).*CF_shouji(1,2).*YSJL_shengjian(i,ycsf).*pfjdxs(1,j);
                                if j==16
                                Yunshuliang_SYL_2035(i,ycsf)=Yunshuliang_SYL_2035(i,ycsf)+QQJZ1(ycsf,j);%GWh
                                elseif j==31
                                Yunshuliang_SYL_2050(i,ycsf)=Yunshuliang_SYL_2050(i,ycsf)+QQJZ1(ycsf,j);%GWh   
                                else    
                                end

                                GG_YH_XH(ycsf,j)=GG_YH_XH(ycsf,j)+QQJZ1(ycsf,j);
                                GG_YH_XH(i,j)=GG_YH_XH(i,j)-QQJZ1(ycsf,j);
                                YYJZ1(i,j)=YYJZ1(i,j)-QQJZ1(ycsf,j);
                                QQJZ1(ycsf,j)=0;
                                else
                                    if YYJZ1(i,j)<=0
                                    else
                                if j==16
                                Yunshuliang_SYL_2035(i,ycsf)=Yunshuliang_SYL_2035(i,ycsf)+YYJZ1(ycsf,j);%GWh
                                elseif j==31
                                Yunshuliang_SYL_2050(i,ycsf)=Yunshuliang_SYL_2050(i,ycsf)+YYJZ1(ycsf,j);%GWh   
                                else    
                                end        
                                Cost_step5_SYL_XH(ycsf,j)=Cost_step5_SYL_XH(ycsf,j)+YYJZ1(i,j).*Cost_yunshu(1,2).*YSJL_shengjian(i,ycsf);
                                CO2_step5_SYL_XH(ycsf,j)=CO2_step5_SYL_XH(ycsf,j)+YYJZ1(i,j).*CF_shouji(1,2).*YSJL_shengjian(i,ycsf).*pfjdxs(1,j);
                                GG_YH_XH(ycsf,j)=GG_YH_XH(ycsf,j)+YYJZ1(i,j);
                                GG_YH_XH(i,j)=GG_YH_XH(i,j)-YYJZ1(i,j);
                                QQJZ1(ycsf,j)=QQJZ1(ycsf,j)-YYJZ1(i,j);
                                YYJZ1(i,j)=0;
                                    end
                                end
                                            end
                            else
                            end
                        end
                    end
                
            else
            end            
            end
        end
     end
    end    
     for j=1:31
        if sum(GAP_panduan2(:,j))==32 || sum(GAP_panduan2(:,j))==0 
        else
        YY2 = sort(YYJZ2(:,j), 'descend');
        kk=0;
        for i=1:31
            if YY2(i,1)>0
                kk=kk+1;
            else
            end
        end
         for yss=1:kk
            for i=1:31
               
            if YYJZ2(i,j)==YY2(yss,1)
                YSZX2=sort(YSJL_shengjian(i,:));
                    for yspd=1:30
                        for ycsf=1:31 
                            if YSJL_shengjian(i,ycsf)==YSZX2(1,yspd)
                                            if  GAP_panduan2(ycsf,j)==0 || GAP_panduan2(i,j)==1 
                                            elseif YYJZ2(i,j)<=0 ||  QQJZ2(ycsf,j)<=0
                                            else
                                if QQJZ2(ycsf,j)<=YYJZ2(i,j) 
                                Cost_step5_LSTL_XH(ycsf,j)=Cost_step5_LSTL_XH(ycsf,j)+QQJZ2(ycsf,j).*Cost_yunshu(1,2).*YSJL_shengjian(i,ycsf);
                                CO2_step5_LSTL_XH(ycsf,j)=CO2_step5_LSTL_XH(ycsf,j)+QQJZ2(ycsf,j).*CF_shouji(1,2).*YSJL_shengjian(i,ycsf).*pfjdxs(1,j);
                                if j==16
                                Yunshuliang_LSTL_2035_XH(i,ycsf)=Yunshuliang_LSTL_2035_XH(i,ycsf)+QQJZ2(ycsf,j);%GWh
                                elseif j==31
                                Yunshuliang_LSTL_2050_XH(i,ycsf)=Yunshuliang_LSTL_2050_XH(i,ycsf)+QQJZ2(ycsf,j);%GWh   
                                else    
                                end

                                GG_YH_XH(ycsf+31,j)=GG_YH_XH(ycsf+31,j)+QQJZ2(ycsf,j);
                                GG_YH_XH(i+31,j)=GG_YH_XH(i+31,j)-QQJZ2(ycsf,j);
                                YYJZ2(i,j)=YYJZ2(i,j)-QQJZ2(ycsf,j);
                                QQJZ2(ycsf,j)=0;
                                else
                                    if YYJZ2(i,j)<=0
                                    else
                                if j==16
                                Yunshuliang_LSTL_2035_XH(i,ycsf)=Yunshuliang_LSTL_2035_XH(i,ycsf)+YYJZ2(ycsf,j);%GWh
                                elseif j==31
                                Yunshuliang_LSTL_2050_XH(i,ycsf)=Yunshuliang_LSTL_2050_XH(i,ycsf)+YYJZ2(ycsf,j);%GWh   
                                else    
                                end        
                                Cost_step5_LSTL_XH(ycsf,j)=Cost_step5_LSTL_XH(ycsf,j)+YYJZ2(i,j).*Cost_yunshu(1,2).*YSJL_shengjian(i,ycsf);
                                CO2_step5_LSTL_XH(ycsf,j)=CO2_step5_LSTL_XH(ycsf,j)+YYJZ2(i,j).*CF_shouji(1,2).*YSJL_shengjian(i,ycsf).*pfjdxs(1,j);
                                GG_YH_XH(ycsf+31,j)=GG_YH_XH(ycsf+31,j)+YYJZ2(i,j);
                                GG_YH_XH(i+31,j)=GG_YH_XH(i+31,j)-YYJZ2(i,j);
                                QQJZ2(ycsf,j)=QQJZ2(ycsf,j)-YYJZ2(i,j);
                                YYJZ2(i,j)=0;
                                    end
                                end
                                            end
                            else
                            end
                        end
                    end
                
            else
            end            
            end
        end
     end
    end 
Cost_step5_total=Cost_step5_LSTL_XH+Cost_step5_SYL_XH+Cost_step5_LSTL_CN;
CO2_step5_total=CO2_step5_LSTL_XH+CO2_step5_SYL_XH+CO2_step5_LSTL_CN;  
% Metallurgical recycling
Cost_step4_total_YEJIN(1:31,:)=(GG_YH_YJ(1:31,:)+GG_YH_YJ(63:93,:)).*Cost_step4_YEJIN_SYL(1:31,:)+GG_YH_YJ(32:62,:).*Cost_step4_YEJIN_LSTL(1:31,:);
CO2_step4_total_YEJIN(1:31,:)=(GG_YH_YJ(1:31,:)+GG_YH_YJ(63:93,:)).*CF_step4_YEJIN_SYL(1:31,:)+GG_YH_YJ(32:62,:).*CF_step4_YEJIN_LSTL(1:31,:);
% Secondary use
        Cost_step4_total_CHUNENG=zeros(31:31);
        CO2_step4_total_CHUNENG=zeros(31:31);
    for i=1:31
        for j=1:31
     if XQ_TCLY(i+31,j)-GG_YH_CN(i+31,j)<0
    Cost_step4_total_CHUNENG(i,j)=XQ_TCLY(i+31,j).*Cost_step4_ECLY_LSTL_YUNYING(i,j)+ceil(XQ_TCLY(i+31,j)./Capcity_step4_ECLY_LSTL(1,1)).*Cost_step4_ECLY_LSTL_GUDING(i,j);
    CO2_step4_total_CHUNENG(i,j)=XQ_TCLY(i+31,j).*CF_step4_ECLY_LSTL(i,j)+ceil(XQ_TCLY(i+31,j)./Capcity_step4_ECLY_LSTL(1,1)).*CF_step4_ECLY_LSTL_Infra(i,j);
    Cost_step4_total_CHUNENG(i,j)=Cost_step4_total_CHUNENG(i,j)+(GG_YH_CN(i+31,j)-XQ_TCLY(i+31,j)).*0.5.*(Cost_step4_YEJIN_LSTL(i,j));
    CO2_step4_total_CHUNENG(i,j)= CO2_step4_total_CHUNENG(i,j)+(GG_YH_CN(i+31,j)-XQ_TCLY(i+31,j)).*0.5.*CF_step4_YEJIN_LSTL(i,j);  
    if j<=25 
    Cost_step4_total_CHUNENG(i,j+6)=Cost_step4_total_CHUNENG(i,j+6)+XQ_TCLY(i+31,j).*0.5.*(Cost_step4_YEJIN_LSTL(i,j+6));
    CO2_step4_total_CHUNENG(i,j+6)= CO2_step4_total_CHUNENG(i,j+6)+XQ_TCLY(i+31,j).*0.5.*CF_step4_YEJIN_LSTL(i,j+6);
    else
    end         
     else
    Cost_step4_total_CHUNENG(i,j)=GG_YH_CN(i+31,j).*Cost_step4_ECLY_LSTL_YUNYING(i,j)+ceil(GG_YH_CN(i+31,j)./Capcity_step4_ECLY_LSTL(1,1)).*Cost_step4_ECLY_LSTL_GUDING(i,j)+(XQ_TCLY(i+31,j)-GG_YH_CN(i+31,j)).*Cost_step4_ECLY_NEW(i,j);
    CO2_step4_total_CHUNENG(i,j)=GG_YH_CN(i+31,j).*CF_step4_ECLY_LSTL(i,j)+(XQ_TCLY(i+31,j)-GG_YH_CN(i+31,j)).*CF_step4_ECLY_NEW(i,j)+ceil(GG_YH_CN(i+31,j)./Capcity_step4_ECLY_LSTL(1,1)).*CF_step4_ECLY_LSTL_Infra(i,j);
    if j<=25 
    Cost_step4_total_CHUNENG(i,j+6)=Cost_step4_total_CHUNENG(i,j+6)+GG_YH_CN(i+31,j).*0.5.*(Cost_step4_YEJIN_LSTL(i,j+6));
    CO2_step4_total_CHUNENG(i,j+6)= CO2_step4_total_CHUNENG(i,j+6)+GG_YH_CN(i+31,j).*0.5.*CF_step4_YEJIN_LSTL(i,j+6);
    else
    end
     end
        end   
    end   
% Direct recycling
Cost_step4_total_XUNHUAN(1:31,:)=(GG_YH_XH(1:31,:)+GG_YH_XH(63:93,:)).*Cost_step4_ZJHS_SYL_YUNYING(1:31,:)+GG_YH_XH(32:62,:).*Cost_step4_ZJHS_LSTL_YUNYING(1:31,:)+ceil((GG_YH_XH(1:31,:)+GG_YH_XH(63:93,:))./Capcity_step4_ZJHS_SYL(1,1)).*Cost_step4_ZJHS_SYL_GUDING(1:31,:)+ceil((GG_YH_XH(32:62,:))./Capcity_step4_ZJHS_LSTL(1,1)).*Cost_step4_ZJHS_LSTL_GUDING(1:31,:)+(XQ_XH3B(1:31,:)+XQ_XH3B(63:93,:)-0.95.*GG_YH_XH(1:31,:)-0.95.*GG_YH_XH(63:93,:)).*Cost_step4_ZJHS_NEW(1:31,:)+(XQ_XH3B(32:62,:)-0.95.*GG_YH_XH(32:62,:)).*Cost_step4_ZJHS_NEW(1:31,:);
CO2_step4_total_XUNHUAN(1:31,:)=(GG_YH_XH(1:31,:)+GG_YH_XH(63:93,:)).*CF_step4_ZJHS_SYL(1:31,:)+GG_YH_XH(32:62,:).*CF_step4_ZJHS_LSTL(1:31,:)+(XQ_XH3B(1:31,:)+XQ_XH3B(63:93,:)-0.95.*GG_YH_XH(1:31,:)-0.95.*GG_YH_XH(63:93,:)).*CF_step4_ZJHS_NEW_SYL(1:31,:)+(XQ_XH3B(32:62,:)-0.95.*GG_YH_XH(32:62,:)).*CF_step4_ZJHS_NEW_LSTL(1:31,:)+ceil((GG_YH_XH(1:31,:)+GG_YH_XH(63:93,:))./Capcity_step4_ZJHS_SYL(1,1)).*CF_step4_ZJHS_SYL_Infra(1:31,:)+ceil((GG_YH_XH(32:62,:))./Capcity_step4_ZJHS_LSTL(1,1)).*CF_step4_ZJHS_LSTL_Infra(1:31,:);
Cost_step4_total=Cost_step4_total_YEJIN+Cost_step4_total_CHUNENG+Cost_step4_total_XUNHUAN;
CO2_step4_total=CO2_step4_total_YEJIN+CO2_step4_total_CHUNENG+CO2_step4_total_XUNHUAN;
Cost_total_province=Cost_step1_total+Cost_step2_total+Cost_step3_total+Cost_step4_total+Cost_step5_total;
CO2_total_province=CO2_step1_total+CO2_step2_total+CO2_step3_total+CO2_step4_total+CO2_step5_total;
YH_result_COST(1,n)=sum(sum(Cost_total_province, 2), 1)./(10^9);%Bcny
YH_result_CO2(1,n)=sum(sum(CO2_total_province, 2), 1)./(10^6);%Mt
end

save UA_capacity_30.mat