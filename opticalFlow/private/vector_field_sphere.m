function [FieldV]=vector_field_sphere(FV,choice)

%n=size(FV.vertices,1);
switch choice
    case 'theta'
        R=sqrt(FV.vertices(:,1).^2+FV.vertices(:,2).^2);
        %R=(FV.vertices(:,1).^2+FV.vertices(:,2).^2);
        FieldV(:,1)=FV.vertices(:,1).*FV.vertices(:,3);%./R;
        FieldV(:,2)=FV.vertices(:,2).*FV.vertices(:,3);%./R;
        FieldV(:,3)=-R.^2;

    case 'phi'
        FieldV(:,1)=-FV.vertices(:,2);
        FieldV(:,2)=FV.vertices(:,1);
        FieldV(:,3)=0;
        
    otherwise
        disp('Two configurations : theta or phi')

end
        

