{-# LANGUAGE ForeignFunctionInterface #-}

import Foreign.Ptr
import Foreign.C.String

import System.Exit

data NSMenu = NSMenu

foreign import ccall "wrapper" mkCallback :: IO () -> IO (FunPtr (IO ())) 

foreign import ccall "getStatusBarMenu" getStatusBarMenu :: IO (Ptr NSMenu)
foreign import ccall "addMenuItem" addMenuItem :: Ptr NSMenu -> CString -> FunPtr (IO ()) -> IO ()
foreign import ccall "runLoop" runLoop :: IO ()

addMenuItemH :: Ptr NSMenu -> String -> IO () -> IO ()
addMenuItemH menu item cb = do
    wcb <- mkCallback cb
    withCString item (\citem -> addMenuItem menu citem wcb)

main = do
    putStrLn "This is Haskell"
    menu <- getStatusBarMenu
    addMenuItemH menu "Blabla" (putStrLn "lalal")
    addMenuItemH menu "Quit" exitSuccess
    runLoop
