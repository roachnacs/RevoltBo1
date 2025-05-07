#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility; 
#include maps\mp\gametypes\_clientids;
#include maps\mp\RevoltMenu\_revoltStructure;
#include maps\mp\RevoltMenu\_revoltFuncs;



menuInit(){
    self thread buttons();
    self thread menuDeath();
    self.menu = SpawnStruct();
    self.hud = SpawnStruct();
    self.scroll = 0;
    self.menuOpen = false;
    self.maxVisibleOptions = 7;
}

buttons()
{
    for(;;){
        command = self waittill_any_return("dpad1", "dpad2", "usereload", "knife");
        if(!self.menuOpen){
            if(self AdsButtonPressed() && command == "dpad2")
                self thread open_menu();
        }
        else{
            if(command == "knife"){
                if(self.menu.parent[self.menu.current] == "exit")
                    self thread close_menu();
                else
                    self _loadMenu(self.menu.parent[self.menu.current]);

                
                wait .07;
            }
            if(command == "usereload"){
                [[self.menu.func[self.menu.current][self.scroll]]](self.menu.arg[self.menu.current][self.scroll], self.menu.arg2[self.menu.current][self.scroll], self.menu.arg3[self.menu.current][self.scroll]);
                self _loadMenu(self.menu.current);
                self thread structure();
                self update_scroller();
                wait .05;
            }
            if(command == "dpad1"){
                self.scroll--;
                self thread update_scroller();
                wait .07;
            }
            if(command == "dpad2"){
                self.scroll++;
                self thread update_scroller();
                wait .07;
            }
        }
        wait .01;
    }
}

Render()
{
    //createRectangle(align, relative, x, y, shader, width, height, color, alpha, sort)
    //createText(font, fontscale, align, relative, x, y, sort, color, alpha, text, glowAlpha, glowColor)
    self.hud.bg = self createRectangle("LEFT", "TOP", 160, 160, "white", 200, 127, (0.2, 0.207843137254902, 0.2), 0.85, -1);
    self.hud.vertright = self createRectangle("LEFT", "TOP", 358, 147, "white", 2, 155, (0.2431372549019608, 0.196078431372549, 0.5607843137254902), 1, 1);
    self.hud.vertleft = self createRectangle("LEFT", "TOP", 160, 147, "white", 2, 155, (0.2431372549019608, 0.196078431372549, 0.5607843137254902), 1, 1);
    self.hud.TopBanner = self createRectangle("LEFT", "TOP", 160, 86, "emblem_bg_cemetary", 200, 34, (0.2431372549019608, 0.196078431372549, 0.5607843137254902), 1, 0);
    self.hud.horztop = self createRectangle("LEFT", "TOP", 160, 70, "white", 200, 2, (0.2431372549019608, 0.196078431372549, 0.5607843137254902), 1, 1);
    self.hud.horzmid = self createRectangle("LEFT", "TOP", 160, 103, "white", 200, 2, (0.2431372549019608, 0.196078431372549, 0.5607843137254902), 1, 1);
    self.hud.horzbott = self createRectangle("LEFT", "TOP", 160, 224, "white", 200, 2, (0.2431372549019608, 0.196078431372549, 0.5607843137254902), 1, 1);
    self.hud.title = self createText("OBJECTIVE", 1.8, "LEFT", "CENTER", 167, -122, 2, (0.2431372549019608, 0.196078431372549, 0.5607843137254902), 1, self.menu.current);
    self.hud.byLine = self createText("EXTRASMALL", 1, "LEFT", "CENTER", 320, 12, 2, (1, 1, 1), 1, "by roach");
    self.hud.currentLocation = self createText("EXTRASMALL", 1, "RIGHT", "CENTER", 355, -108, 2, (0.2431372549019608, 0.196078431372549, 0.5607843137254902), 1, "(0, 0, 0)");

    /*
    self.hud.bg = self createRectangle("LEFT", "TOP", 160, 135, "white", 170, 190, (0.2, 0.207843137254902, 0.2), 1, -1);
    self.hud.vertright = self createRectangle("LEFT", "TOP", 328, 130, "white", 2, 202, (0.2431372549019608, 0.196078431372549, 0.5607843137254902), 1, 1);
    self.hud.vertleft = self createRectangle("LEFT", "TOP", 160, 130, "white", 2, 202, (0.2431372549019608, 0.196078431372549, 0.5607843137254902), 1, 1);
    self.hud.TopBanner = self createRectangle("LEFT", "TOP", 160, 46, "emblem_bg_cemetary", 170, 33, (0.2431372549019608, 0.196078431372549, 0.5607843137254902), 1, 0);
    self.hud.horztop = self createRectangle("LEFT", "TOP", 160, 30, "white", 170, 2, (0.2431372549019608, 0.196078431372549, 0.5607843137254902), 1, 1);
    self.hud.horzmid = self createRectangle("LEFT", "TOP", 160, 63, "white", 170, 2, (0.2431372549019608, 0.196078431372549, 0.5607843137254902), 1, 1);
    self.hud.horzbott = self createRectangle("LEFT", "TOP", 160, 230, "white", 170, 2, (0.2431372549019608, 0.196078431372549, 0.5607843137254902), 1, 1);
    self.hud.title = self createText("OBJECTIVE", 1.8, "LEFT", "CENTER", 167, -162, 2, (0.2431372549019608, 0.196078431372549, 0.5607843137254902), 1, self.menu.current);
    self.hud.byLine = self createText("EXTRASMALL", 1, "LEFT", "CENTER", 291, 18, 2, (1, 1, 1), 1, "by roach");
    self.hud.currentLocation = self createText("EXTRASMALL", 1, "RIGHT", "CENTER", 327, -148, 2, (0.2431372549019608, 0.196078431372549, 0.5607843137254902), 1, "(0, 0, 0)");
    */
}

OverflowFixInit() {
    level.strings = [];
    level.overflowElem = CreateServerFontString("default", 1.5);
    level.overflowElem setSafeText("");
    level.overflowElem.alpha = 0;
    level thread OverflowFixMonitor();
}

OverflowFixMonitor() {
    while(true) {
        level waittill("string_added");
        if(level.strings.size >= 145) {
            level.overflowElem ClearAllTextAfterHudElem();
            level.strings = [];
            level notify("overflow_fixed");
        }
    }
}

setSafeText(text) {
    self.string = text;
    self SetText(text);
    self thread FixString();
    self AddString(text);
}

AddString(string) {
    level.strings[level.strings.size] = string;
    level notify("string_added");
}

FixString() {
    self notify("new_string");
    self endon("new_string");
    while(isdefined(self)) {
        level waittill("overflow_fixed");
        self SetSafeText(self.string);
    }
}

draw_options()
{
	for(i = 0; i < self.maxVisibleOptions; i++)
	{
		if(isDefined(self.menu.text[self.menu.current][i]))
		self.hud.text[i] = self createText("OBJECTIVE", 1.2, "LEFT", "CENTER", 167, -92 + i * 15, 2, game["colors"]["white"], 1, self.menu.text[self.menu.current][i]);
		self.hud.bool[i] = self createText("OBJECTIVE", 1.2, "RIGHT", "CENTER", 353, -92 + i * 15, 2, (1,1,1), 1, ""); 
	}
}

destroy_options()
{
    for(i = 0; i < self.maxVisibleOptions; i++)
    {
        if(isDefined(self.hud.text[i]))
            self.hud.text[i] destroy();
        if(isDefined(self.hud.bool[i]))
            self.hud.bool[i] destroy();
    }
}

updateLocation()
{
    self endon("disconnect");
    self endon("closed");
    while(isDefined(self.hud.currentLocation) && self.menuOpen == true)
    {
        origin = self.origin;
        self.hud.currentLocation SetSafeText("(" + origin[0] + ", " + origin[1] + ", " + origin[2] + ")");
        wait 2;
    }
}

menuDeath()
{
    self waittill("death");
    self.menuOpen = false;
    self notify("closed");
    self _loadMenu("closed");
    self.hud.title SetSafeText("");
    self thread destroy_huds();
    self thread update_scroller();
    self thread close_menu();    

}

destroy_huds()
{
    self.hud.bg Destroy();
    self.hud.vertright Destroy();
    self.hud.vertleft Destroy();
    self.hud.TopBanner Destroy(); 
    self.hud.horztop Destroy(); 
    self.hud.horzmid Destroy();
    self.hud.horzbott Destroy();
    self.hud.title Destroy(); 
    self.hud.byLine Destroy();
    self.hud.currentLocation Destroy();
    if(isDefined(self.hud.text))
    {
        for(i = 0; i < self.maxVisibleOptions; i++)
        {
            if(isDefined(self.hud.text[i]))
                self.hud.text[i] Destroy();
        }
    }
    if(isDefined(self.hud.bool))
    {
        for(i = 0; i < self.maxVisibleOptions; i++)
        {
            if(isDefined(self.hud.bool[i]))
                self.hud.bool[i] Destroy();
        }
    }
}

_loadMenu(menu)
{
    self thread structure();
    self thread destroy_options();
    self.menu.saveScroll[self.menu.current] = self.scroll;
    self.menu.current = menu;

    if(isDefined(self.menu.saveScroll[menu]))
        self.scroll = self.menu.saveScroll[menu];
    else
        self.scroll = 0;
    
    self thread draw_options();
    self thread update_scroller();
}

update_scroller()
{
    if(self.scroll > self.menu.text[self.menu.current].size - 1)
        self.scroll = 0;
    if(self.scroll < 0)
        self.scroll = self.menu.text[self.menu.current].size - 1;

    self.hud.title SetSafeText(self.menu.current);

    //scroll near the start or a small menu
    if(!isDefined(self.menu.text[self.menu.current][self.scroll - 3]) || self.menu.text[self.menu.current].size <= 7)
    {
        for(i = 0; i < 7; i++)
        {
            if(isDefined(self.menu.text[self.menu.current][i]))
            {
                self.hud.text[i] SetSafeText(self.menu.text[self.menu.current][i]);
                self.hud.bool[i] SetSafeText("");

                if(isDefined(self.menu.toggle[self.menu.current][i]))
                {
                    if(self.menu.toggle[self.menu.current][i])
                        self.hud.bool[i] SetSafeText("on");
                    else
                        self.hud.bool[i] SetSafeText("off");
                }
                else if(isDefined(self.menu.print[self.menu.current][i]))
                {
                    stringValue = self.menu.print[self.menu.current][i];
                    if(!isDefined(stringValue) || stringValue == "")
                        stringValue = "None";
                    self.hud.bool[i] SetSafeText(stringValue);
                }
            }
            else
            {
                self.hud.text[i] SetSafeText("");
                self.hud.bool[i] SetSafeText("");
            }

            if(i == self.scroll)
                self.hud.text[i].color = (0.243, 0.196, 0.560);
            else
                self.hud.text[i].color = (1, 1, 1);
        }
    }
    //scroll in the middle 
    else if(isDefined(self.menu.text[self.menu.current][self.scroll + 3]))
    {
        index = 0;
        for(i = self.scroll - 3; i <= self.scroll + 3; i++)
        {
            if(isDefined(self.menu.text[self.menu.current][i]))
            {
                self.hud.text[index] SetSafeText(self.menu.text[self.menu.current][i]);
                self.hud.bool[index] SetSafeText("");

                if(isDefined(self.menu.toggle[self.menu.current][i]))
                {
                    if(self.menu.toggle[self.menu.current][i])
                        self.hud.bool[index] SetSafeText("on");
                    else
                        self.hud.bool[index] SetSafeText("off");
                }
                else if(isDefined(self.menu.print[self.menu.current][i]))
                {
                    stringValue = self.menu.print[self.menu.current][i];
                    if(!isDefined(stringValue) || stringValue == "")
                        stringValue = "None";
                    self.hud.bool[index] SetSafeText(stringValue);
                }
            }
            else
            {
                self.hud.text[index] SetSafeText("");
                self.hud.bool[index] SetSafeText("");
            }

            if(i == self.scroll)
                self.hud.text[index].color = (0.243, 0.196, 0.560);
            else
                self.hud.text[index].color = (1, 1, 1);
            index++;
        }
    }
    //scroll near the end
    else
    {
        for(i = 0; i < 7; i++)
        {
            optionIndex = self.menu.text[self.menu.current].size + (i - 7);
            if(optionIndex >= self.menu.text[self.menu.current].size)
                optionIndex -= self.menu.text[self.menu.current].size;
            if(optionIndex < 0)
                optionIndex += self.menu.text[self.menu.current].size;

            if(isDefined(self.menu.text[self.menu.current][optionIndex]))
            {
                self.hud.text[i] SetSafeText(self.menu.text[self.menu.current][optionIndex]);
                self.hud.bool[i] SetSafeText("");

                if(isDefined(self.menu.toggle[self.menu.current][optionIndex]))
                {
                    if(self.menu.toggle[self.menu.current][optionIndex])
                        self.hud.bool[i] SetSafeText("on");
                    else
                        self.hud.bool[i] SetSafeText("off");
                }
                else if(isDefined(self.menu.print[self.menu.current][optionIndex]))
                {
                    stringValue = self.menu.print[self.menu.current][optionIndex];
                    if(!isDefined(stringValue) || stringValue == "")
                        stringValue = "None";
                    self.hud.bool[i] SetSafeText(stringValue);
                }
            }
            else
            {
                self.hud.text[i] SetSafeText("");
                self.hud.bool[i] SetSafeText("");
            }

            if(optionIndex == self.scroll)
                self.hud.text[i].color = (0.243, 0.196, 0.560);
            else
                self.hud.text[i].color = (1, 1, 1);
        }
    }
}





add_menu(menu, parent)
{
    self.menu.parent[menu] = parent;
    self.menu.menuCount[menu] = 0;
}

add_sub(menu, text, arg, string)
{
    index = self.menu.menuCount[menu];
    self.menu.text[menu][index] = text;
    self.menu.func[menu][index] = ::_loadMenu;
    self.menu.arg[menu][index] = arg;
    self.menu.print[menu][index] = string;
    self.menu.menuCount[menu] += 1;
}

add_option(menu, text, func, arg, arg2, arg3)
{
    index = self.menu.menuCount[menu];
    self.menu.text[menu][index] = text;
    self.menu.func[menu][index] = func;
    self.menu.arg[menu][index] = arg;
    self.menu.arg2[menu][index] = arg2;
    self.menu.arg3[menu][index] = arg3;
    self.menu.menuCount[menu] += 1;
}

add_bool(menu, text, func, bool, arg, arg2, arg3)
{
    index = self.menu.menuCount[menu];
    self.menu.text[menu][index] = text;
    self.menu.func[menu][index] = func;
    self.menu.arg[menu][index] = arg;
    self.menu.arg2[menu][index] = arg2;
    self.menu.arg3[menu][index] = arg3;
    if(!isDefined(bool))
        self.menu.toggle[menu][index] = undefined;
    else
        self.menu.toggle[menu][index] = bool;
    self.menu.menuCount[menu] += 1;
}

add_string(menu, text, func, string, arg, arg2, arg3)
{
    index = self.menu.menuCount[menu];
    self.menu.text[menu][index] = text;
    self.menu.func[menu][index] = func;
    self.menu.arg[menu][index] = arg;
    self.menu.arg2[menu][index] = arg2;
    self.menu.arg3[menu][index] = arg3;
    self.menu.print[menu][index] = string;
    self.menu.menuCount[menu] += 1;
}

update_last_text()
{
    for(i = 0; i < self.menu.text[self.menu.current].size; i++){
        if(((self.scroll - self.menu.text[self.menu.current].size) + 3) == i)
            self.hud.text[i].color = (0.243, 0.196, 0.560);
        else
            self.hud.text[i].color = (1,1,1);
    }
}

open_menu(){
    self.menuOpen = true;
    self Render();
    self thread updateLocation();
    self _loadMenu("revolt");
    wait .1;
}

close_menu(){
    self.menuOpen = false;
    self notify("closed");
    self _loadMenu("closed");
    self.hud.title SetSafeText("");
    self thread destroy_huds();
    self thread update_scroller();
}


takeequiponopen()
{
    class = self.class;
    class_num = int(class[class.size-1]) - 1;
    equipment = self.custom_class[class_num]["equipment"];
    self.pers["oldequip"] = self getWeaponAmmoStock(equipment);
    self takeWeapon(equipment);
    self SetActionSlot(1, "");
}

redoequiponclose()
{
    class = self.class;
    class_num = int(class[class.size-1]) - 1;
    equipment = self.custom_class[class_num]["equipment"];
    self giveWeapon(equipment);
    self maps\mp\gametypes\_class::setWeaponAmmoOverall(equipment, self.pers["oldequip"]);
    self SetActionSlot(1, "weapon", equipment);
    if(!isDefined(self.pers["equip"]) || !self.pers["equip"])
        self takeequiponopen();
}

createText(font, fontscale, align, relative, x, y, sort, color, alpha, text, glowAlpha, glowColor)
{
    textElem = self CreateFontString(font, fontscale);
    textElem.hideWhenInMenu = true;
    textElem.archived = true;
    textElem.sort = sort;
    textElem.alpha = alpha;
    textElem.color = color;
    textElem.foreground = true;
    if(isDefined(glowAlpha))
        textElem.glowAlpha = glowAlpha;
    if(isDefined(glowColor))
        textElem.glowColor = glowColor;
    textElem setPoint(align, relative, x, y);
    textElem SetSafeText(text);
    return textElem;
}


createRectangle(align, relative, x, y, shader, width, height, color, alpha, sort)
{
    uiElement = NewClientHudElem(self);
    uiElement.elemType = "icon";
    uiElement.children = [];
    uiElement.hideWhenInMenu = true;
    uiElement.archived = true;
    uiElement.width = width;
    uiElement.height = height;
    uiElement.align = align;
    uiElement.relative = relative;
    uiElement.xOffset = 0;
    uiElement.yOffset = 0;
    uiElement.sort = sort;
    uiElement.color = color;
    uiElement.alpha = alpha;
    uiElement.shader = shader;
    uiElement.foreground = true;
    uiElement SetParent(level.uiParent);
    uiElement SetShader(shader, width, height);
    uiElement.hidden = false;
    uiElement SetPoint(align, relative, x, y);
    return uiElement;
}

set_text(text){
    self setText(text);
}

SetPersIfUni(key, value)
{
    if(!isdefined(self.pers[key]))
     {
        self.pers[key] = value;
    }
}

/*test_menu_lines()
{
	self.hudTestText = [];

	baseY = -160;
	lineHeight = 18;

	for(i = 0; i < 11; i++)
	{
		yPos = baseY + i * lineHeight;

		self.hudTestText[i] = self createText("objective", 1.1, "CENTER", "CENTER", 0, yPos, 2, (1, 1, 1), 1, "LINE " + i);
	}
}
*/