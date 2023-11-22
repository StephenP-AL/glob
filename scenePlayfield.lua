local composer = require( "composer" )
local scene = composer.newScene()
 
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
 
---------------------------------------------------------------------------------
 
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
 
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
      
      local pysics = require("physics")
      physics.start()
      physics.setGravity(0,0)

      --Field boundries
      local boundTop = display.newRect(0,0,display.contentWidth,0)
      boundTop.anchorX = 0; boundTop.anchorY = 0
      local boundBottom = display.newRect(0, display.contentHeight, display.contentWidth, 0)
      boundBottom.anchorX = 0; boundBottom.anchorY = 0
      local boundLeft = display.newRect(0, 0,0 , display.contentHeight)
      boundLeft.anchorX = 0; boundLeft.anchorY = 0
      local boundRight = display.newRect(display.contentWidth, 0, 0, display.contentHeight)
      boundRight.anchorX = 0; boundRight.anchorY = 0
      pysics.addBody(boundTop, 'static')
      pysics.addBody(boundBottom, 'static')
      pysics.addBody(boundLeft, 'static')
      pysics.addBody(boundRight, 'static')

      
   
      -- Globule animation
      function squishX(obj)
         transition.to(obj,{transition = easing.inOutSine, xScale = .9, yScale = 1.1, time = 3500, onComplete = squishY})
      end

      function squishY(obj)
         transition.to(obj,{transition = easing.inOutSine, yScale = .9, xScale = 1.1, time = 3500, onComplete = squishX})
      end

      globules = {}

      local function spawnGlobule(type,size,startX,startY,deltaX,deltaY,red,green,blue)
	      local glob = display.newGroup()
	      table.insert(globules,glob)
	      local body = display.newCircle(4,4,size)
	      glob:insert(body)
	      physics.addBody(glob,'dynamic',{bounce=1,density=0})
	      squishX(glob)
	      glob.rotate = math.random() * math.pi
	      glob:applyForce(deltaX,deltaY)
	      glob.x = startX
	      glob.y = startY
	      body:setFillColor(red,green,blue)
	      body:setStrokeColor(.9,.9,.9)
	      body.strokeWidth = 2
	      


      end
	
      for i = 0, 4,1
	do
      		spawnGlobule(1,40,math.random() * display.contentWidth,math.random() * display.contentHeight,4,4,math.random(),math.random(),math.random())
	end

      local glob = display.newCircle(4,4,20)
      glob.x = 190
      glob.y = 20
      glob:setFillColor(.1,.2,.1)
      glob:setStrokeColor(.9,.8,.9)
      glob.strokeWidth = 2
      physics.addBody(glob,'dynamic',{bounce=1,density=0})
      squishX(glob)

      glob.rotate = math.random() * math.pi
      glob:applyForce(4,4)
   
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end
 
-- "scene:destroy()"
function scene:destroy( event )
 
   local sceneGroup = self.view
 
   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end
 
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene
