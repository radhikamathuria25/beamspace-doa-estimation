%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implementation of Convolutional Beamspace Processing 
% Reference: P. P. Vaidyanathan and P. -C. Chen, "Convolutional Beamspace for Array Signal Processing," ICASSP 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N              = 96;
% AOA_THETAS_DEG = [-3, 1.5, 3, 40, 60, 80];
AOA_THETAS_DEG = [15, 45];
FILT_ORD       = 25;
M              = 8;
NUM_SNAPSHOTS  = 200;
D              = length(AOA_THETAS_DEG);

for i=1:100
% Generate snapshot 
x = get_snapshot(N, D, AOA_THETAS_DEG, NUM_SNAPSHOTS);

% Write the beamspace manifold
% n    = 0:N-1;
% V    = exp(1j*(n' - (N-1)/2)*pi*cos(rad2deg(AOA_THETAS_DEG)));
% V_bs = V(1:N-FILT_ORD+1,:);

% beamspace snapshot

% Design of LPF using Parks McClellan approach
cutoff = 1/M;
b      = firpm(FILT_ORD,[0 cutoff cutoff*1.1 1], [1 1 0 0]);
% freqz(b,1)

% Step 1: get the stead state output 
y = filter(b,1,x);
y = y(FILT_ORD-1:N-1,:);

% apply ESPRIT to this 
Sx = (1/100)*(y*y');
[eig_vecs,eig_vals] = eig(Sx);

roots = esprit_element_space(eig_vecs, 72, D);
scatter(real(roots),imag(roots))
hold on 
end 
rectangle('Position',[-1,-1,2,2],'Curvature',[1,1],'EdgeColor','r');