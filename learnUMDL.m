function [ Ds,Du,Dr] = learnUMDL( F_MT_train, index_tasks,target_task,M,weight,pars,Dinit)

pars.mFea=size(F_MT_train{1},1);
vars=pars.vars;
gamma=pars.gamma;
alpha=pars.alpha;
beta=pars.beta;
%% intialize %%
if exist('Dinit', 'var') && ~isempty(Dinit)
    Ds=Dinit.Ds;
    Du=Dinit.Du;
    for i=1:length(index_tasks)
         Dr{i}=Dinit.Dr{i};
    end
end

if ~exist('Ds','var')

     B1 = rand(pars.mFea,pars.numbaseS)-0.5;
     B1 = B1 - repmat(mean(B1,1), size(B1,1),1);
     B1 = B1*diag(1./sqrt(sum(B1.*B1)));
     Ds=B1;
end

if ~exist('Du','var')
     B1 = rand(pars.mFea,pars.numbaseS)-0.5;
     B1 = B1 - repmat(mean(B1,1), size(B1,1),1);
     B1 = B1*diag(1./sqrt(sum(B1.*B1)));
     Du=B1;
end

if ~exist('Dr','var')
    for i=1:length(index_tasks)
         Dr{i}=B1;
    end
end


 for i=1:length(index_tasks)
   DCol = full(sum(M{i},2));
   D = spdiags(DCol,0,speye(size(M{i},1)));
   L{i} = D - M{i};
 end

%% Trainning %%
for iter=1:pars.numIters
    %% computer coff %%
    for i=1:length(index_tasks)
        if iter==1
            if i==target_task
               DD=[Ds,Du];
              AA=learn_coefficients_fast(DD,F_MT_train{i},alpha,gamma,L{i});
              As{i}=AA(1:pars.numbaseS,:);
              Au=AA(pars.numbaseS+1:end,:);
              Ar{i}=learn_coefficients_noise(Dr{i},F_MT_train{i}-DD*AA,gamma);
            else
               As{i}=learn_coefficients_fast(Ds,F_MT_train{i},alpha,gamma,L{i});      
               Ar{i}=learn_coefficients_noise(Dr{i},F_MT_train{i}-Ds*As{i},gamma);
            end
        else
            if i==target_task
              DD=[Ds,zeros(size(Ds,1),size(Du,2));Ds,Du;beta*Ds,beta*Du];
              AA=learn_coefficients_fast(DD,[F_MT_train{i};F_MT_train{i};beta*(F_MT_train{i}-Dr{i}*Ar{i})],alpha,gamma,L{i},[As{i};Au]);
              As{i}=AA(1:pars.numbaseS,:);
              Au=AA(pars.numbaseS+1:end,:);
              Ar{i}=learn_coefficients_noise(Dr{i},F_MT_train{i}-Ds*As{i}-Du*Au,gamma); 
            else
              DD=[Ds;beta*Ds];
              As{i}=learn_coefficients_fast(DD,[F_MT_train{i};beta*(F_MT_train{i}-Dr{i}*Ar{i})],alpha,gamma,L{i},As{i});
              Ar{i}=learn_coefficients_noise(Dr{i},F_MT_train{i}-Ds*As{i},gamma);
            end   
            end
       
    end
   %% update Dictionaries
   
    Fall=[];
    Sall=[];
   
    for i=1:length(index_tasks)
        if i~=target_task
        Fall=[Fall,weight(i)*F_MT_train{i},weight(i)*beta*(F_MT_train{i}-Dr{i}*Ar{i})];
        Sall=[Sall,weight(i)*As{i},weight(i)*beta*As{i}];
        else
        Fall=[Fall,F_MT_train{i},F_MT_train{i}-Du*Au,beta*(F_MT_train{i}-Du*Au-Dr{i}*Ar{i})];
        Sall=[Sall,As{i},As{i},beta*As{i}];    
        end
    end
     Ds=learn_basis(Fall,Sall,vars);
     for i=1:length(index_tasks)
         if i~=target_task
             Dr{i}=learn_basis(F_MT_train{i}-Ds*As{i},Ar{i},vars);
         else
             Du=learn_basis([F_MT_train{i}-Ds*As{i},beta*(F_MT_train{i}-Ds*As{i}-Dr{i}*Ar{i})],[Au,beta*Au],vars);
             Dr{i}=learn_basis(F_MT_train{i}-Ds*As{i}-Du*Au,Ar{i},vars);
         end
         
     end
   %%
end

     
       disp('D have been learned.') 



end

