brew install protobuf boost miniupnpc openssl qrencode berkeley-db4 
brew uninstall qt qt5 qt55 qt52

# TODO: get the qt 5.4.2 dmg pkg installed

export PKG_CONFIG_PATH=/usr/local/qt5/5.4/clang_64/lib/pkgconfig
export PATH=/usr/local/qt5/5.4/clang_64/bin:$PATH
export QT_CFLAGS="-I/usr/local/qt5/5.4/clang_64/lib/QtWebKitWidgets.framework/Versions/5/Headers -I/usr/local/qt5/5.4/clang_64/lib/QtWebView.framework/Versions/5/Headers -I/usr/local/qt5/5.4/clang_64/lib/QtDBus.framework/Versions/5/Headers -I/usr/local/qt5/5.4/clang_64/lib/QtWidgets.framework/Versions/5/Headers -I/usr/local/qt5/5.4/clang_64/lib/QtWebKit.framework/Versions/5/Headers -I/usr/local/qt5/5.4/clang_64/lib/QtNetwork.framework/Versions/5/Headers -I/usr/local/qt5/5.4/clang_64/lib/QtGui.framework/Versions/5/Headers -I/usr/local/qt5/5.4/clang_64/lib/QtCore.framework/Versions/5/Headers -I. -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/System/Library/Frameworks/OpenGL.framework/Versions/A/Headers -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/System/Library/Frameworks/AGL.framework/Headers -I/usr/local/qt5/5.4/clang_64/mkspecs/macx-clang -F/usr/local/qt5/5.4/clang_64/lib"
export QT_LIBS="-F/usr/local/qt5/5.4/clang_64/lib -framework QtWidgets -framework QtGui -framework QtCore -framework DiskArbitration -framework IOKit -framework OpenGL -framework AGL -framework QtNetwork -framework QtWebKit -framework QtWebKitWidgets -framework QtDBus -framework QtWebView"
