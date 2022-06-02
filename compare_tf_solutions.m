%compare_tf_solutions
addpath('./lib/Core_BEC_Analysis/lib/')
set_up_project_path

%% plot the basic cigar approx

omega_tzero=(2*pi)*[50,400,500]';
%omega_tzero=(2*pi)*[500,500,500]';
%omega_tzero=(2*pi)*[1,1,1]';
tmax=1;
z_expansion_scale=1;
[lambda_end,lambda_num_series,lambda_num_fun]=tf_expand_scaling_trap_off_num(omega_tzero,tmax);


%anal_soln=tf_expand_scaling_trap_off_simple_cigar_approx(omega_tzero,lambda_series.time);
%anal_lambda_values=tf_expand_scaling_trap_off_modv1_cigar_approx(omega_tzero,lambda_num_series.time);
%anal_lambda_values=tf_expand_scaling_trap_off_modv2_cigar_approx(omega_tzero,lambda_num_series.time);
anal_lambda_values=tf_expand_scaling_trap_off_modv3_cigar_approx(omega_tzero,lambda_num_series.time);
%anal_lambda_values=tf_expand_scaling_trap_off_modv1_sph_approx(omega_tzero,lambda_num_series.time);
%anal_lambda_values=tf_expand_scaling_trap_off_asm_sph_approx(omega_tzero,lambda_num_series.time);


time_axis_scaling=10^round(log10(1/tmax));

set(0, 'DefaultLineLineWidth', 2);
set(0,'DefaultAxesFontSize', 15);
set(0,'DefaultLegendFontSize',15,'DefaultLegendFontSizeMode','manual')

stfig('soln');
clf
color_orders=[[164,149,61];[149,104,204];[200,96,121]]./255;
colororder(color_orders)
subtract_mat=lambda_num_series.lambda*0;
scale_mat=subtract_mat+1;
subtract_mat(:,3)=1;
scale_mat(:,3)=z_expansion_scale;

num_lambda_values_scaled=(lambda_num_series.lambda-subtract_mat).*scale_mat+subtract_mat;
anal_lambda_values_scaled=anal_lambda_values;
anal_lambda_values_scaled(:,3)=(anal_lambda_values_scaled(:,3)-1)*z_expansion_scale +1;
plot(lambda_num_series.time*time_axis_scaling,num_lambda_values_scaled,'-')
hold on
colororder(color_orders)
plot(lambda_num_series.time*time_axis_scaling,anal_lambda_values_scaled(:,1),'--')
plot(lambda_num_series.time*time_axis_scaling,anal_lambda_values_scaled(:,2),':')
plot(lambda_num_series.time*time_axis_scaling,anal_lambda_values_scaled(:,3),'--')
hold off
if z_expansion_scale==1
    legend('$\lambda_x$','$\lambda_y$','$\lambda_z$','Location','northwest')
else
    legend('$\lambda_x$','$\lambda_y$',sprintf('$(\\lambda_z-1)\\times%g+1$',z_expansion_scale),'Location','northwest')
end
%set(gca,'yscale','log')
if time_axis_scaling==1
    xlabel('Time(s)')
elseif isdouble_integer(log10(time_axis_scaling))
    xlabel(sprintf('Time(s)$\\times10^{%g}$',-log10(time_axis_scaling)))
else
    xlabel(sprintf('Time(s)$\\div%g$',time_axis_scaling))
end
ylabel('$\lambda (t)$ (Scaling Factor)')

stfig('error ratio');
clf
colororder(color_orders)
lambda_err=anal_lambda_values-lambda_num_series.lambda;
frac_lambda_err=frac_diff(anal_lambda_values,lambda_num_series.lambda,'y abs');
fprintf('final fractional mean error %.3e \n',mean(frac_lambda_err(end,:)))
[max_frac_err_value,max_frac_err_pos]=max(abs(frac_lambda_err(:,1)));
fprintf('max abs frac error %g at time %g \n', max_frac_err_value,lambda_num_series.time(max_frac_err_pos))

subplot(2,1,1)
plot(lambda_num_series.time*time_axis_scaling,lambda_err,'-')
xl=xlim;
xlim([time_axis_scaling*tmax/10,xl(2)])
subplot(2,1,2)
plot(lambda_num_series.time*time_axis_scaling,frac_lambda_err,'-')

% plot(lambda_num_series.time*time_axis_scaling,abs(frac_lambda_err),'-')
% set(gca,'yscale','log')

%sprintf('$\\Delta\\lambda\\times%g$',z_expansion_scale)
legend('$\Delta\lambda_x$','$\Delta\lambda_y$','$\Delta\lambda_z$','Location','northwest')

if time_axis_scaling==1
    xlabel('Time(s)')
elseif isdouble_integer(log10(time_axis_scaling))
    xlabel(sprintf('Time(s)$\\times10^{%g}$',-log10(time_axis_scaling)))
else
    xlabel(sprintf('Time(s)$\\div%g$',time_axis_scaling))
end
ylabel('$\Delta\lambda_j(t)/|\lambda^{\mathrm{num}}_j(t)|$ (Scaling Factor Error)')


%%



x0=[0,0,0,0,0,0,0,0];
x0=[2.04934253115289 -0.00195549016893868 -0.499681556609451 3.01148137487483 -0.125072663433433 -3.00114642208208 0.000318792226898637 1.86494744158388e-05];
x0=xopt

%%
eval_model_cost(30,x)
% 
% problem = createOptimProblem('fmincon',...
%     'objective',@(x) eval_model_cost(10,x),...
%     'x0',x0,'options',...
%     optimoptions(@fmincon,'Algorithm','sqp','Display','off'));
% 
% %[x,fval] = fminunc(problem)
% 
% gs = GlobalSearch('Display','iter')
% [x,fval] = run(gs,problem)
%%
options = optimset('Display','iter','PlotFcns',@optimplotfval,'MaxFunEvals',100);
[xopt,fopt]=fminsearch(@(x) eval_model_cost(30,x),x0,options)

%%


PSoptions = optimoptions(@patternsearch,'Display','iter','PlotFcns','psplotbestf','MaxFunEvals',100,'UseParallel',true);
[xopt,fopt] = patternsearch(@(x) eval_model_cost(30,x),x0,[],[],[],[],[],[],PSoptions)



