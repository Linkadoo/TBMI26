load('countrydata.mat')
%%

a = countrydata;

a_mean = sum(a,2)./size(a,2);
a_mean_sub = a - repmat(a_mean,1,size(a,2));

a_std = std(a_mean_sub,0,2);
a_norm = a_mean_sub./repmat(a_std,1,size(a,2));

cov_a = a_norm * a_norm';

var_a = diag(cov_a);
corr_a = cov_a./sqrt(var_a*var_a');

[a_eig_vec, a_eig_val] = sorteig(cov_a)

a_eig_select = a_eig_vec(:,:);

a_two_princ = a_eig_select'*a_norm;

%%
hold on
x_0 = (countryclass==0).*a_two_princ(1,:)';
y_0 = (countryclass==0).*a_two_princ(3,:)';
scatter(x_0,y_0,'r');
x_0 = (countryclass==1).*a_two_princ(1,:)';
y_0 = (countryclass==1).*a_two_princ(3,:)';
scatter(x_0,y_0,'g');
x_0 = (countryclass==2).*a_two_princ(1,:)';
y_0 = (countryclass==2).*a_two_princ(3,:)';
scatter(x_0,y_0,'b');

%%
scatter(a_two_princ(1,42),a_two_princ(3,42),'x')
%%
sum((countryclass'~=1).*a(1,:));

class0_mean = sum(repmat((countryclass'==0),size(a,1),1).*a,2);
class1_mean = sum(repmat((countryclass'==1),size(a,1),1).*a,2);
class2_mean = sum(repmat((countryclass'==2),size(a,1),1).*a,2);
%%
class0_cov = cov((repmat((countryclass'==0),size(a,1),1).*a)');
class1_cov = cov((repmat((countryclass'==1),size(a,1),1).*a)');
class2_cov = cov((repmat((countryclass'==2),size(a,1),1).*a)');

cov_tot = class0_cov + class2_cov;

w = inv(cov_tot)*(class2_mean-class0_mean)

w = w./sum(w.^2)
