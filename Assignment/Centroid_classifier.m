function [ BaDi_groups ] = Centroid_classifier( sensor_HS,sensor_MS,Bands_to_sharpen_HS,Bands_to_sharpen_MS,im_tag )
%SAM_CLASSIFIER Classification of HS imagery based on SAM index
%   Grouping of HS bands to fuse with MS imagery;
%   Input images are:
%   I_PAN: MS images
%   I_MS:  HS images
%   ratio: scale ratio between MS and HS images
%   GNyq: Gain at Nyquist frequency
%   band_overlap_cell: cell of bands of HS overlapping with each MS

if ~strcmp(sensor_MS,'ALI')
    error('This procedure is only available with ALI RSR');
end

Nb_MS=length(Bands_to_sharpen_MS);
Nb=length(Bands_to_sharpen_HS);

if Nb_MS==1
    BaDi_groups={1:Nb};
    return;
end

% Cen_wl_HS=load_spectralresponse_old(Bands_to_sharpen_HS,sensor_HS,im_tag,'HS');
% Cen_wl_MS=load_spectralresponse_old(Bands_to_sharpen_MS,sensor_MS,im_tag,'MS');
Cen_wl_HS=load_spectralresponse(sensor_HS,'HS',im_tag,Bands_to_sharpen_HS);
Cen_wl_MS=load_spectralresponse(sensor_MS,'MS',im_tag,Bands_to_sharpen_MS);

Cen_wl_HS_mat=repmat(Cen_wl_HS,[Nb_MS,1]);
Cen_wl_MS_mat=repmat(reshape(Cen_wl_MS,[Nb_MS,1]),[1,Nb]);
[~,groups]=min(abs(Cen_wl_MS_mat-Cen_wl_HS_mat));

BaDi_groups=cell(1,Nb_MS);
for ii=1:Nb_MS
    BaDi_groups{ii}=find(groups==ii);
end

end

