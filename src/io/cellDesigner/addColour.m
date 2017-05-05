function [ref,listRxnColour] = addColour(parsed,listRxn_Color,colorScheme)
% Changes colour attributes of the reaction links in a parsed `CellDesigner`
% model structure given a list of reaction IDs
%
% USAGE:
%
%    [ref, listRxnColour] = addColour(parsed, listRxn_Color, colorScheme)
%
% INPUTS:
%    parsed:          A parsed model structure generated by `parseCD` function
%    listRxn_Color:   A list of reaction IDs that need to be highilighted by
%                     changing the colour attributes of the reaciton links in
%                     the `CellDesigner model`. The first column stores a list
%                     of reaction IDs whose reaction links need to be
%                     highlighted, whereas the second column saves a list of
%                     Html Colours.
%
% OUTPUT:
%
%    ref:             An updated parsed CellDesigner model structure
%    listRxnColour:
%
% .. Author: - Longfei Mao October 2014

if nargin<3

    colorScheme=2;

end

ref=parsed;
listRxn=listRxn_Color(:,1); % coloumn 1: reaction IDs;
a=size(listRxn_Color)
if length(a)<2
    listColor=[];
    listColor=listRxn_Color(:,2); % coloumn 2: html colour codes;
    p=1;
else
    p=0;
end


cScheme={{'#f16359';'#f18d59';'#f9ea76';'#acf3be';'#117e9a'}; % 'Strawberry' % Strawberry Orchard Color Palette
    {'#def595';'#cae45b';'#81c828';'#3dc800';'#279700'};  % 'Spring' Spring Growth Color Palette
    {'#ffedad';'#ffd599';'#ffc471';'#ffb93f';'#ffac37'};  % 'Tangerine' Tangerine Color Palette
    {'#00f9ff';'#009fff';'#0078ff';'#005eff';'#0900ff'};  % Blue Vibes
    {'#fe8181';'#fe5757';'#fe2e2e';'#cb2424';'#b62020'}}  % Red pt1


hexCode={};



for i=1:size(cScheme,1);
    for m=1:size(cScheme{1},1)
        if length(cScheme{i}{m})<9;
            hexCode{i}{m}=[cScheme{i}{m}(1),'ff',cScheme{i}{m}(2:end)]
        end
    end
end


num=0;

%results=[];

[ID_row,ID_Column]=size(ref.r_info.ID);

for m=1:ID_row;
    for n=1:ID_Column;
        r=iscellstr(ref.r_info.ID(m,n));
        if ~r;
            %results(or,1)=m;
            %results(or,2)=n;
            ref.r_info.ID{m,n}=' '
        end;
    end;
end
% listRxnColour=listRxn;
column=[];
for r=1:length(listRxn);

%     if numCol>0;
%
%         indRxns=find(ismember(ref.r_info.ID(:,numCol),listRxn{r}));
%         newRxnName=ref.r_info.ID(indRxns,2);
%
%     else

        newRxnName=listRxn{r};
        id=find(ismember(ref.r_info.ID,listRxn(r)))
        if numel(id)>1;
            id=id(1);
        end
% %         if id
% %             [m,n]=size(ref.r_info.ID);
% %             if id>m*(n-1)  % the third column of ref.r_info.ID contains reaction ID; for example: {'re5160','re8','DESAT16_2'}
% %                 newRxnName=ref.r_info.ID{id-2*m}; % newRxnName is defined to be the ID in the first column of ref.r_info.ID.
% %                 column=3;
% %             end
% %         end
        found=0;
        if id

            for rr=1:n;
                if id<m
                    newRxnName=ref.r_info.ID{id};
                    break;
                elseif and(id>rr*m,id<(rr+1)*m);
                    newRxnName=ref.r_info.ID{id-rr*m};
                    break;
                end
            end
        else
            if ~isfield(ref,listRxn{r})
                newRxnName=strcat('R_',listRxn{r});
                if  isempty(strfind(newRxnName,'(e)'))
                    newRxnName=strrep(newRxnName,'(e)','_e');
                end
            end
        end

    if ~isfield(ref,newRxnName)
        disp(listRxn{r});
        fprintf('error ! the listRxn{%d}',r);
        r=r+1
    else
        [rw,cw]=size(ref.(newRxnName).color)
        for  ddr=1:rw
            if ischar(ref.(newRxnName).width{ddr,1}) % if it is char such as ('1.0');then convert it into double;
                ref.(newRxnName).width{ddr,1}=str2double(ref.(newRxnName).width{ddr,1})
            end
            %                 try
            w(1)=ref.(newRxnName).width{ddr,1}
            %             catch
            % %                 disp(w(1))
            %                  disp(newRxnName);
            %                 disp(ref.(newRxnName).width{ddr,1});
            %             end

            %disp(ref.(newRxnName).width(ddr,1));disp('dddd');
            %disp(w(1));
            %              if isempty(w)
            %                  w=0;
            %              end            %
            fprintf('w value is %d\n',w(1));
            if w(1)>=0&&w(1)<=10;  % flux ranges from 2 to 10 will be highligthed
                if p==0;
                    %                     the colours (Hex triplet, e.g.,
                    %                     https://closedxml.codeplex.com/wikipage?title=Excel%20Indexed%20Colors)
                    %% 'FF' as in '#FF0000FF' is the prefix

                    if  w(1)==0
                        colorStr='#ffaed5fc';
                    elseif w(1)>0&&w(1)<=3;
                        colorStr=hexCode{colorScheme}{1} % '#FF0000FF' % flux between 1 and 2 will be highlighted in blue.
                    elseif w(1)>2&&w(1)<=4
                        colorStr=hexCode{colorScheme}{2} % flux between 2 and 5 will be highlighted in pink.

                    elseif w(1)>3&&w(1)<=5;
                        colorStr=hexCode{colorScheme}{3}

                    elseif w(1)>4&&w(1)<=6;
                        colorStr=hexCode{colorScheme}{4}
                    elseif w(1)>6;
                        colorStr=hexCode{colorScheme}{5} % flux between 2 and 5 will be highlighted in red.
                    end
                    if w(1)~=0
                    num=num+1;
                    listRxnColour(num,1)={newRxnName};
                    listRxnColour(num,2)={colorStr};
                    end

                elseif p==1
                    colorStr=listColor{ddr};  % ddr is the row number for each reaction;
                end
                fprintf('p value is %d\n',p);
                colorStr=strrep(colorStr,'#','');
                fprintf('colorStr is %s\n',colorStr);
                if strcmp(newRxnName,'re9103');
                    disp('goodl');
                end

                for  ddc=1:cw
                    ref.(newRxnName).color{ddr,ddc}=colorStr;
                    fprintf('set %s ''s colour to %s \n',newRxnName,ref.(newRxnName).color{ddr,ddc});
                end
            end
        end

    end
end
