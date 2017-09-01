import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Config.Desktop

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.SpawnOnce

import Data.List
import qualified XMonad.StackSet as W

import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.WindowArranger
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Layout.Circle
import XMonad.Layout.Gaps

import XMonad.Actions.CycleWS (prevWS, nextWS)

import System.IO
import Graphics.X11.Xinerama
import Graphics.X11.Xlib.Display
import Graphics.X11.Xlib.Types

myWorkspaces    = ["DEV","WEB","MEDIA","SYS"]
		  
logbar h = do
	dynamicLogWithPP $ tryPP h
tryPP :: Handle -> PP
tryPP h = def
	{ ppOutput		= hPutStrLn h
	, ppCurrent		= dzenColor (fore) (blu1) . pad
	, ppVisible		= dzenColor (fore) (back) . pad
	, ppHidden		= dzenColor (fore) (back) . pad
	, ppHiddenNoWindows	= dzenColor (fore) (back) . pad
	, ppUrgent		= dzenColor (fore) (red1) . pad
	, ppOrder		= \(ws:l:t) -> [ws]
	, ppSep			= ""
	}

-- color --
blu1 = "#528588"
red1 = "#BA5E57"
fore = "#DEE3E0"
back = "#343C48"
-----------

-- layout --
res = ResizableTall 1 (2/100) (1/2) []
ful = (gaps [(U, 42), (R, 8), (L, 8), (D, 8)] $ avoidStruts (noBorders (fullscreenFull Full)))
spacedRes = (gaps [(U, 42), (R, 8), (L, 8), (D, 8)] $ avoidStruts (spacing 2 $ res)) 
layout = spacedRes ||| Circle ||| ful 
------------

-- startup --
startUp :: X()
startUp = do
	spawnOnce "~/.fehbg"
	spawnOnce "xrdb -load .Xresources"
	spawnOnce "autocutsel -selection CLIPBOARD -fork"
	spawnOnce "~/.local/scripts/displayconf.sh"
--	spawnOnce "autocutsel -selection PRIMARY -fork"

-- hotkeys --
hotkeys = [ ("M-`", spawn "rofi -modi run,drun -show drun")
	  , ("<XF86AudioLowerVolume>", spawn "amixer -Mq sset Master 2%-")
	  , ("<XF86AudioRaiseVolume>", spawn "amixer -Mq sset Master 2%+") 
	  , ("<XF86AudioMute>", spawn "amixer -D pulse sset Master 1+ toggle") 
	  , ("M-l", spawn "dm-tool lock") 
	  ]
-------------

main = do
	rects <- openDisplay "" >>= getScreenInfo
	let scrWidth = maximum $ map rect_width rects
	let panelWidth = scrWidth - 420	
      	bar <- spawnPipe "dzen2 -ta l -p -w 400 -y 10 -x 10 -h 26 -e '' "
	info <- spawnPipe $ "conky | dzen2 -x 410 -y 10 -h 26 -w " ++ show panelWidth  ++ " -p -ta r -e '' "
	xmonad $  desktopConfig
		{ modMask = mod4Mask
		,terminal = "xterm"
		,focusFollowsMouse = True
		,borderWidth = 5
		,focusedBorderColor = "#6A555C" --"#404752"
		,normalBorderColor = "#404752" --"#343C48"
		,workspaces = myWorkspaces
		,layoutHook = windowArrange layout
		,logHook = logbar bar
		,startupHook = startUp
	    	}  `additionalKeysP` hotkeys
