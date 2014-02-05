
%%This file reads the climate data aleady imported from NETCDF and
%%calculates the stats of the gamma distribution as well as saving the
%%time series

%choose lon lat of interest and date range with the dates in purple.
clear all

load('/Users/nateme16/Documents/MATLAB/JimOwork/Climate Data 2_4_14/climatedata2_5_14.mat')

lon=1
lat=4

startdate= datenum('01-Jan-1950') - baseyear+1
enddate= datenum('31-Dec-1999') - baseyear+1

startdate2= datenum('01-Jan-1950') - baseyear+1 
enddate2= datenum('31-Dec-1999') - baseyear+1-334


%gets dates right and months
timemod=baseyear+timemod;
timeobs=double(baseyear+timeobs);
timeobs(:,2)=month(timeobs);
timemod(:,2)=month(timemod);


rain=squeeze(rainobs(lon,lat,startdate:enddate))
rainyday=zeros(size(rain));
rainyday(rain>0)=1;


% calculates parameters of process by month
for i=1:12;
    raindaymonth(i)=sum(rainyday(timeobs(:,2)==i));
    daysinmonth(i)=sum(timeobs(:,2)==i);
    variance(i)=var(rain(timeobs(:,2)==i & rainyday==1));
    meanrain(i)=mean(rain(timeobs(:,2)==i & rainyday==1));
    meanraintotal(i)=mean(rain(timeobs(:,2)==i));
    
    rainforprob=rain(timeobs(:,2)==i);
    
    for j=2:size(rainforprob,1);
   ww(j)= (rainforprob(j-1)>0 & rainforprob(j)>0);
   wd(j)= (rainforprob(j-1)==0 & rainforprob(j)>0);
    end
    
    p_ww(i)=sum(ww)/daysinmonth(i);
    p_wd(i)=sum(wd)/daysinmonth(i);
    
end

p_ww= p_ww';
p_wd=  p_wd';
scale=(variance./meanrain)';
shape=((meanrain.^2)./variance)';
meanrain_obs=meanrain';
meanraintotal_obs= meanraintotal';

clear rainyday raindaymonth daysinmonth variance meanrain meanraintotal rainforprob ww wd

for n=1:size(rainmod,4);
    
climatemod= n ;

rain2=squeeze(rainmod(lon,lat,startdate2:enddate2,climatemod));
allmodrain(:,n)=rain2';
rainyday=zeros(size(rain2));
rainyday(rain2>0)=1;

% calculates parameters of process by month

for i=1:12;
    raindaymonth(i)= sum(rainyday(timemod(startdate2:enddate2,2)==i));
    daysinmonth(i)=sum(timemod(startdate2:enddate2,2)==i);
    variance(i)=var(rain2(timemod(startdate2:enddate2,2)==i & rainyday==1));
    meanrain(i)=mean(rain2(timemod(startdate2:enddate2,2)==i & rainyday==1));
    meanraintotal(i)=mean(rain2(timemod(startdate2:enddate2,2)==i));
    
    rainforprob=rain2(timemod(startdate2:enddate2,2)==i);
    
    for j=2:size(rainforprob,1);
   ww(j)= (rainforprob(j-1)>0 & rainforprob(j)>0);
   wd(j)= (rainforprob(j-1)==0 & rainforprob(j)>0);
    end
    
   p_ww_mod(i)=sum(ww)/daysinmonth(i);
    p_wd_mod(i)=sum(wd)/daysinmonth(i);
    
end

p_ww_mods(:,n)= p_ww_mod';
p_wd_mods(:,n)=  p_wd_mod';
scale_mods(:,n)=(variance./meanrain)';
shape_mods(:,n)=((meanrain.^2)./variance)';
meanrain_mods(:,n)=meanrain';
meanraintotal_mod(:,n)= meanraintotal';
end

%save to txt files, 55 of them!

for i=1:size(allmodrain,2);
filename = ['rainpast',num2str(i),'.txt'];
firstline=19500101;
dlmwrite(filename,firstline,'precision',8,'newline','pc');
dlmwrite(filename,allmodrain(:,i),'-append','precision',2,'newline','pc');
end





