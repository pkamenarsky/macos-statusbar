{-# LANGUAGE ForeignFunctionInterface #-}

module System.Statusbar
    (NSMenu, getStatusItem, createMenu, addItem, removeItem, removeItemAtIndex,
    setStatusItemTitle, setStatusItemImage,
    getImageWithContentsOfFile, setMenuTitle,
    addSeparator, setEnabled, runLoop) where

import Foreign.Ptr
import Foreign.C.String

data NSMenu = NSMenu
data NSMenuItem = NSMenuItem
data NSStatusItem = NSStatusItem
data NSImage = NSImage

-- remove Ptr from types

foreign import ccall "wrapper" mkCallback :: IO () -> IO (FunPtr (IO ())) 

foreign import ccall "getStatusItem" getStatusItem :: Ptr NSMenu -> IO (Ptr NSStatusItem)
foreign import ccall "setStatusItemTitle" setStatusItemTitleC:: Ptr NSStatusItem -> CString -> IO ()
foreign import ccall "setStatusItemImage" setStatusItemImage:: Ptr NSStatusItem -> Ptr NSImage -> IO ()

foreign import ccall "getImageWithContentsOfFile" getImageWithContentsOfFileC:: CString -> Bool -> IO (Ptr NSImage)

foreign import ccall "createMenu" createMenuC:: CString -> IO (Ptr NSMenu)
foreign import ccall "setMenuTitle" setMenuTitleC:: Ptr NSMenu -> CString -> IO ()

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

getImageWithContentsOfFile :: String -> Bool -> IO (Ptr NSImage)
getImageWithContentsOfFile file template = withCString file (flip getImageWithContentsOfFileC template)

setStatusItemTitle :: Ptr NSStatusItem -> String -> IO ()
setStatusItemTitle item title = withCString title (setStatusItemTitleC item)

createMenu :: String -> IO (Ptr NSMenu)
createMenu title = withCString title createMenuC

setMenuTitle :: Ptr NSMenu -> String -> IO ()
setMenuTitle menu title = withCString title (setMenuTitleC menu)
