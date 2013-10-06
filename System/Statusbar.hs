{-# LANGUAGE ForeignFunctionInterface #-}

module System.Statusbar
    (NSMenu, getStatusBarMenu, addItem, removeItem, removeItemAtIndex,
    addSeparator, setEnabled, runLoop) where

import Foreign.Ptr
import Foreign.C.String

import System.Exit

data NSMenu = NSMenu
data NSMenuItem = NSMenuItem

foreign import ccall "wrapper" mkCallback :: IO () -> IO (FunPtr (IO ())) 

foreign import ccall "getStatusBarMenu" getStatusBarMenu :: IO (Ptr NSMenu)
foreign import ccall "addItem" addItemC :: Ptr NSMenu -> CString -> FunPtr (IO ()) -> IO (Ptr NSMenuItem)
foreign import ccall "removeItem" removeItem :: Ptr NSMenu -> Ptr NSMenuItem -> IO ()
foreign import ccall "removeItemAtIndex" removeItemAtIndex :: Ptr NSMenu -> Int -> IO ()
foreign import ccall "addSeparator" addSeparator :: Ptr NSMenu -> IO (Ptr NSMenuItem)
foreign import ccall "setEnabled" setEnabled :: Ptr NSMenuItem -> Bool -> IO ()
foreign import ccall "runLoop" runLoop :: IO ()

addItem :: Ptr NSMenu -> String -> IO () -> IO (Ptr NSMenuItem)
addItem menu item cb = do
    wcb <- mkCallback cb
    withCString item (\citem -> addItemC menu citem wcb)

