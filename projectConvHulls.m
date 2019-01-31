d=4;

R=permn([0 1],d,2:2^d);
%w=permn([0 1],2^d-1);
S=zeros(2^(2^d-1),d);

for i=0:2^(2^(d)-1)-1
    for j=1:d
        S(i+1,j)=S(i+1,j)+bitget(i,1:2^d-1)*R(:,j);
    end
end

% S=w*R;

% SSpan contains all elements of {0,1,..,2^(d-1)}^d except those achieved
% by permutation of an existing element of SSpan, e.g. (4,2,4) and (4,4,2)
% are accounted for in (2,4,4)
% SSpan=permn(int8(0):2^(d-1),d); % used for dictionary to store count of each value in S. Contains {0,1,..,2^(d-1)}^d vectors
% SSpan=[SSpan zeros(length(SSpan(:,1)),1)];
% %SSpan=sortrows(unique(sort(SSpan')','rows'));
% SSpan=sortrows(SSpan);

if (d==2)
    k=convhull(S(:,1),S(:,2));
    plot(S(k,1),S(k,2),S(:,1),S(:,2),'o');
    xlim([-0.5 2.5]);
    ylim([-0.5 2.5]);
    grid on;
    title('Points and Convex Hull of S(2)');
elseif (d==3)
    k=convhull(S(:,1),S(:,2),S(:,3));
    trisurf(k,S(:,1),S(:,2),S(:,3))
    hold on;
    plot3(S(:,1),S(:,2),S(:,3),'o','Color','Red');
    xlim([0 4]);
    ylim([0 4]);
    title('Points and Convex Hull of S(3)');

elseif (d==4)
    k=convhulln(S);
end

%find entries in S that are unique, as these form the hull
S=sortrows(S);
[~, ia,ic]=unique(S,'rows','sorted'); 
h=accumarray(ic,1); % count of each row in S
maph=h(ic);
Sdict=[S,maph]; % last column contains count of that row
Sdict=sortrows(Sdict,d+1);

length(Sdict(:,1))

H=zeros(round(length(Sdict(:,1))/80),d);


for i =1:length(Sdict(:,1))
    if (Sdict(i,d+1)==1)
        H(i,:)=Sdict(i,1:d);
    else
        break
    end
end

for i = length(H(:,1)):-1:1
    if (H(i,1)==0)
        H(i,:)=[];
    else
        break
    end
end

length(H(:,1))


H=sort(H,2);
unique(H,'rows')