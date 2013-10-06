{-# LANGUAGE ForeignFunctionInterface #-}

module System.Statusbar
    (NSMenu, getStatusBarMenu, addMenuItem, runLoop) where

import Foreign.Ptr
import Foreign.C.String

import System.Exit

data NSMenu = NSMenu

foreign import ccall "wrapper" mkCallback :: IO () -> IO (FunPtr (IO ())) 

foreign import ccall "getStatusBarMenu" getStatusBarMenu :: IO (Ptr NSMenu)
foreign import ccall "addMenuItem" addMenuItemC :: Ptr NSMenu -> CString -> FunPtr (IO ()) -> IO ()
foreign import ccall "runLoop" runLoop :: IO ()

addMenuItem :: Ptr NSMenu -> String -> IO () -> IO ()
addMenuItem menu item cb = do
    wcb <- mkCallback cb
    withCString item (\citem -> addMenuItemC menu citem wcb)

