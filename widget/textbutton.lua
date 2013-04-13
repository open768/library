require "inc.widget.decorator"
require "inc.lib.lib-colours"

cTextButton = {
	className="cTextButton", 
	font=native.systemFont, fontSize=12, 
	delay=250, eventName="onTap", 
	cornerRadius=5, borderWidth=3, 
	upColour="lightgray", upBorderColour="white" ,
	downColour="yellow", downBorderColour="white" 
}
cLibEvents.instrument(cTextButton)

--*******************************************************
function cTextButton:create( psText)
	local oInstance, oText, oDecor
	
	oInstance = cClass.createGroupInstance(self)
	oInstance:prv_init(psText)
	
	return oInstance 
end

--*******************************************************
function cTextButton:prv_init(psText)
	local oText, oDown, oUp
	
	-- create the up and down graphics
	oText = display.newText(psText,0,0,self.fontName, self.fontSize)
	oDown= cWidgetDecorator:create({
			widget=oText,
			cornerRadius=self.cornerRadius,
			backColour=cColours:getRGB(self.downColour), 
			borderColour=cColours:getRGB(self.downBorderColour), 
			borderWidth=self.borderWidth
	})
	oDown.isVisible = false
	self:insert(oDown)
	self.down = oDown
	
	oText = display.newText(psText,0,0,self.fontName, self.fontSize)
	oText:setTextColor(0,0,0)
	oUp = cWidgetDecorator:create({
		widget=oText,
		cornerRadius=self.cornerRadius,
		backColour=cColours:getRGB(self.upColour), 
		borderColour=cColours:getRGB(self.upBorderColour), 
		borderWidth=self.borderWidth
	})
	self:insert(oUp)
	self.up = oUp
	
	-- create the up and down graphics
	self.inTap = false
	self.isUp = true
	self:addEventListener("tap", self)
end

--*******************************************************
function cTextButton:tap( poEvent)
	if self.inTap then return end
	if not self.isUp then return end
	
	self.up.isVisible = false
	self.down.isVisible = true
	
	timer.performWithDelay(self.delay, self, 1)	-- 0 means forever
	
	return true
end

--*******************************************************
function cTextButton:timer(poEvent)
	self.up.isVisible = true
	self.down.isVisible = false
	
	self.inTap = false
	self.isUp = true
	self:notify({name=self.eventName})
end