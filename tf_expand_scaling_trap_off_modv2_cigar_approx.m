function lambda=tf_expand_scaling_trap_off_modv2_cigar_approx(omega_tzero,t)
% do a simple first order expansion

omega_tight=mean(omega_tzero(1:2));
lambda=nan(numel(t),3);

%adjustment parameters
scale_fac_power=1.6250; %26/16


tight_ratio=(omega_tzero/omega_tight);

tight_z_correction=(1 - ( 4/38)*tight_ratio(3)) ;

lambda(:,1)= tight_ratio(1)^scale_fac_power .* ...
               tight_z_correction .* ...
                sqrt( 1 + (omega_tight.*t).^2 );
lambda(:,2)= tight_ratio(2)^scale_fac_power * ...
                tight_z_correction .* ...
                sqrt( 1 + (omega_tight.*t).^2 );
lambda(:,3)= 1+(1-(1/2)*tight_ratio(3))*tight_ratio(3).^2 .* ...
               ( (omega_tight.*t).*atan(omega_tight.*t) -...
                  log(sqrt(1 + (omega_tight.*t).^2)) );

              

end