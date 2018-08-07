function display_on_screen(strt)
%This function will accept an array of strings to display on a textbox on the screen.
%contents the string will have are determined by run_sim.m 

fig = figure(500);
scrsz = get(0,'ScreenSize');
set(fig,'Position', [scrsz(3)/2 scrsz(4)/1.33 scrsz(3)/2 scrsz(4)/4]);
% Create a uicontrol of type "text"
mTextBox = uicontrol('style','text','FontName','Times New Roman','FontSize',18);
mTextBox2 = uicontrol('style','text','FontName','Times New Roman','FontSize',16,'BackgroundColor','r');
mTextBox3 = uicontrol('style','text','FontName','Times New Roman','FontSize',14);
mTextBox4 = uicontrol('style','text','FontName','Times New Roman','FontSize',14);
mTextBox5 = uicontrol('style','text','FontName','Times New Roman','FontSize',14);
mTextBox6 = uicontrol('style','text','FontName','Times New Roman','FontSize',14);
mTextBox7 = uicontrol('style','text','FontName','Times New Roman','FontSize',14);
mTextBox8 = uicontrol('style','text','FontName','Times New Roman','FontSize',14);
mTextBox9 = uicontrol('style','text','FontName','Times New Roman','FontSize',16,'BackgroundColor','b');

bottom = scrsz(4)/4;
pos = [0,(bottom)-20,100,25];
set(mTextBox,'position',pos,'HorizontalAlignment','left','String','Results:');
pos = [0,(bottom)-45,250,25];
set(mTextBox2,'position',pos,'HorizontalAlignment','left','String','Simulation 1 : Racing Bike');
pos = [0,(bottom)-70,400,20];
set(mTextBox3,'position',pos,'HorizontalAlignment','left','String',strt(1,:));
pos = [0,(bottom)-90,400,20];
set(mTextBox4,'position',pos,'HorizontalAlignment','left','String',strt(2,:));
pos = [0,(bottom)-110,450,20];
set(mTextBox5,'position',pos,'HorizontalAlignment','left','String',strt(3,:));
pos = [0,(bottom)-130,400,20];
set(mTextBox6,'position',pos,'HorizontalAlignment','left','String',strt(4,:));
pos = [0,(bottom)-150,400,20];
set(mTextBox7,'position',pos,'HorizontalAlignment','left','String',strt(5,:));
pos = [0,(bottom)-170,500,20];
set(mTextBox8,'position',pos,'HorizontalAlignment','left','String',strt(6,:));

%% Simulation 2
mTextBox10 = uicontrol('style','text','FontName','Times New Roman','FontSize',14);
mTextBox11= uicontrol('style','text','FontName','Times New Roman','FontSize',14);
mTextBox12 = uicontrol('style','text','FontName','Times New Roman','FontSize',14);
mTextBox13 = uicontrol('style','text','FontName','Times New Roman','FontSize',14);
mTextBox14 = uicontrol('style','text','FontName','Times New Roman','FontSize',14);
mTextBox15 = uicontrol('style','text','FontName','Times New Roman','FontSize',14);
mTextBox16 = uicontrol('style','text','FontName','Times New Roman','FontSize',14);

pos = [scrsz(3)/4,(bottom)-45,250,25];
set(mTextBox9,'position',pos,'HorizontalAlignment','left','String','Simulation 2 : Standard Bike');

pos = [scrsz(3)/4,(bottom)-70,400,25];
set(mTextBox10,'position',pos,'HorizontalAlignment','left','String',strt(7,:));

pos = [scrsz(3)/4,(bottom)-90,400,20];
set(mTextBox11,'position',pos,'HorizontalAlignment','left','String',strt(8,:));

pos = [scrsz(3)/4,(bottom)-110,450,20];
set(mTextBox12,'position',pos,'HorizontalAlignment','left','String',strt(9,:));

pos = [scrsz(3)/4,(bottom)-130,400,20];
set(mTextBox13,'position',pos,'HorizontalAlignment','left','String',strt(10,:));

pos = [scrsz(3)/4,(bottom)-150,500,20];
set(mTextBox14,'position',pos,'HorizontalAlignment','left','String',strt(11,:));

pos = [scrsz(3)/4,(bottom)-170,400,20];
set(mTextBox15,'position',pos,'HorizontalAlignment','left','String',strt(12,:));

pos = [scrsz(3)/8,(bottom)-190,600,20];
set(mTextBox16,'position',pos,'HorizontalAlignment','left','String',strt(13,:));



end