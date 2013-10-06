{-# LANGUAGE ForeignFunctionInterface #-}

module System.Statusbar
    (NSMenu, getStatusBarMenu, addMenuItem, addSeparator, setEnabled,
    runLoop) where

import Foreign.Ptr
import Foreign.C.String

import System.Exit

data NSMenu = NSMenu
data NSMenuItem = NSMenuItem

foreign import ccall "wrapper" mkCallback :: IO () -> IO (FunPtr (IO ())) 

foreign import ccall "getStatusBarMenu" getStatusBarMenu :: IO (Ptr NSMenu)
foreign import ccall "addMenuItem" addMenuItemC :: Ptr NSMenu -> CString -> FunPtr (IO ()) -> IO (Ptr NSMenuItem)
foreign import ccall "addSeparator" addSeparator :: Ptr NSMenu -> IO (Ptr NSMenuItem)
foreign import ccall "setEnabled" setEnabled :: Ptr NSMenuItem -> Bool -> IO ()
foreign import ccall "runLoop" runLoop :: IO ()

addMenuItem :: Ptr NSMenu -> String -> IO () -> IO (Ptr NSMenuItem)
addMenuItem menu item cb = do
    wcb <- mkCallback cb
    withCString item (\citem -> addMenuItemC menu citem wcb)

