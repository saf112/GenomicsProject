%% GET ALL CELL DATA
% goal: create a matrix all cells x 56 biomarkers

disp('get all cell data')
clear all
cd ../../Research;

filepath='TMA_Core_Files';
files=dir(filepath);

pat_table=readtable('clinical_data_july2.csv');
temp=pat_table;
pat_table.Properties.RowNames=pat_table.spotname;

DNEcount=0;

epicells=[];
strcells=[];
earea=[];
sarea=[];
for i=1:1:height(pat_table)
    i
    name=char(temp(i,:).spot_name);
    fname=fullfile(filepath,strcat(name,'.mat'));
    if exist(fname)
        load(fname);
    else
        DNEcount=DNEcount+1;
        pat_table(cellstr(name),:)=[];
        continue
    end
    
    bmarkers=cellstr(bm_names);
    cellInds=1:4:length(bmarkers);
    bmarkers(55,:)=[];
    
    epi_area=double(area(find(epithelial==1)));
    str_area=double(area(find(epithelial==2)));
    
    epi_area_mean=mean(epi_area);
    epi_area_std=std(epi_area);
    epi_LB=epi_area_mean-epi_area_std;
    epi_UB=epi_area_mean+epi_area_std;
    
    str_area_mean=mean(str_area);
    str_area_std=std(str_area);
    str_LB=str_area_mean-str_area_std;
    str_UB=str_area_mean+str_area_std;
    
    epi=find(epithelial==1 & area>=epi_LB & area<=epi_UB);
    stromal=find(epithelial==2 & area>=str_LB & area<=str_UB);
    
    epi=randsample(epi,floor(0.01*length(epi)));
    stromal=randsample(stromal,floor(0.01*length(stromal)));
    
    epidat=bm_data(epi,cellInds);
    strdat=bm_data(stromal,cellInds);
    
    epicells=[epicells;epidat];
    strcells=[strcells;strdat];
    
%     earea=[earea, area(epi)];
%     sarea=[sarea, area(stromal)];
end
survival_time=pat_table.survtime_days;

cd ../Genomics_project/mat_files
save('sample_strcells.mat','strcells');
save('sample_epicells.mat','epicells');
save('pat_table.mat','pat_table');
save('survival_time.mat','survival_time');


