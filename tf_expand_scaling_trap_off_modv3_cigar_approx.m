function lambda=tf_expand_scaling_trap_off_modv3_cigar_approx(omega_tzero,t,adj_param)
% do a simple first order expansion

% lets sort so the weakest is the 3rd trap freq
%[omega_tzero,sort_order]=sort(omega_tzero,'ascend')
[omega_tzero,sort_order]=sort(omega_tzero,'descend');

omega_tight=mean(omega_tzero(1:2));
lambda=nan(numel(t),3);



if nargin<3
    %adjustment parameters
    adj_param=[2.04934253115289 -0.00195549016893868 -0.499681556609451 3.01148137487483 -0.125072663433433 -3.00114642208208 0.000318792226898637 1.86494744158388e-05];
end

series_1=[1,adj_param(1),adj_param(2)]; %26/16
series_2=[1,adj_param(3),adj_param(4)];
series_3=[1,adj_param(5),adj_param(6)];
series_4=[1,adj_param(7),adj_param(8)];



tight_ratio=(omega_tzero/omega_tight);

lambda(:,1)=  1+taylor_series(tight_ratio(1),series_2,1).* ...
                (sqrt( 1 + (...
                taylor_series(tight_ratio(1),series_1,1).* ...
                omega_tight.*t).^2 )-1);
lambda(:,2)= 1+ taylor_series(tight_ratio(2),series_2,1).* ...
                ( sqrt( 1 + (...
                taylor_series(tight_ratio(2),series_1,1).* ...
                omega_tight.*t).^2 )-1);
 adjusted_omega_tight_t=taylor_series(tight_ratio(3),series_3,0) *omega_tight.*t;
lambda(:,3)= 1+taylor_series(tight_ratio(3),series_4,0).* ...
                (tight_ratio(3).^2) .*( (adjusted_omega_tight_t).*atan(adjusted_omega_tight_t) -...
                 log(sqrt(1 + (adjusted_omega_tight_t).^2)) );

% then we need to unsort the output
 lambda(:,sort_order)=lambda;           

end