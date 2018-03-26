function [ label ]= classify( playerdata,w,b )
    %classify take in the features of one player and use the current w and
    %b values to predict the lable of the player
    %output the label 1/-1
   
    
    distance = dot(playerdata,w)+b;
    if distance < 0
        label = -1;
    else
        label = 1;
    end
end

