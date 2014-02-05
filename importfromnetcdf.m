clear all

%import observed rainfall

ncdisp('pr18obs.nc')
rainobs=ncread('pr18obs.nc','pr');
timeobs=ncread('pr18obs.nc','time');
lat=ncread('pr18obs.nc','lat');
lon=ncread('pr18obs.nc','lon');

%import modeled rainfall

ncdisp('pr18mod.nc')
rainmod=ncread('pr18mod.nc','pr');
timemod=ncread('pr18mod.nc','time')-.5;
latmod=ncread('pr18mod.nc','latitude')
lonmod=ncread('pr18mod.nc','longitude');

baseyear = datenum('01-Jan-1950');


