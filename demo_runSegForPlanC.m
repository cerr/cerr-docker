warning('off');

pkg load image
pkg load io
pkg load statistics

addpath(genpath('/content/CERR'));

if ~exist('/scratch/output','dir')
    mkdir('/scratch/output');
end

planCFile = ls('/scratch/*.mat');
planC = loadPlanC(planCFile);

sessionPath = '/scratch';
algorithm = 'CT_Lung_incrMRRN';
condaEnvList = '/miniconda3/envs/hpy35';
wrapperFunctionList = '/software/model_wrapper/run_incMRRN.py';
batchSize = 1;

planC = runSegForPlanCInCondaEnv(planC,sessionPath,algorithm,...
    condaEnvList,wrapperFunctionList,batchSize);

save_planC(planC,[],'PASSED','/scratch/output/planC_out.mat');
